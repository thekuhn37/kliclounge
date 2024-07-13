from flask import Flask, request, jsonify, send_from_directory
import logging
from flask_cors import CORS
from pytube import YouTube
from youtube_transcript_api import YouTubeTranscriptApi
from youtube_transcript_api.formatters import TextFormatter
import textwrap
import openai
import os
from pathlib import Path

# Define the static folder explicitly
static_folder_path = os.path.abspath("build/web")

app = Flask(__name__, static_folder=static_folder_path)
CORS(app, resources={r"/*": {"origins": "*"}})

openai_api_key = os.getenv("OPENAI_API_KEY")
# print(f"API Key: {openai_api_key}")  # Add this line for debugging
# if not openai_api_key:
#     app.logger.error(
#         "OpenAI API key not found. Please set the OPENAI_API_KEY environment variable."
#     )
# openai.api_key = openai_api_key

# logging.basicConfig(level=logging.DEBUG)


@app.route("/")
def serve_index():
    return send_from_directory(static_folder_path, "index.html")


@app.route("/health")
def health_check():
    return "Server is running"


@app.route("/<path:path>")
def serve_file(path):
    return send_from_directory(static_folder_path, path)


def get_video_id(video_url):
    video_id = video_url.split("v=")[1][:11]
    return video_id


@app.route("/transcript", methods=["POST"])
def get_transcript():
    data = request.get_json()
    video_url = data.get("video_url")
    video_id = get_video_id(video_url)

    try:
        transcript = YouTubeTranscriptApi.get_transcript(video_id, languages=["ko"])
        text_formatter = TextFormatter()
        text_formatted = text_formatter.format_transcript(transcript)
        text_info = text_formatted.replace("\n", " ")
        shorten_text_info = textwrap.shorten(
            text_info, 500, placeholder=" [..이하 생략..]"
        )

        response_data = {
            "full_transcript": text_info,
            "shortened_transcript": shorten_text_info,
        }

        response = jsonify(response_data)
        response.headers["Content-Type"] = "application/json"
        print(response)
        return response
    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route("/ask_openai", methods=["POST"])
def ask_openai():
    data = request.get_json()
    prompt = data.get("prompt")
    question_info = data.get("question_info")

    if not prompt or not question_info:
        return jsonify({"error": "Prompt and question information are required"}), 400

    try:
        response = openai.chat.completions.create(
            model="gpt-3.5-turbo",
            messages=[
                {
                    "role": "system",
                    "content": "You are a helpful assistant specialized in Investor Relations of the listed companies.",
                },
                {"role": "user", "content": f"{prompt}\n\n{question_info}"},
            ],
            max_tokens=800,
        )
        answer = response.choices[0].message.content

        response_data = {
            "answer": answer,
        }

        response = jsonify(response_data)
        response.headers["Content-Type"] = "application/json"
        print(response)
        return response
    except Exception as e:
        app.logger.error(f"Error in ask_openai: {str(e)}")
        return jsonify({"error": str(e)}), 500


if __name__ == "__main__":
    app.run(debug=True)
