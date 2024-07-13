from flask import Flask, request, jsonify
from flask_cors import CORS
from pytube import YouTube
from youtube_transcript_api import YouTubeTranscriptApi
from youtube_transcript_api.formatters import TextFormatter
import textwrap
import openai

app = Flask(__name__)
CORS(app, resources={r"/*": {"origins": "*"}})

# openai.api_key ="Type in your keys"


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
            text_info, 200, placeholder=" [..이하 생략..]"
        )

        response_data = {
            "full_transcript": text_info,
            "shortened_transcript": shorten_text_info,
        }

        response = jsonify(response_data)
        response.headers["Content-Type"] = "application/json"
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
        response = openai.ChatCompletion.create(  # type: ignore
            model="gpt-3.5-turbo",
            messages=[
                {
                    "role": "system",
                    "content": "You are a helpful assistant specialized in Investor Relations of the listed companies.",
                },
                {"role": "user", "content": f"{prompt}\n\n{question_info}"},
            ],
            max_tokens=300,
        )
        answer = response.choices[0].message["content"].strip()

        response_data = {
            "answer": answer,
        }

        response = jsonify(response_data)
        response.headers["Content-Type"] = "application/json"
        return response
    except Exception as e:
        return jsonify({"error": str(e)}), 500


if __name__ == "__main__":
    app.run(debug=True)
