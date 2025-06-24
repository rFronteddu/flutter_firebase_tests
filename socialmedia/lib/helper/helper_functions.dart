import 'package:flutter/material.dart';

// display error message to user
void displayMsgToUser(String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(title: Text(message)),
  );
}
