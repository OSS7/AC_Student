import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ac_students/data/constant.dart';

class Txt extends StatelessWidget {
  final String? txt;
  const Txt(this.txt, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text(
        txt ?? 'null',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.w600, color: primaryClr
        ),
      ),
    );
  }
}
