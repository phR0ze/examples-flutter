import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

/// Initialize services and configure the service locator
final locate = GetIt.instance;
initServices() {
  locate.registerLazySingleton(() => GlobalKey<ScaffoldMessengerState>());
}
