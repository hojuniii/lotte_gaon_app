import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gaon/network/authentication.dart';
import 'package:gaon/network/cached_shared_preference.dart';
import 'package:gaon/network/web_client.dart';

import 'screen/home/provider/home_provider.dart';

GetIt locator = GetIt.instance;

void setupServiceLocator() {
  locator.registerSingletonAsync<CachedSharedPreference>(() async {
    final cs = CachedSharedPreference();
    await cs.init();
    return cs;
  });

  locator.registerSingletonWithDependencies<WebClient>(() => WebClient(),
      dependsOn: [CachedSharedPreference]);

  locator.registerSingletonWithDependencies<AuthenticationService>(() => AuthenticationService(),
      dependsOn: [WebClient]);

  locator.registerSingletonWithDependencies<HomeProvider>(() => HomeProvider(),
      dependsOn: [WebClient]);
}
