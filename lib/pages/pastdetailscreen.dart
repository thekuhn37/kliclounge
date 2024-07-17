import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kliclounge/constants/gaps.dart';
import 'package:kliclounge/constants/sizes.dart';
import 'package:kliclounge/pages/mainscreeneng.dart';
import 'package:url_launcher/url_launcher.dart';

class PastDetailScreen extends StatefulWidget {
  const PastDetailScreen({super.key});

  @override
  State<PastDetailScreen> createState() => _PastDetailScreenState();
}

class _PastDetailScreenState extends State<PastDetailScreen> {
  final String baseUrl = "https://klicirlounge-6a9c5137acb7.herokuapp.com";

  final TextEditingController _controller = TextEditingController();
  String? _transcript;
  String? _shortenTranscript;
  String? _response;

  Future<void> _fetchTranscript(String videoUrl) async {
    final response = await http.post(
      Uri.parse('$baseUrl/transcript'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(
        <String, String>{
          'video_url': videoUrl,
        },
      ),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _transcript = data.containsKey('full_transcript')
            ? data['full_transcript']
            : null;
        _shortenTranscript = data.containsKey('shortened_transcript')
            ? data['shortened_transcript']
            : null;
      });
    } else {
      throw Exception('Failed to load transcript');
    }
  }

  Future<void> _askOpenAI(String prompt) async {
    final response = await http.post(
      Uri.parse('$baseUrl/ask_openai'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'prompt': prompt,
          'question_info': _transcript ?? '',
        },
      ),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(
        () {
          _response = data['answer'];
        },
      );
    } else {
      throw Exception('Failed to get OpenAI response');
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          foregroundColor: Colors.white,
          flexibleSpace: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainScreenEng(),
                        ),
                      );
                    },
                    child: const Text(
                      'ENG',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Sizes.size20,
                      ),
                    ),
                  ),
                  Gaps.h32,
                ],
              ),
              Gaps.v14,
              Row(
                children: [
                  const SizedBox(
                    width: 50,
                  ),
                  Image.asset(
                    'assets/images/krxlogo1.png',
                    height: 50,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                        if (states.contains(WidgetState.pressed)) {
                          return Colors
                              .black; // Color when the button is pressed
                        }
                        return Colors.black; // Default color
                      }),
                    ),
                    child: const Text(
                      'KRX  상장기업  IR  라운지',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: Sizes.size32,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                  const SizedBox(
                    width: 300,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            '소개',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Sizes.size28,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            '참가신청',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Sizes.size28,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            _launchUrl('https://www.youtube.com/@IRTV');
                          },
                          child: const Text(
                            '영상시청',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Sizes.size28,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.cyan,
                            textStyle: const TextStyle(
                              fontSize: Sizes.size28,
                            ),
                          ),
                          child: const Text(
                            '지난 IR',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Sizes.size28,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Gaps.v48,
              Container(
                height: 5,
                color: Colors.cyan,
                width: MediaQuery.of(context).size.width,
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 900,
            ),
            child: Column(
              children: [
                Gaps.v96,
                const Text(
                  '지난 IR - 스크립트 추출 & 번역 서비스(Beta)',
                  style: TextStyle(
                    fontSize: Sizes.size28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gaps.v32,
                const Text(
                  '유튜브 IR 채널 내 과거 IR 영상의 링크주소(예시:https://www.youtube.com/watch?v=-UTPEtkQGGY&t=12s)를\n복사하여 아래 박스에 입력 후 버튼을 클릭 시 스크립트 일부가 표시됩니다. 이후 스크립트요약, 영문번역, 중문번역은 \nOpenAI회사의 챗GPT API를 통하여 화면 아래에 표시됩니다. ',
                  style: TextStyle(fontSize: Sizes.size16),
                ),
                Gaps.v32,
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Youtube Video URL',
                    border: OutlineInputBorder(),
                  ),
                ),
                Gaps.v32,
                ElevatedButton(
                  onPressed: () {
                    _fetchTranscript(_controller.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 12.0,
                    ),
                  ),
                  child: const Text(
                    '스크립트 일부 보기',
                    style:
                        TextStyle(fontSize: Sizes.size20, color: Colors.white),
                  ),
                ),
                if (_shortenTranscript != null) ...[
                  Column(
                    children: [
                      Gaps.v32,
                      Text(
                        '스크립트 일부: $_shortenTranscript',
                        style: const TextStyle(fontSize: Sizes.size18),
                      ),
                      Gaps.v32,
                      Row(
                        children: [
                          Gaps.h32,
                          ElevatedButton(
                            onPressed: () {
                              _askOpenAI(
                                  'Summarize the main contents in 8 sentences only in Korean');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.cyan,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32.0,
                                vertical: 12.0,
                              ),
                            ),
                            child: const Text(
                              '스크립트 요약 보기',
                              style: TextStyle(
                                  fontSize: Sizes.size20, color: Colors.white),
                            ),
                          ),
                          Gaps.h32,
                          ElevatedButton(
                            onPressed: () {
                              _askOpenAI(
                                  'Translate the script as much as 30 sentences in English');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.cyan,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32.0,
                                vertical: 12.0,
                              ),
                            ),
                            child: const Text(
                              '영문으로 번역하기',
                              style: TextStyle(
                                  fontSize: Sizes.size20, color: Colors.white),
                            ),
                          ),
                          Gaps.h32,
                          ElevatedButton(
                            onPressed: () {
                              _askOpenAI(
                                  'Translate the script as much as 30 sentences in Chinese');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.cyan,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32.0,
                                vertical: 12.0,
                              ),
                            ),
                            child: const Text(
                              '중문으로 번역하기',
                              style: TextStyle(
                                  fontSize: Sizes.size20, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
                Gaps.v48,
                if (_response != null) ...[
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Response: $_response',
                        style: const TextStyle(fontSize: Sizes.size18),
                      ),
                      const SizedBox(
                        height: 80,
                      )
                    ],
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
