import 'dart:io';
import 'package:flutter/material.dart';
import '../../utils/logger.dart';
import 'exports.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandler extends StatefulWidget {
  final Widget? child;
  const PermissionHandler({required this.child, super.key});

  @override
  State<PermissionHandler> createState() => _PermissionHandlerState();
}

class _PermissionHandlerState extends State<PermissionHandler> {
  late Future<PermissionStatus> _storagePermissionGetter;
  bool next = false;

  @override
  void initState() {
    super.initState();
    _storagePermissionGetter = _getStoragePermission();
  }

  // Prompt the user for permission to access the filesystem.
  //
  // Case 1: The user has not yet been prompted
  // * dialog is shown "Allow APP_NAME to access photos, media, and files on your device?"
  // * user can choose "Allow" or "Deny"
  // * choosing "Allow" completes any future requests with success without the dialog
  // * choosing "Deny" triggers the dialog again the next time a check is made
  // * choosing "Deny" a second time completes any future requests with fail without the dialog
  //
  // Case 2:
  //
  // If the user has already chosen
  // `Deny And Don't Ask Again` then open the app settings so they can change it.
  Future<PermissionStatus> _getStoragePermission() async {
    log.info('Getting storage permission');
    // Linux has no support for this
    if (Platform.isLinux) {
      if (next) {
        return PermissionStatus.granted;
      }
      return PermissionStatus.denied;
    }

    // Prompt the user with a dialog
    var result = await Permission.storage.request();
    // if (result.isGranted) {
    //   return result;
    // } else if (await Permission.storage.request().isPermanentlyDenied) {
    //   await openAppSettings();
    // } else if (await Permission.storage.request().isDenied) {
    //   setState(() {
    //     _storagePermissionGranted = false;
    //   });
    // }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<PermissionStatus>(
        future: _storagePermissionGetter,
        builder: (BuildContext context, AsyncSnapshot<PermissionStatus> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LoadingIndicator(size: 200, bottom: 100));
          }
          if (snapshot.hasData) {
            final storagePermission = snapshot.data!;

            // Prompt the user to try again since we can't use the app othewise
            if (storagePermission.isDenied) {
              return AlertDialog(
                title: const Text('Permission denied'),
                content: const Text('Reading and writing storage is required to use this app.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => setState(() {
                      Navigator.of(context).pop();
                      next = true;
                      _storagePermissionGetter = _getStoragePermission();
                    }),
                    child: const Text('Retry'),
                  ),
                ],
              );
            }

            if (storagePermission.isGranted) {
              return const Text('Permission granted');
            } else if (storagePermission.isPermanentlyDenied) {
              return AlertDialog(
                title: const Text('Permission denied'),
                content: const Text(
                    'Reading and writing storage is required to use this app. Please grant permission in the settings.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      await openAppSettings();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Open settings'),
                  ),
                ],
              );
            } else if (storagePermission.isDenied) {
              return const Text('Permission is denied');
            }
            return const Text('no case');
          }

          if (snapshot.hasError) {
            return Center(
                child: ErrorRetry(
              size: 100,
              bottom: 100,
              msg: 'Error loading permissions',
              onRetry: () => setState(() {
                _storagePermissionGetter = _getStoragePermission();
              }),
            ));
          }

          return const SizedBox();
        },
      ),
    );
  }
}
