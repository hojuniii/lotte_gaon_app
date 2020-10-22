import 'package:flutter/material.dart';
import 'package:gaon/const/app_color.dart';
import 'package:gaon/network/authentication.dart';
import 'package:gaon/screen/home/provider/home_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key key,
    @required this.deviceWidth,
    @required this.auth,
    @required this.provider,
  }) : super(key: key);

  final double deviceWidth;
  final AuthenticationService auth;
  final HomeProvider provider;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        width: deviceWidth * 0.6,
        padding: EdgeInsets.only(
          top: 80,
          left: 20,
          bottom: 40,
          right: 20,
        ),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '${provider.user.profile.nickname}',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                  ),
                ),
                Text(
                  ' 님 반갑습니다',
                  style: TextStyle(
                    color: AppColor.mainGreyColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Divider(
              height: 40,
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/profile', arguments: [provider, auth]);
              },
              child: Row(
                children: [
                  Icon(
                    MdiIcons.account,
                    color: AppColor.mainOrangeColor,
                    size: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '마이페이지',
                    style: TextStyle(
                      color: AppColor.mainGreyColor,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/box_history', arguments: provider);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.history,
                    color: AppColor.mainOrangeColor,
                    size: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '배송내역',
                    style: TextStyle(
                      color: AppColor.mainGreyColor,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () async {
                  await auth.logOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', ModalRoute.withName('/login'));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      MdiIcons.logout,
                    ),
                    Text(
                      '로그아웃',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
