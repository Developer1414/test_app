import 'package:flutter/material.dart';

void showAlertDialog({
  required BuildContext context,
  required String title,
  required String content,
  String? secondButtonText,
  VoidCallback? onPressOkay,
  VoidCallback? onPressSecondButton,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          onPressSecondButton != null
              ? TextButton(
                  child: Text(secondButtonText!),
                  onPressed: () {
                    Navigator.of(context).pop();
                    onPressSecondButton.call();
                  },
                )
              : Container(),
          TextButton(
            child: const Text('OK'),
            onPressed: () => onPressOkay == null
                ? Navigator.of(context).pop()
                : onPressOkay.call(),
          ),
        ],
      );
    },
  );
}
