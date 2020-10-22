import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gaon/const/app_color.dart';
import 'package:gaon/screen/home/about_box_screen.dart';
import 'package:gaon/screen/home/no_box_screen.dart';
import 'package:gaon/widget/custom_alert_dialog.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'provider/home_provider.dart';

class HomeAppBar extends StatefulWidget {
  final GlobalKey<ScaffoldState> drawerKey;

  const HomeAppBar({Key key, this.drawerKey}) : super(key: key);

  @override
  _HomeAppBarState createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  initState() {
    super.initState();
  }

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var cameraState = 'qw';
  QRViewController controller;
  String qrText;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  bool isScaned = false;

  @override
  Widget build(BuildContext context) {
    HomeProvider provider = Provider.of<HomeProvider>(context);
    void _onQRViewCreated(QRViewController controller) async {
      if (isScaned) return;
      this.controller = controller;
      controller.scannedDataStream.listen((scanData) async {
        qrText = scanData;
        controller.pauseCamera();
        Navigator.pop(context);
        try {
          await provider.getBox(qrText);

          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return AboutBoxScreen(
              provider: provider,
              qrText: qrText,
            );
          }));
        } catch (e) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return NoBoxScreen();
          }));
        }

        // Navigator.pushReplacementNamed(context, '/about_box_screen', arguments: [qrText, provider]);

        controller.dispose();
      });
    }

    double deviceWidth = MediaQuery.of(context).size.height;
    double deviceHeight = MediaQuery.of(context).size.height;

    return SliverAppBar(
      actions: [
        IconButton(
          icon: Icon(
            MdiIcons.refresh,
            size: 32,
          ),
          onPressed: () async {
            await provider.refesh();
          },
        )
      ],
      expandedHeight: deviceHeight * 0.5,
      elevation: 0,
      stretch: true,
      pinned: true,
      backgroundColor: Colors.white, // actionsIconTheme: IconThemeData(),
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: Colors.white,
          size: 32,
        ),
        onPressed: () {
          widget.drawerKey.currentState.openDrawer();
        },
      ),
      floating: false,

      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: Stack(
          children: [
            Image.asset(
              'asset/profile_background.png',
              width: deviceWidth,
              fit: BoxFit.cover,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                provider.profile.profileImage == null
                    ? Image.asset(
                        'asset/profile_none.png',
                        height: 150,
                        width: 150,
                      )
                    : Container(
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(100),
                        //   border: Border.all(color: Colors.white, width: 3),
                        // ),
                        child: ClipOval(
                          child: CachedNetworkImage(
                            placeholder: (context, url) {
                              return Image.asset(
                                'asset/profile_none.png',
                                height: 150,
                                width: 150,
                              );
                            },
                            fit: BoxFit.fill,
                            height: deviceHeight * 0.2,
                            width: deviceWidth * 0.2,
                            imageUrl: provider.profile.profileImage,
                          ),
                        ),
                      ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${provider.user.profile.nickname}님 ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '오늘의 택배',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Text(
                                '${provider.completedBoxCount}/${provider.todayBoxs.length}개',
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Image.asset(
                                'asset/icon_box.png',
                                width: 40,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    GestureDetector(
                      onTap: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return WillPopScope(
                            onWillPop: () async {
                              return false;
                            },
                            child: Scaffold(
                              drawerEnableOpenDragGesture: false,
                              appBar: AppBar(
                                title: Text(
                                  '택배 QR스캔',
                                  style: TextStyle(color: AppColor.mainRedColor),
                                ),
                                backgroundColor: Colors.white,
                                leading: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: AppColor.mainRedColor,
                                  ),
                                  onPressed: () {
                                    controller?.pauseCamera();
                                    controller?.dispose();
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              body: QRView(
                                key: qrKey,
                                onQRViewCreated: _onQRViewCreated,
                                overlay: QrScannerOverlayShape(
                                  borderColor: AppColor.mainOrangeColor,
                                  borderRadius: 10,
                                  borderLength: 30,
                                  borderWidth: 10,
                                  cutOutSize: 300,
                                ),
                              ),
                            ),
                          );
                        }));
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white,
                              width: 4,
                            )),
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              '배송\n하기',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            Icon(
                              MdiIcons.qrcode,
                              color: Colors.white,
                              size: 50,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void qrDialog(String str) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          content: Container(
              padding: EdgeInsets.fromLTRB(12, 15, 12, 0),
              height: 120,
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text(
                      str + '님의 택배입니다',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
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
                              color: Colors.black54,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )),
        );
      },
    );
  }
}
