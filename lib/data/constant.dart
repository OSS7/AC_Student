import 'package:flutter/material.dart';

Color secondaryClr = const Color(0xff111D9E);
Color primaryClr = const Color(0xFFFFFFFF);
Color errorClr = Colors.red;

const edge20 = EdgeInsets.all(20);
const edge10 = EdgeInsets.all(10);
const edge5 = EdgeInsets.all(5);

LinearGradient topToBottomLiner = LinearGradient(
  colors: [secondaryClr, secondaryClr.withOpacity(0.6)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const radius25All = BorderRadius.all(Radius.circular(25));
const radius25BottomRightLeft = BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25));