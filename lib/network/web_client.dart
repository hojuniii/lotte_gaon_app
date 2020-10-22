import 'package:dio/dio.dart';
import 'package:gaon/model/user.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../locator.dart';
import 'cached_shared_preference.dart';

class WebClient {
  final Dio dio = Dio();
  final CachedSharedPreference sp = locator<CachedSharedPreference>();

  WebClient() {
    dio.options.baseUrl = "http://ec2-3-129-71-199.us-east-2.compute.amazonaws.com:8000/api/";
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      responseBody: true,
      requestBody: true,
      error: true,
    ));

    if (sp.haveUser()) {
      dio.options.headers['Authorization'] =
          "Token ${sp.getString(SharedPreferenceKey.AccessToken)}";
    }

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (e) {
          if (e.response.statusCode == 401) {
            String res = e.response.data['detail'][0];
            if (res == 'Invalid token') {
              sp.clearAll();
            }
          }
        },
      ),
    );
  }

  Future<User> getUser() async {
    if (sp.haveUser()) {
      final Response dioResponse = await dio.get('auth/user');
      if (dioResponse.statusCode == 200) {
        Map<String, dynamic> json = dioResponse.data;
        if (json != null) {
          return User.fromJson(json);
        }
      } else {
        return null;
      }
    }
    return null;
  }

  Future<void> setAccessTokenToHeader(String token) async {
    await sp.setString(SharedPreferenceKey.AccessToken, token);
    dio.options.headers['Authorization'] = "Token $token";
    return;
  }
}
