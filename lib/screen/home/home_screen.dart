import 'package:flutter/material.dart';
import 'package:gaon/const/app_color.dart';
import 'package:gaon/network/authentication.dart';
import 'package:gaon/screen/home/about_box_screen.dart';
import 'package:gaon/widget/drawer.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'provider/home_provider.dart';

import 'home_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {Key key,
      @required GlobalKey<ScaffoldState> drawerKey,
      @required this.auth,
      @required this.provider})
      : _drawerKey = drawerKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _drawerKey;
  final AuthenticationService auth;
  final HomeProvider provider;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeProvider get provider => widget.provider;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      WidgetsFlutterBinding.ensureInitialized();
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: widget._drawerKey,
      drawer: MyDrawer(
        deviceWidth: deviceWidth,
        auth: widget.auth,
        provider: widget.provider,
      ),
      body: provider.loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : CustomScrollView(
              slivers: [
                HomeAppBar(
                  drawerKey: widget._drawerKey,
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 20),
                    child: Text(
                      '오늘의 택배',
                      style: TextStyle(
                        fontSize: 24,
                        color: AppColor.mainOrangeColor,
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    provider.todayBoxs.sort((a, b) => a.startedAt.compareTo(b.startedAt));
                    return InkWell(
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            maintainState: true,
                            builder: (_) {
                              return AboutBoxScreen(
                                provider: provider,
                                qrText: provider.todayBoxs[index].boxNumber,
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Colors.grey,
                              offset: Offset(3, 3),
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 100,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Container(
                                    width: 70,
                                    child: Text(
                                      'No.${index + 1}',
                                    ),
                                  ),
                                  Text(provider.todayBoxs[index].boxNumber.toString()),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 70,
                                  child: Text(
                                    getBoxStatus(provider.todayBoxs[index].status),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColor.mainOrangeColor,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        provider.todayBoxs[index].customerLocation,
                                        style: TextStyle(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _launchCaller(provider.todayBoxs[index].customerPhoneNum);
                                  },
                                  child: Icon(
                                    MdiIcons.phone,
                                    color: Colors.green,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  MdiIcons.arrowRight,
                                  color: AppColor.mainOrangeColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }, childCount: provider.todayBoxs.length),
                ),
              ],
            ),
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

  String getBoxStatus(String status) {
    if (status == 'W') {
      return '배송대기';
    } else if (status == 'D') {
      return '배송중';
    } else if (status == 'C') {
      return '배송완료';
    } else
      return '-';
  }
}
