import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
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
  late AndroidDeviceInfo _androidInfo;
  late Future<Map<Permission, PermissionStatus>> _permissionGetter;

  @override
  void initState() {
    super.initState();
    _permissionGetter = _getPermissions();
  }

  // Prompt the user for permissions for needed features
  //
  // If the user has not yet been prompted or has already chosen 'Deny' once
  // * a dialog is shown "Allow APP_NAME to access photos, media, and files on your device?"
  // * the user can choose "Allow" or "Deny"
  // * choosing "Allow" completes any future requests with success without the dialog
  // * choosing "Deny" triggers the dialog again the next time a check is made
  // * choosing "Deny" a second time completes any future requests with fail without the dialog
  //
  Future<Map<Permission, PermissionStatus>> _getPermissions() async {
    log.info('Getting permissions');
    if (Platform.isAndroid) {
      _androidInfo = await DeviceInfoPlugin().androidInfo;
      if (_androidInfo.version.sdkInt <= 32) {
        // Android 12 and below
        //return await [Permission.manageExternalStorage].request();
        return await [Permission.storage].request();
      } else {
        // Android 13 and above
        return await [Permission.photos, Permission.videos].request();
      }
    }
    // Default for systems like Linux just ignore this
    return {Permission.storage: PermissionStatus.granted};
  }

  @override
  Widget build(BuildContext context) {
    // Ensure content is not obscured by system UI at bottom of screen
    return SafeArea(
      left: false,
      right: false,
      top: false,
      child: Scaffold(
        body: FutureBuilder<Map<Permission, PermissionStatus>>(
          future: _permissionGetter,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: LoadingIndicator(size: 200, bottom: 100));
            }
            if (snapshot.hasData) {
              // Check permissions
              final permissions = snapshot.data!;
              var storagePermission = PermissionStatus.granted;
              if (permissions.containsKey(Permission.storage)) {
                storagePermission = permissions[Permission.storage]!;
              } else {
                // Both permissions will be the same result as they are shown to the user at
                // the same time and will have the same response.
                switch (permissions[Permission.photos]) {
                  case PermissionStatus.denied:
                    storagePermission = PermissionStatus.denied;
                  case PermissionStatus.permanentlyDenied:
                    storagePermission = PermissionStatus.permanentlyDenied;
                  case PermissionStatus.restricted:
                    storagePermission = PermissionStatus.restricted;
                  case PermissionStatus.limited:
                    storagePermission = PermissionStatus.limited;
                  case PermissionStatus.provisional:
                    storagePermission = PermissionStatus.provisional;
                  default:
                    storagePermission = PermissionStatus.granted;
                }
              }

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
                        _permissionGetter = _getPermissions();
                      }),
                      child: const Text('Retry'),
                    ),
                  ],
                );
              } else if (storagePermission.isGranted) {
                // ******************************************************
                // Permission check succeeded so load the target widget
                // ******************************************************
                return widget.child ?? const SizedBox();
                // ******************************************************
                // ******************************************************
              } else if (storagePermission.isPermanentlyDenied) {
                return AlertDialog(
                  title: const Text('Permission denied permanently'),
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
                        setState(() {
                          _permissionGetter = _getPermissions();
                        });
                      },
                      child: const Text('Open settings'),
                    ),
                  ],
                );
              }
              return const SizedBox();
            }

            // Permission check failed
            if (snapshot.hasError) {
              return Center(
                  child: ErrorRetry(
                size: 100,
                bottom: 100,
                msg: 'Error loading permissions',
                onRetry: () => setState(() {
                  _permissionGetter = _getPermissions();
                }),
              ));
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
