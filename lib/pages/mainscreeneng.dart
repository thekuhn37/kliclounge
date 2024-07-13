import 'package:flutter/material.dart';
import 'package:kliclounge/constants/gaps.dart';
import 'package:kliclounge/constants/sizes.dart';

class MainScreenEng extends StatelessWidget {
  const MainScreenEng({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'KOR',
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
                const Text(
                  'KRX Listed Company IR Lounge',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: Sizes.size32,
                  ),
                ),
                const SizedBox(
                  width: 200,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'About',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Sizes.size28,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Apply',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Sizes.size28,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Recent IR',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Sizes.size28,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Last IR',
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
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                      'assets/images/bannereng.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // const Text('최근 관심 집중 IR')
        ],
      ),
    );
  }
}
