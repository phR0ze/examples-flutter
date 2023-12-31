import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast/sembast_memory.dart';
import 'const.dart';
import 'data/repos/data_store.dart';
import 'data/model/exports.dart' as model;
import 'providers/services.dart';
import 'ui/home_page.dart';

Future<void> main() async {
  initServices();

  // Ensure that the WidgetsBinding has been set up before creating the app
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the data store once at app startup and keeping it open throughout the app's
  // lifetime as this is an expensive operation; recommended by the Sembast author.
  final dataStore = await DataStore.init(databaseFactoryIo);

  // Test data
  // final dataStore = await DataStore.init(databaseFactoryMemory);
  // await dataStore.putProfile(const models.Profile(id: '1', name: 'Bob Marley'));
  // await dataStore.putProfile(const models.Profile(id: '2', name: 'Children'));
  // await dataStore.putProfile(const models.Profile(id: '3', name: 'Rubarb One'));
  // await dataStore.saveConfig(const models.Config(currentProfileId: '3'));

  // Wrap the app in a Riverpod ProviderScope to make providers accessible to the app
  runApp(ProviderScope(
    overrides: [
      // Override the dataStoreProvider with the initialized data store
      dataStoreProvider.overrideWithValue(dataStore),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Const.appName,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(28, 40, 55, 1),
        primarySwatch: Colors.blue,
        scrollbarTheme: ScrollbarThemeData(
          thickness: MaterialStateProperty.all(10.0),
          thumbColor: MaterialStateProperty.all(Colors.blue),
        ),
        textTheme: const TextTheme(
          displaySmall: TextStyle(color: Colors.white, fontSize: 12.0),
          displayMedium: TextStyle(color: Colors.white, fontSize: 30.0),
        ),
      ),
      home: const HomePage(),
    );
  }
}
