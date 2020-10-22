import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gaon/model/box.dart';
import 'package:gaon/model/profile.dart';
import 'package:gaon/model/user.dart';
import 'package:gaon/network/authentication.dart';
import 'package:gaon/network/web_client.dart';

import '../../../locator.dart';

class HomeProvider extends ChangeNotifier {
  bool isInit = false;
  AuthenticationService auth = locator<AuthenticationService>();
  WebClient web = locator<WebClient>();
  User user;
  Profile profile;
  List<Box> boxs;
  List<Box> todayBoxs = [];
  Box capturedBox;
  bool loading = true;
  int completedBoxCount = 0;
  Set<String> month = Set();

  // update profile
  File profileImage;
  String nickName;
  String servicePlace;
  String servicePlaceApartment;
  String birth;
  int age;

  HomeProvider() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (auth.sp.haveUser()) {
        await getUser();
        await getBoxs();
      }
    });
  }

  Future<void> refesh() async {
    loading = true;
    notifyListeners();
    try {
      await getBoxs();
      // notifyListeners();
    } catch (e) {
      debugPrint(e);
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<bool> getBoxs() async {
    month = Set();
    todayBoxs = [];
    completedBoxCount = 0;
    try {
      loading = true;
      boxs = await auth.getBoxs(id: user.id);
      for (Box box in boxs) {
        String today = DateTime.now().toString().substring(0, 10);

        //오늘 출발했거나 완료된 박스들을 넣어줌
        if (box.startedAt.toString().substring(0, 10) == today ||
            box.completedAt.toString().substring(0, 10) == today ||
            box.status != 'C') {
          todayBoxs.add(box);
          if (box.status == 'C') completedBoxCount++;
        }

        month.add(box.startedAt.substring(0, 10));
      }
      return true;
    } catch (e) {
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<bool> setBox(String boxNumber) async {
    String date = DateTime.now().toString().substring(0, 19);
    String nextStatus;

    try {
      loading = true;
      if (capturedBox.status == 'W') {
        nextStatus = 'D';
        await auth.setBox(
          boxNum: boxNumber,
          userPk: user.id,
          status: nextStatus,
          startedAt: date,
        );
      } else if (capturedBox.status == 'D') {
        nextStatus = 'C';
        await auth.setBox(
          boxNum: boxNumber,
          userPk: user.id,
          status: nextStatus,
          startedAt: capturedBox.startedAt,
          completedAt: date,
        );
      }

      return true;
    } catch (e) {
      // web.sp.clearAll();
      loading = false;
      debugPrint(e);
    } finally {
      loading = false;
      notifyListeners();
    }
    return false;
  }

  Future<void> getUser() async {
    try {
      loading = true;
      user = await web.getUser();
      if (user != null) profile = user.profile;
    } catch (e) {
      web.sp.clearAll();
      debugPrint(e);
    } finally {
      loading = false;
      notifyListeners();
    }
    return;
  }

  bool isExistBox = false;
  Future<void> getBox(String boxNumber) async {
    try {
      loading = true;
      capturedBox = await auth.getBox(boxNumber);
      return true;
    } catch (e) {
      // web.sp.clearAll();
      loading = false;
      debugPrint(e);
    } finally {
      loading = false;
      notifyListeners();
    }
    return;
  }

  Future<bool> updateProfile() async {
    try {
      bool res = await auth.updateProfile(
          id: user.id,
          nickName: nickName,
          image: profileImage,
          servicePlace: servicePlace,
          birth: birth,
          age: age);
      if (res) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e);
      return false;
    } finally {
      notifyListeners();
    }
  }
}
