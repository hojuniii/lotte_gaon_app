import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:gaon/const/app_color.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int pageNum = 0;
  final PageController pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.close,
              color: AppColor.mainRedColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Center(
        child: Container(
          height: height,
          width: width,
          padding: const EdgeInsets.symmetric(
            // horizontal: 20,
            vertical: 80,
          ),
          child: Stack(
            children: [
              PageView(
                onPageChanged: (value) {
                  setState(() {
                    pageNum = value;
                  });
                },
                controller: pageController,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'asset/intro1.png',
                          height: height * 0.3,
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Image.asset(
                          'asset/logo_comment.png',
                          width: width * 0.6,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          '롯데와 함께 만들어가는\n롯데와 함께 가는 마을',
                          style: TextStyle(
                            height: 1.5,
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'asset/intro2.png',
                          height: height * 0.3,
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Image.asset(
                          'asset/logo_comment.png',
                          width: width * 0.6,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          '택배 하나에 온기 하나\n당신의 손길을 더하세요',
                          style: TextStyle(
                            height: 1.5,
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'asset/intro3.png',
                          height: height * 0.3,
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Image.asset(
                          'asset/logo_comment.png',
                          width: width * 0.6,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          '따뜻한 손길이 더해져\n온기로가득한 세상을 함께해요',
                          style: TextStyle(
                            height: 1.5,
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: DotsIndicator(
                  dotsCount: 3,
                  position: pageNum.toDouble(),
                  decorator: DotsDecorator(
                    color: Colors.black26, // Inactive color
                    activeColor: Color(0xffda281b),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
