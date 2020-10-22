import 'package:flutter/material.dart';
import 'package:gaon/const/app_color.dart';
import 'package:gaon/widget/custom_alert_dialog.dart';

void showDialogByText(context, String text) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return CustomAlertDialog(
        content: Container(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
            height: 120,
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(
                    "$text",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "닫기",
                        style: TextStyle(
                          color: AppColor.mainRedColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )),
      );
    },
  );
}

void showDialogSuccessRegister(context, String text) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return CustomAlertDialog(
        content: Container(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
            height: 120,
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(
                    "$text",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/intro');
                      },
                      child: Text(
                        "시작하기",
                        style: TextStyle(
                          color: AppColor.mainRedColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )),
      );
    },
  );
}
