import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gaon/model/box.dart';

import '../locator.dart';
import 'cached_shared_preference.dart';
import 'web_client.dart';

class AuthenticationService {
  final Dio dio = locator<WebClient>().dio;
  final CachedSharedPreference sp = locator<CachedSharedPreference>();

  Future<String> login({@required String id, @required String password}) async {
    try {
      Response response =
          await dio.post('auth/login', data: {'username': '$id', 'password': '$password'});
      if (response.statusCode == 200) {
        bool isSuccess = await saveToken(response.data['token']);
        if (isSuccess) {
          return null;
        } else {
          return response.data['message'];
        }
      } else {
        dio.options.headers.remove('Authorization');
        return '오류가 발생했습니다';
      }
    } on DioError catch (e) {
      if (e.response.statusCode == 400) {
        String res = e.response.data['non_field_errors'][0];
        return res;
      } else {
        return '오류가 발생했습니다';
      }
    }
  }

  Future<String> register({@required String phone, @required String password}) async {
    try {
      Response response =
          await dio.post('auth/register', data: {'username': '$phone', 'password': '$password'});
      String status = response.data['status'];
      String message = response.data['message'];
      if (status == "200") {
        return null;
      } else {
        return message;
      }
    } catch (e) {
      Exception(e);
      return '오류가 발생했습니다';
    }
  }

  Future<Box> getBox(String boxNumber) async {
    if (sp.haveUser()) {
      final Response dioResponse = await dio.get('auth/box/${boxNumber}/check');
      if (dioResponse.statusCode == 200) {
        Map<String, dynamic> json = dioResponse.data;
        if (json != null) {
          return Box.fromJson(json);
        }
      } else {
        return null;
      }
    }
    return null;
  }

  Future<Box> setBox(
      {@required String boxNum,
      @required int userPk,
      @required String status,
      String startedAt,
      String completedAt}) async {
    if (sp.haveUser()) {
      final Response dioResponse = await dio.put('auth/box/${boxNum}/update', data: {
        'user': userPk,
        'status': status,
        'started_at': startedAt,
        'completed_at': completedAt,
      });
      if (dioResponse.statusCode == 200) {
        Map<String, dynamic> json = dioResponse.data;
        if (json != null) {
          return Box.fromJson(json);
        }
      } else {
        return null;
      }
    }
    return null;
  }

  Future<List<Box>> getBoxs({@required int id}) async {
    if (sp.haveUser()) {
      final Response dioResponse = await dio.get('auth/boxs/${id.toString()}');
      if (dioResponse.statusCode == 200) {
        List<dynamic> json = dioResponse.data;
        if (json != null) {
          return (json)
              ?.map((e) => e == null ? null : Box.fromJson(e as Map<String, dynamic>))
              ?.toList();
        }
      } else {
        return null;
      }
    }
    return null;
  }

  Future<bool> logOut() async {
    // await sp.clearAll();
    if (sp.haveUser()) {
      Response response = await dio.post('auth/logout');
      if (response.statusCode == 204) {
        dio.options.headers.remove('Authorization');
        await sp.clearAll();
        return true;
      } else
        return false;
    } else {
      return false;
    }
  }

  Future<bool> updateProfile({
    @required int id,
    String nickName,
    String servicePlace,
    File image,
    String birth,
    int age,
  }) async {
    if (image != null) {
      final Response dioResponse = await dio.put('auth/profile/$id/update',
          data: FormData.fromMap({
            'nickname': nickName,
            'service_place': servicePlace,
            'profile_image':
                await MultipartFile.fromFile(image.path, filename: '${id}_profile.png'),
            'birth': birth,
            'age': age,
          }));
      if (dioResponse.statusCode == 200) {
        return true;
      } else
        return false;
    } else {
      final Response dioResponse = await dio.put('auth/profile/$id/update',
          data: FormData.fromMap({
            'nickname': nickName,
            'service_place': servicePlace,
            'birth': birth,
            'age': age,
          }));
      if (dioResponse.statusCode == 200) {
        return true;
      } else
        return false;
    }
  }

  Future<bool> saveToken(String token) async {
    if (token != null) {
      await locator<WebClient>().setAccessTokenToHeader(token);
      return true;
    } else {
      return false;
    }
  }
}
