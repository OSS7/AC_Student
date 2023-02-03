import 'package:ac_students/core/constant/constant.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends AppBar {
  final String? txt;
  final Widget? child;

  AppBarWidget({Key? key, this.txt, this.child}) : super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [widget.child ?? const SizedBox()],
      centerTitle: true,
      title: FittedBox(
        child: Text(
          widget.txt ?? '',
        ),
      ),
      backgroundColor: secondaryClr,
      foregroundColor: primaryClr,
    );
  }
}
