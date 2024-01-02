// Show a brief message at the bottom of the screen
import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Center(child: Text(message)),

      // Make the margin positioning work
      behavior: SnackBarBehavior.floating,

      // Reduce the duration so its not annoying
      duration: const Duration(milliseconds: 750),

      // Add padding around text
      padding: const EdgeInsets.all(20.0),

      // Position the snack bar well above the navigation bar so it doesn't obscure it
      // and push it in from the edges
      margin: const EdgeInsets.only(bottom: 300.0, left: 75.0, right: 75.0),

      // Round the snack bar corners
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))));
}
