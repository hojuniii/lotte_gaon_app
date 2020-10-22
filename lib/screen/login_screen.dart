import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gaon/const/app_color.dart';
import 'package:gaon/network/authentication.dart';
import 'package:gaon/network/web_client.dart';
import 'package:gaon/widget/dialog.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../locator.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  WebClient web = locator<WebClient>();
  String id, password;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
  }

  final AuthenticationService auth = locator<AuthenticationService>();
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      // resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Image.asset(
                        'asset/gaon_logo.png',
                        scale: 1.5,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '롯데',
                            style: TextStyle(
                              color: AppColor.mainOrangeColor,
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '가온',
                            style: TextStyle(
                              color: AppColor.mainRedColor,
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          icon: Icon(
                            MdiIcons.account,
                          ),
                          hintText: '전화번호를 입력해주세요',
                        ),
                        onSaved: (value) {
                          id = value;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: Icon(
                            MdiIcons.lock,
                          ),
                          hintText: '비밀번호를 입력해주세요',
                        ),
                        onSaved: (value) {
                          password = value;
                        },
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      // Spacer(),
                      Column(
                        children: [
                          Container(
                            width: 200,
                            height: 50,
                            child: RaisedButton(
                              focusColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2,
                                  color: Colors.red,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 0,
                              onPressed: () async {
                                formKey.currentState.save();

                                if (id.isEmpty || password.isEmpty) {
                                  showDialogByText(context, '아이디와 비밀번호를 모두 입력해주세요');
                                  return;
                                }
                                String res = await auth.login(id: id, password: password);
                                if (res == null) {
                                  Navigator.pushReplacementNamed(context, '/init');
                                } else {
                                  auth.dio.options.headers.remove('Authorization');
                                  showDialogByText(context, res);
                                }
                              },
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '로그인하기',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Container(
                            width: 200,
                            height: 50,
                            child: RaisedButton(
                              focusColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2,
                                  color: Colors.red,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 0,
                              onPressed: () async {
                                Navigator.pushNamed(context, '/register');
                              },
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
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
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
