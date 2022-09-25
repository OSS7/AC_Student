import 'package:flutter/material.dart';
import 'package:ac_students/data/constant.dart';

class LoadingCircle extends StatelessWidget {
  const LoadingCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 100,
        height: 100,
        child: RefreshProgressIndicator(
          backgroundColor: primaryClr,
          color: secondaryClr,
        ),
      ),
    );
  }
}
