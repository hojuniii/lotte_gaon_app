import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gaon/const/app_color.dart';
import 'package:gaon/network/authentication.dart';
import 'package:gaon/widget/dialog.dart';
import 'package:gaon/widget/drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import '../home/provider/home_provider.dart';

class SetProfileScreen extends StatefulWidget {
  const SetProfileScreen(
      {Key key, GlobalKey<ScaffoldState> drawerKey, @required this.auth, @required this.provider})
      : _drawerKey = drawerKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _drawerKey;
  final AuthenticationService auth;
  final HomeProvider provider;

  @override
  _SetProfileScreenState createState() => _SetProfileScreenState();
}

class _SetProfileScreenState extends State<SetProfileScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  File _image;
  HomeProvider get provider => widget.provider;
  Future<void> getImageGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    provider.profileImage = _image;
  }

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
    double deviceWidth = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              size: 30,
              color: AppColor.mainRedColor,
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          drawerEnableOpenDragGesture: false,
          key: widget._drawerKey,
          drawer: MyDrawer(
            deviceWidth: deviceWidth,
            auth: widget.auth,
            provider: widget.provider,
          ),
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
                        _image != null
                            ? Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      width: 3,
                                      color: AppColor.mainRedColor,
                                    )),
                                child: ClipOval(
                                  child: Image.file(
                                    _image,
                                    fit: BoxFit.cover,
                                    width: 180,
                                    height: 180,
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 90,
                                backgroundImage: AssetImage(
                                  'asset/profile_none.png',
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
                    '프로필을 설정해주세요',
                    style: TextStyle(
                      letterSpacing: 1.6,
                      color: AppColor.mainRedColor,
                      fontSize: 18,
                      // fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    onSaved: (nickName) {
                      provider.nickName = nickName;
                    },
                    cursorColor: AppColor.mainRedColor,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: AppColor.mainGreyColor,
                        fontSize: 14,
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
                  TextFormField(
                    onSaved: (birth) {
                      provider.birth = birth;
                      String year = birth.substring(0, 4);
                      provider.age = DateTime.now().year - int.parse(year) + 1;
                    },
                    cursorColor: AppColor.mainRedColor,
                    autocorrect: false,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: AppColor.mainGreyColor,
                        fontSize: 14,
                      ),
                      icon: Icon(
                        MdiIcons.calendar,
                        color: AppColor.mainGreyColor,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0),
                        borderRadius: BorderRadius.circular(
                          30,
                        ),
                      ),
                      hintText: '생년월일 8자리 ex)19560101',
                    ),
                  ),
                  Text('65세이상 사용자만 가입 가능합니다',
                      style: TextStyle(
                        height: 1.6,
                        color: AppColor.mainGreyColor,
                      )),
                  SizedBox(
                    height: 10,
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
                      DropdownButton<String>(
                        value: firstPlace,
                        iconSize: 24,
                        elevation: 10,
                        style: TextStyle(color: AppColor.mainRedColor, fontSize: 16),
                        underline: Container(
                          height: 2,
                          color: AppColor.mainRedColor,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            firstPlace = newValue;
                            secondPlace = placeMap[firstPlace][0];
                          });
                        },
                        items: <String>['강남구', '송파구', '강동구', '노원구', '용산구']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      DropdownButton<String>(
                        value: secondPlace,
                        iconSize: 24,
                        elevation: 10,
                        style: TextStyle(color: AppColor.mainRedColor, fontSize: 16),
                        underline: Container(
                          height: 2,
                          color: AppColor.mainRedColor,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            secondPlace = newValue;
                          });
                        },
                        items: placeMap[firstPlace].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
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
                        print(provider.age);
                        if (provider.age < 65) {
                          return showDialogByText(context, '1956년생 이전 사용자만 가입 가능합니다');
                        }
                        if (provider.nickName == null ||
                            provider.birth == null ||
                            provider.birth.toString().length != 8) {
                          return showDialogByText(context, '모든 항목을 정확히 입력해주세요');
                        } else {
                          provider.servicePlace = '서울 ${firstPlace} ${secondPlace}';

                          var res = await provider.updateProfile();
                          if (res)
                            Navigator.pushReplacementNamed(context, '/init');
                          else
                            showDialogByText(context, '오류가 발생했습니다');
                        }
                      },
                      color: Colors.white,
                      child: Consumer<HomeProvider>(builder: (context, _, child) {
                        if (provider.loading)
                          return CircularProgressIndicator();
                        else
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 28),
                            child: Text(
                              '완료',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
