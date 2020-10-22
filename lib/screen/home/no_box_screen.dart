import 'package:flutter/material.dart';
import 'package:gaon/const/app_color.dart';

class NoBoxScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [SizedBox(width: 40)],
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "택배정보",
                style: TextStyle(color: AppColor.mainRedColor),
              ),
              SizedBox(
                width: 10,
              ),
              Image.asset(
                'asset/icon_box.png',
                color: AppColor.mainRedColor,
                width: 24,
                height: 24,
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            color: AppColor.mainRedColor,
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            }),
      ),
      body: Container(
        child: Center(
          child: Text('존재하지 않는 택배입니다 '),
        ),
      ),
    );
  }
}
