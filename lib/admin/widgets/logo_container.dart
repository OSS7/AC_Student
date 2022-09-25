import 'package:flutter/material.dart';
import 'package:ac_students/data/constant.dart';

class LogoContainer extends StatelessWidget {
  const LogoContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        padding: const EdgeInsets.only(bottom: 20),
        color: secondaryClr,
        width: size.width * 1,
        height: size.height * 0.2,
        child: Image.asset(
          'images/logo1.png',
          color: primaryClr,
          fit: BoxFit.fitHeight,
        ));
  }
}
