import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gaon/const/app_color.dart';
import 'package:gaon/widget/dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../home/provider/home_provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  File _image;
  Map<String, List<String>> placeMap = {
    '강남구': ['신사동 래미안', '압구정동 어울림', '대치동 더샵', '논현동 신도브레뉴', '일원동 중앙하이츠빌'],
    '송파구': ['오륜동 미지엔', '잠실2동 좋은집', '송파1동 꿈에그린'],
    '강동구': ['천호1동 SKview', '강일동 Xi', '상일동 몰라', '암사2동 현진에버빌'],
    '노원구': ['공릉1동 e편한세상', '상계1동 미소지음', '상계3.4동 래미안', '하계1동 중앙하이츠빌'],
    '용산구': ['남영동 경남아너스빌', '용문동 꿈에그린', '이촌1동 아이파크', '서빙고동 e편한세상', '남영동 더샵']
  };
  String firstPlace = '강남구';
  String secondPlace = '신사동 래미안';

  @override
  Widget build(BuildContext context) {
    List<dynamic> args = ModalRoute.of(context).settings.arguments;
    HomeProvider provider = args[0];
    Future<void> getImageGallery() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
      });
      provider.profileImage = _image;
    }

    return Form(
      key: _formKey,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "프로필수정",
              style: TextStyle(color: AppColor.mainRedColor),
            ),
            iconTheme: IconThemeData(
              size: 30,
              color: AppColor.mainRedColor,
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          drawerEnableOpenDragGesture: false,
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 30,
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      getImageGallery();
                    },
                    child: Stack(
                      children: [
                        _image == null
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(color: AppColor.mainRedColor, width: 3),
                                ),
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    placeholder: (context, url) {
                                      return Image.asset(
                                        'asset/profile_none.png',
                                        height: 150,
                                        width: 150,
                                      );
                                    },
                                    fit: BoxFit.cover,
                                    height: 160,
                                    width: 160,
                                    imageUrl: provider.profile.profileImage,
                                  ),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: AppColor.mainRedColor, width: 3)),
                                child: ClipOval(
                                  child: Image.file(
                                    _image,
                                    fit: BoxFit.cover,
                                    width: 180,
                                    height: 180,
                                  ),
                                ),
                              ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Icon(
                            MdiIcons.camera,
                            color: AppColor.mainRedColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    provider.user.profile.nickname + ' 님,\n함께해주셔서 감사합니다',
                    style: TextStyle(
                      height: 1.5,
                      letterSpacing: 1.6,
                      color: AppColor.mainRedColor,
                      fontSize: 18,
                      // fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    initialValue: provider.profile.nickname,
                    onSaved: (nickName) {
                      provider.nickName = nickName;
                    },
                    cursorColor: AppColor.mainRedColor,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: AppColor.mainGreyColor,
                        fontSize: 16,
                      ),
                      icon: Icon(
                        MdiIcons.account,
                        color: AppColor.mainGreyColor,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0),
                        borderRadius: BorderRadius.circular(
                          30,
                        ),
                      ),
                      hintText: '별명을 입력해주세요',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: AppColor.mainGreyColor,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        '거주지',
                        style: TextStyle(
                          color: AppColor.mainGreyColor,
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      Text(
                        provider.profile.servicePlace,
                        style: TextStyle(
                          color: AppColor.mainGreyColor,
                          fontSize: 16,
                        ),
                      ),
                      // DropdownButton<String>(
                      //   value: firstPlace,
                      //   iconSize: 24,
                      //   elevation: 10,
                      //   style: TextStyle(color: AppColor.mainRedColor, fontSize: 16),
                      //   underline: Container(
                      //     height: 2,
                      //     color: AppColor.mainRedColor,
                      //   ),
                      //   onChanged: (String newValue) {
                      //     setState(() {
                      //       firstPlace = newValue;
                      //       secondPlace = placeMap[firstPlace][0];
                      //     });
                      //   },
                      //   items: <String>['강남구', '송파구', '강동구', '노원구', '용산구']
                      //       .map<DropdownMenuItem<String>>((String value) {
                      //     return DropdownMenuItem<String>(
                      //       value: value,
                      //       child: Text(value),
                      //     );
                      //   }).toList(),
                      // ),
                      // SizedBox(
                      //   width: 10,
                      // ),
                      // DropdownButton<String>(
                      //   value: secondPlace,
                      //   iconSize: 24,
                      //   elevation: 10,
                      //   style: TextStyle(color: AppColor.mainRedColor, fontSize: 16),
                      //   underline: Container(
                      //     height: 2,
                      //     color: AppColor.mainRedColor,
                      //   ),
                      //   onChanged: (String newValue) {
                      //     setState(() {
                      //       secondPlace = newValue;
                      //     });
                      //   },
                      //   items: placeMap[firstPlace].map<DropdownMenuItem<String>>((String value) {
                      //     return DropdownMenuItem<String>(
                      //       value: value,
                      //       child: Text(value),
                      //     );
                      //   }).toList(),
                      // ),
                      // SizedBox(
                      //   width: 10,
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: 200,
                    height: 60,
                    child: RaisedButton(
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 2,
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        elevation: 0,
                        onPressed: () async {
                          _formKey.currentState.save();

                          if (provider.servicePlace == null) {
                            provider.servicePlace = provider.profile.servicePlace;
                          }

                          if (provider.nickName.length == 0 || provider.servicePlace == null) {
                            return showDialogByText(context, '모든 항목을 입력해주세요');
                          } else {
                            var res = await provider.updateProfile();
                            if (res)
                              Navigator.pushReplacementNamed(context, '/init');
                            else
                              showDialogByText(context, '오류가 발생했습니다');
                          }
                        },
                        color: Colors.white,
                        child: Text(
                          '수정',
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColor.mainRedColor,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
