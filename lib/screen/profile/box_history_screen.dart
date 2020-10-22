import 'package:flutter/material.dart';
import 'package:gaon/const/app_color.dart';
import 'package:gaon/screen/home/about_box_screen.dart';
import 'package:gaon/screen/home/provider/home_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BoxHistoryScreen extends StatefulWidget {
  @override
  _BoxHistoryScreenState createState() => _BoxHistoryScreenState();
}

class _BoxHistoryScreenState extends State<BoxHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    HomeProvider provider = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        actions: [SizedBox(width: 30)],
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
                "배송내역",
                style: TextStyle(color: AppColor.mainRedColor),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.history,
                color: AppColor.mainOrangeColor,
                size: 30,
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 3,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: provider.month.length,
          itemBuilder: (context, monthIndex) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        provider.month.elementAt(monthIndex),
                        style: TextStyle(
                          color: AppColor.mainOrangeColor,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        MdiIcons.calendar,
                        color: AppColor.mainOrangeColor,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: provider.boxs.length,
                    itemBuilder: (context, index) {
                      if (provider.month.elementAt(monthIndex) ==
                          provider.boxs[index].startedAt.substring(0, 10)) {
                        return InkWell(
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    maintainState: true,
                                    builder: (_) {
                                      return AboutBoxScreen(
                                        provider: provider,
                                        qrText: provider.boxs[index].boxNumber,
                                      );
                                    }));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                            margin: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
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
                                      Text(provider.boxs[index].boxNumber.toString()),
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
                                      child: Text(
                                        provider.boxs[index].completedAt != null
                                            ? provider.boxs[index].completedAt
                                            : '배송중',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColor.mainOrangeColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            provider.boxs[index].status == 'C' ? '배송완료' : '',
                                            style: TextStyle(),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
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
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
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
