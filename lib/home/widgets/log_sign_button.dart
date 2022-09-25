import 'package:ac_students/data/constant.dart';
import 'package:flutter/material.dart';

class LogSignButton extends StatelessWidget {
  final Function() onPress;
  final String label;
  const LogSignButton({Key? key, required this.onPress, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return TextButton(
      onPressed: onPress,
      child: Container(
        width: size.width * 0.9,
        height: size.height * 0.06,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            secondaryClr.withOpacity(0.6),secondaryClr
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          ),
            color: secondaryClr,
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: primaryClr),
          ),
        ),
      ),
    );
  }
}
