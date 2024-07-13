import 'package:flutter/material.dart';
import 'package:kliclounge/constants/gaps.dart';
import 'package:kliclounge/constants/sizes.dart';
import 'package:kliclounge/pages/mainscreeneng.dart';
import 'package:kliclounge/pages/pastdetailscreen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

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
                        ), // Pass the target widget
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
                  const SizedBox(
                    width: 60,
                  ),
                  Text(
                    'KRX  상장기업  IR  라운지',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w600,
                      fontSize: Sizes.size32,
                    ),
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
                          onPressed: () {},
                          child: const Text(
                            '참가신청',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Sizes.size28,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            '최신 IR',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Sizes.size28,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PastDetailScreen(),
                              ), // Pass the target widget
                            );
                          },
                          child: const Text(
                            '지난 IR',
                            style: TextStyle(
                              color: Colors.black,
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
                width: MediaQuery.of(context).size.width, // Ensure full width
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              // Use Stack for positioning elements
              children: [
                // Colored box at the bottom
                Container(
                  color: Colors.cyan, // Change color as desired
                  height: 600.0,
                  width: double.infinity, // Fills entire horizontal space
                ),

                // Center the image within the colored box
                Positioned(
                  top: 0.0, // Adjust vertical position as needed (halfway down)
                  left: 0.0, // Align left
                  right: 0.0, // Align right
                  child: Center(
                    child: SizedBox(
                      width: 1400,
                      height: 600,
                      child: Image.asset(
                        'assets/images/banner3.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Gaps.v96,
            Gaps.v32,
            Center(
              child: SizedBox(
                // width: 1400,
                // height: 600,
                child: Image.asset(
                  'assets/images/main_explain.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Gaps.v96,
            Gaps.v96,
            Gaps.v96,
            Stack(
              children: [
                // Colored box at the bottom
                Container(
                  color: Colors.cyan, // Change color as desired
                  height: 600.0,
                  width: double.infinity, // Fills entire horizontal space
                ),

                // Center the image within the colored box
                Positioned(
                  top: 0.0, // Adjust vertical position as needed (halfway down)
                  left: 0.0, // Align left
                  right: 0.0, // Align right
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 200, vertical: 60),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.asset(
                                  'assets/images/ircompany.jpg',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Gaps.h96,
                          Flexible(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Gaps.v20,
                                const Text(
                                  'KRX 온라인 IR을 통해',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Sizes.size44,
                                      fontWeight: FontWeight.w700),
                                ),
                                const Text(
                                  '글로벌 투자자를 만나보세요',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Sizes.size44,
                                      fontWeight: FontWeight.w700),
                                ),
                                Gaps.v16,
                                const TextField(
                                  decoration: InputDecoration(
                                    hintText: '소속',
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                                Gaps.v16,
                                const TextField(
                                  decoration: InputDecoration(
                                    hintText: '성함',
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                                Gaps.v16,
                                const TextField(
                                  decoration: InputDecoration(
                                    hintText: '이메일',
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                                Gaps.v72,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: Sizes.size16,
                                          horizontal: Sizes.size24,
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.cyan[600],
                                            borderRadius: BorderRadius.circular(
                                              Sizes.size32,
                                            ),
                                            border: Border.all(
                                              color: Colors.white,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.05),
                                                blurRadius: 5,
                                                spreadRadius: 5,
                                              ),
                                            ]),
                                        child: const Text(
                                          '기업 참가 신청',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Gaps.h60,
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: Sizes.size16,
                                          horizontal: Sizes.size24,
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.cyan[600],
                                            borderRadius: BorderRadius.circular(
                                              Sizes.size32,
                                            ),
                                            border: Border.all(
                                              color: Colors.white,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.05),
                                                blurRadius: 5,
                                                spreadRadius: 5,
                                              ),
                                            ]),
                                        child: const Text(
                                          '투자자 참가 신청',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Gaps.v96,
            Gaps.v96,
          ],
        ),
      ),
    );
  }
}
