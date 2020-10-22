import 'package:flutter/material.dart';
import 'package:gaon/const/app_color.dart';
import 'package:gaon/screen/home/provider/home_provider.dart';
import 'package:gaon/widget/custom_alert_dialog.dart';
import 'package:gaon/widget/dialog.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutBoxScreen extends StatefulWidget {
  const AboutBoxScreen({Key key, this.qrText, this.provider, this.drawerKey}) : super(key: key);

  @override
  _AboutBoxScreenState createState() => _AboutBoxScreenState();
  final String qrText;
  final HomeProvider provider;
  final GlobalKey<ScaffoldState> drawerKey;
}

class _AboutBoxScreenState extends State<AboutBoxScreen> {
  HomeProvider get provider => widget.provider;
  String get qrText => widget.qrText;
  GlobalKey<ScaffoldState> get _key => widget.drawerKey;

  @override
  void initState() {
    super.initState();
    provider.loading = true;
    provider.getBox(qrText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [SizedBox(width: 40)],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: AppColor.mainRedColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
      ),
      key: _key,
      body: ChangeNotifierProvider<HomeProvider>(
        create: (_) => HomeProvider(),
        key: _key,
        child: Consumer<HomeProvider>(builder: (context, _, child) {
          if (provider.loading)
            return Container(
              child: Center(child: CircularProgressIndicator()),
            );
          else
            return Container(
              padding: EdgeInsets.symmetric(
                vertical: 40,
                horizontal: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          '송장번호',
                          style: TextStyle(
                            color: AppColor.mainOrangeColor,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        provider.capturedBox.boxNumber,
                        style: TextStyle(
                          color: AppColor.mainGreyColor,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          '받는 분 이름',
                          style: TextStyle(
                            color: AppColor.mainOrangeColor,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        provider.user.id == provider.capturedBox.userId
                            ? provider.capturedBox.customerName + ' 이웃님'
                            : '*** 이웃님',
                        style: TextStyle(
                          color: AppColor.mainGreyColor,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          '주소',
                          style: TextStyle(
                            color: AppColor.mainOrangeColor,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Text(
                        provider.user.id == provider.capturedBox.userId
                            ? provider.capturedBox.customerLocation
                            : '***',
                        style: TextStyle(
                          color: AppColor.mainGreyColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          '연락처',
                          style: TextStyle(
                            color: AppColor.mainOrangeColor,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Text(
                        provider.user.id == provider.capturedBox.userId
                            ? provider.capturedBox.customerPhoneNum
                            : '***',
                        style: TextStyle(
                          color: AppColor.mainGreyColor,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          '배송출발',
                          style: TextStyle(
                            color: AppColor.mainOrangeColor,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Text(
                        provider.capturedBox.startedAt != null
                            ? provider.capturedBox.startedAt?.substring(5, 19)
                            : '-',
                        style: TextStyle(
                          color: AppColor.mainGreyColor,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          '배송도착',
                          style: TextStyle(
                            color: AppColor.mainOrangeColor,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Text(
                        provider.capturedBox.completedAt != null
                            ? provider.capturedBox.completedAt?.substring(5, 19)
                            : '-',
                        style: TextStyle(
                          color: AppColor.mainGreyColor,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 21,
                  ),
                  SizedBox(height: 30),
                  provider.user.id != provider.capturedBox.userId
                      ? Text(
                          '해당 택배의 담당자만 택배정보를 볼 수 있습니다',
                          style: TextStyle(
                            color: AppColor.mainOrangeColor,
                            fontSize: 14,
                          ),
                        )
                      : Text(''),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            if (provider.user.id != provider.capturedBox.userId) {
                              showDialogByText(context, '담당 택배 기사가 아닙니다');
                              return;
                            }
                            _launchCaller(provider.capturedBox.customerPhoneNum);
                          },
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppColor.mainRedColor,
                                  width: 4,
                                )),
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  '전화\n하기',
                                  style: TextStyle(
                                    color: AppColor.mainRedColor,
                                    fontSize: 20,
                                  ),
                                ),
                                Icon(
                                  MdiIcons.phone,
                                  color: AppColor.mainRedColor,
                                  size: 50,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            if (provider.capturedBox.status == 'W') {
                              showDialogSetBox(context, '배송을 시작하겠습니까?');
                            } else if (provider.capturedBox.status == 'D') {
                              showDialogSetBox(context, '배송을 완료합니다');
                            } else {
                              showDialogByText(context, '완료된 택배입니다');
                              return;
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppColor.mainRedColor,
                                  width: 4,
                                )),
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  setButtonState(provider.capturedBox.status),
                                  style: TextStyle(
                                    color: AppColor.mainRedColor,
                                    fontSize: 20,
                                  ),
                                ),
                                Icon(
                                  setIconState(provider.capturedBox.status),
                                  color: AppColor.mainRedColor,
                                  size: 50,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
        }),
      ),
    );
  }

  void showDialogSetBox(context, String text) async {
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "취소",
                            style: TextStyle(
                              color: AppColor.mainRedColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        FlatButton(
                          onPressed: () async {
                            bool res = await provider.setBox(provider.capturedBox.boxNumber);
                            if (res) {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/init', ModalRoute.withName('/init'));
                            } else {
                              showDialogByText(context, '오류가 발생했습니다');
                            }
                          },
                          child: Text(
                            "확인",
                            style: TextStyle(
                              color: AppColor.mainRedColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )),
        );
      },
    );
  }

  void _launchCaller(String phoneNum) async {
    if (phoneNum == null) return;
    final String url = 'tel:' + phoneNum;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String setButtonState(String status) {
    if (status == 'W')
      return '배송\n시작';
    else if (status == 'D')
      return '완료\n하기';
    else if (status == 'C')
      return '완료';
    else
      return '-';
  }

  IconData setIconState(String status) {
    if (status == 'W')
      return MdiIcons.runFast;
    else if (status == 'D')
      return MdiIcons.checkboxMarkedCircle;
    else if (status == 'C') return MdiIcons.checkboxMarkedCircle;
  }
}
