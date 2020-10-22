import 'package:flutter/material.dart';
import 'package:gaon/const/app_color.dart';
import 'package:gaon/locator.dart';
import 'package:gaon/model/user.dart';
import 'package:gaon/screen/home/provider/home_provider.dart';
import 'package:gaon/screen/register/set_profile_screen.dart';
import 'package:provider/provider.dart';

import '../../network/authentication.dart';
import '../../network/web_client.dart';

import '../home/home_screen.dart';

class InitScreen extends StatefulWidget {
  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
  }

  AuthenticationService auth = locator<AuthenticationService>();
  WebClient web = locator<WebClient>();
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    if (auth.sp.haveUser())
      return ChangeNotifierProvider(
        create: (_) => HomeProvider(),
        child: Consumer<HomeProvider>(
            builder: (context, provider, child) => provider.loading
                ? Center(
                    child: Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                : provider.profile.nickname == ''
                    ? SetProfileScreen(
                        drawerKey: _drawerKey,
                        auth: auth,
                        provider: provider,
                      )
                    : HomeScreen(drawerKey: _drawerKey, auth: auth, provider: provider)),
      );
  }
}
