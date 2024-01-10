import 'package:flutter/material.dart';
import '../../providers/services.dart';

/// Show a snackbar with the given ***[message]*** to communicate with the user
showSnackBar(String message) {
  // Its ok to use the null assertion operator here because we know that the
  // service locator will always return a non-null value since it is initialized
  // in main.dart in the MaterialApp widget.
  locate<GlobalKey<ScaffoldMessengerState>>().currentState!.showSnackBar(
        SnackBar(
          content: Center(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
}
