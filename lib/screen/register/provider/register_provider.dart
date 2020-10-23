import 'package:flutter/material.dart';
import 'package:gaon/network/authentication.dart';

import '../../../locator.dart';

class RegisterProvider extends ChangeNotifier {
  AuthenticationService authenticationService = locator<AuthenticationService>();
  bool loading = false;

  Future<String> register({String phone, String password, String passwordAgain}) async {
    loading = true;
    String res = await authenticationService.register(phone: phone, password: password);

    if (res == null) {
      loading = false;
      notifyListeners();
      return null;
    } else {
      loading = false;
      notifyListeners();
      return res;
    }
  }
}
