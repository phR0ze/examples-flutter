import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'const.dart';
import 'providers/app_state.dart';
import 'providers/services.dart';
import 'ui/folders_page.dart';

void main() {
  initGlobalServices();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appStateProvider);

    return MaterialApp(
      title: "Image Viewer",
      debugShowCheckedModeBanner: false,

      // Configure global snackbar messenger
      scaffoldMessengerKey: locate<GlobalKey<ScaffoldMessengerState>>(),

      // Configure app theme
      // https://m3.material.io/theme-builder#/custom
      themeMode: state.darkMode ? ThemeMode.dark : ThemeMode.light,
      // theme: ThemeData(
      //   useMaterial3: true,
      //   // colorSchemeSeed: Colors.blue,
      //   // colorScheme: ColorScheme.fromSwatch(
      //   //   primarySwatch: Colors.blue,
      //   //   // accentColor: Colors.blue,
      //   //   // brightness: Brightness.dark,
      //   // ),
      // ),
      theme: ThemeData(useMaterial3: true, colorScheme: Const.lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: Const.darkColorScheme),
      // darkTheme: ThemeData(
      //   useMaterial3: true,
      //   colorScheme: ColorScheme.fromSeed(
      //     seedColor: Const.colorPrimary,
      //     primary: Const.colorPrimary,
      //     secondary: Const.colorPrimary,
      //   ),
      //   // appBarTheme: const AppBarTheme(
      //   //   backgroundColor: Colors.blue,
      //   // ),
      //   // brightness: Brightness.dark,
      //   // colorScheme: ColorScheme.fromSwatch(
      //   //   //primarySwatch: Colors.blue,
      //   //   // accentColor: Colors.blue,
      //   //   brightness: Brightness.dark,
      //   // ),
      //   // scrollbarTheme: ScrollbarThemeData(
      //   //   thickness: MaterialStateProperty.all(10.0),
      //   //   thumbColor: MaterialStateProperty.all(Colors.blue),
      //   // ),
      //   // snackBarTheme: const SnackBarThemeData(
      //   //   backgroundColor: Colors.blue,
      //   // ),
      // ),

      home: const FoldersPage(),
    );
  }
}
