import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final locate = GetIt.instance;

/// Initialize gobal services for use anywhere with the ***locate*** accessor
initGlobalServices() {
  locate.registerLazySingleton(() => GlobalKey<ScaffoldMessengerState>());
}
