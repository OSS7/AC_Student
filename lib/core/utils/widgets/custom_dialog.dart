import 'package:ac_students/core/constant/constant.dart';
import 'package:flutter/material.dart';

class ShowSuccessMessages extends StatelessWidget {
  final String message;

  const ShowSuccessMessages({Key? key, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: primaryClr,
      title: Text("success!", style: TextStyle(color: secondaryClr)),
      content: Text(message),
      actions: [
        TextButton(
          child: Text("OK", style: TextStyle(color: secondaryClr)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class ShowErrorMessages extends StatelessWidget {
  final String message;

  const ShowErrorMessages({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: primaryClr,
      title: Text(
        "error!",
        style: TextStyle(color: errorClr),
      ),
      content: Text(message),
      actions: [
        TextButton(
          child: Text("OK", style: TextStyle(color: errorClr)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
