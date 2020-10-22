import 'package:flutter/material.dart';
import 'package:gaon/const/app_color.dart';
import 'package:gaon/screen/register/provider/register_provider.dart';
import 'package:gaon/widget/dialog.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String phone;
  String password;
  String passwordAgain;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        // resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            '회원가입',
            style: TextStyle(
              fontFamily: 'lotte_happy_light',
              color: AppColor.mainRedColor,
              fontSize: 20,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColor.mainRedColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: ChangeNotifierProvider(
          create: (_) => RegisterProvider(),
          child: Consumer<RegisterProvider>(
            builder: (_, provider, child) => Form(
              key: _formKey,
              child: provider.loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: deviceHeight * 0.3,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  left: 40,
                                  child: Image.asset(
                                    'asset/gaon_logo.png',
                                    width: deviceWidth * 0.3,
                                    height: deviceWidth * 0.3,
                                  ),
                                ),
                                Positioned(
                                    top: 60,
                                    right: 60,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '가온',
                                          style: TextStyle(
                                            fontFamily: 'lotte_happy_bold',
                                            fontSize: 34,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.mainRedColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          '당신의 손길을',
                                          style: TextStyle(
                                            fontFamily: 'lotte_happy_light',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.mainGreyColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '더하세요',
                                          style: TextStyle(
                                            fontFamily: 'lotte_happy_light',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.mainRedColor,
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 20, left: 40, right: 40, bottom: 20),
                            child: Column(
                              children: [
                                TextFormField(
                                  onSaved: (value) {
                                    phone = value;
                                  },
                                  cursorColor: AppColor.mainRedColor,
                                  autocorrect: false,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    icon: Icon(MdiIcons.phoneClassic),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2.0),
                                      borderRadius: BorderRadius.circular(
                                        30,
                                      ),
                                    ),
                                    hintText: '휴대폰 번호를 입력해주세요',
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  obscureText: true,
                                  onSaved: (value) {
                                    password = value;
                                  },
                                  cursorColor: AppColor.mainRedColor,
                                  autocorrect: false,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    icon: Icon(MdiIcons.lock),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2.0),
                                      borderRadius: BorderRadius.circular(
                                        30,
                                      ),
                                    ),
                                    hintText: '비밀번호를 입력해주세요',
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  obscureText: true,
                                  onSaved: (value) {
                                    passwordAgain = value;
                                  },
                                  cursorColor: AppColor.mainRedColor,
                                  autocorrect: false,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    icon: Icon(MdiIcons.lock),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2.0),
                                      borderRadius: BorderRadius.circular(
                                        30,
                                      ),
                                    ),
                                    hintText: '비밀번호를 다시 입력해주세요',
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Container(
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
                                    onPressed: () {
                                      _formKey.currentState.save();
                                      setState(() async {
                                        String res = await provider.register(
                                            phone: phone,
                                            password: password,
                                            passwordAgain: passwordAgain);
                                        if (res == null) {
                                          Navigator.popUntil(context, (route) => true);
                                          showDialogSuccessRegister(context, '회원가입에 성공했습니다');
                                        } else {
                                          showDialogByText(context, res);
                                        }
                                      });
                                    },
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 28),
                                      child: Text(
                                        '회원가입',
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
                        ],
                      ),
                    ),
            ),
          ),
        ));
  }
}
