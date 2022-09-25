import 'package:flutter/material.dart';
import 'package:ac_students/data/constant.dart';

class SettingSwitchTile extends StatelessWidget {
  final String title;
  final String description;
  final bool currentValue;
  final Function(bool) updateState;
  const SettingSwitchTile(
      {Key? key,
      required this.title,
      required this.description,
      required this.currentValue,
      required this.updateState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(title, style: TextStyle(color: secondaryClr)),
      subtitle: Text(description, style: TextStyle(color: secondaryClr)),
      value: currentValue,
      onChanged: updateState,
    );
  }
}
