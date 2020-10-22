import 'package:flutter/material.dart';
import 'package:gaon/const/app_color.dart';
import 'package:gaon/screen/intro_screen.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  void _showAddProductTip(var provider) {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return IntroScreen();
        },
        fullscreenDialog: true));
  }

  var pageNum = 0;
  bool isFirst = false;
  final PageController pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.mainRedColor,
      body: PageView(
        controller: pageController,
        onPageChanged: (value) {
          setState(() {
            pageNum = value;
          });
        },
        children: [
          Container(
            padding: EdgeInsets.only(
              top: deviceHeight * 0.15,
              bottom: 40,
            ),
            color: AppColor.mainRedColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      'asset/together.png',
                      height: deviceHeight * 0.1,
                    ),
                    SizedBox(
                      width: 20,
                    )
                  ],
                ),
                Image.asset(
                  'asset/lotte_white_left.png',
                  height: deviceHeight * 0.4,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: deviceHeight * 0.15,
              bottom: 40,
            ),
            color: AppColor.mainRedColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'asset/do.png',
                      height: deviceHeight * 0.1,
                    ),
                    SizedBox(
                      width: 20,
                    )
                  ],
                ),
                Container(
                  width: deviceWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 20),
                        width: 250,
                        height: 50,
                        child: RaisedButton(
                          focusColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 2,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          elevation: 0,
                          onPressed: () async {
                            _showAddProductTip(context);
                          },
                          color: AppColor.mainRedColor,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              '감사드려요',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 20),
                        width: 250,
                        height: 50,
                        child: RaisedButton(
                          focusColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          elevation: 0,
                          onPressed: () async {
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              '로그인 하기',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  'asset/lotte_white_right.png',
                  height: deviceHeight * 0.4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
