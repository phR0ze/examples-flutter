import 'package:desktop_window/desktop_window.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:flutter/material.dart';
import 'package:image_viewer/const.dart';
import 'screens/narrow/home.dart' as narrow;
import 'screens/wide/home.dart' as wide;

// TODO: this doesn't actually work the way it should. Yes it will resize the window
// but not until after it has already been drawn by the C++ code in your 'linux' platform
// folder and thus you get a obvious visible resizing of the window.
Future setDesktopWindow() async {
  await DesktopWindow.setMinWindowSize(const Size(400, 400));
  await DesktopWindow.setWindowSize(const Size(1300, 900));
}

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  // Set the window size on desktop platforms
  if (UniversalPlatform.isDesktop) {
    setDesktopWindow();
  }

  // Wrap in Riverpod state management
  runApp(ProviderScope(
    overrides: [
      // Override temporary shared preferences value with loaded value
      sharedPreferencesProvider.overrideWithValue(sharedPreferences),
    ],
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Const.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: LayoutBuilder(builder: (context, constraints) {
          return constraints.maxWidth > Const.narrowThreshold
              ? wide.HomeScreen(constraints)
              : narrow.HomeScreen(constraints);
        }),
      ),
    );
  }
}
