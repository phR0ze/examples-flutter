import 'dart:io';
import 'package:flutter/material.dart';
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
    // Linux has no support for this
    if (Platform.isLinux) {
      return PermissionStatus.granted;
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
            if (storagePermission.isGranted) {
              return const Text('Permission granted');
            } else if (storagePermission.isPermanentlyDenied) {
              return const Text('Permission permanently denied');
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