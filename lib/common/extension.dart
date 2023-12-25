import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/common/color_extension.dart';

extension StateExtension on State {
  void mdShowAlert(String title, String message, VoidCallback onPressed,
      {String buttonTitle = "Ok",
      TextAlign messageTextAlign = TextAlign.center}) {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(
          message,
          textAlign: messageTextAlign,
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
              onPressed();
            },
            textStyle: TextStyle(color: TColor.primary),
            child: Text(buttonTitle),
          )
        ],
      ),
    );
  }

  void endEditing() {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}

extension StringExtension on String {
  bool get isEmail {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }
}
