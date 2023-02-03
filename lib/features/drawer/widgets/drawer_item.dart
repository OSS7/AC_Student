import 'package:ac_students/core/constant/constant.dart';
import 'package:flutter/material.dart';

class DrawerItem extends StatefulWidget {
  final String? title;
  final String? route;
  final IconData? icon;

  const DrawerItem({this.title, this.route, this.icon, Key? key})
      : super(key: key);

  @override
  State<DrawerItem> createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      margin: const EdgeInsets.only(bottom: 2),
      child: ListTile(
        onTap: () {
          Navigator.pushNamedAndRemoveUntil(context,
              widget.route ?? '/HomeScreen', (Route<dynamic> route) => false);
        },
        title: Text(
          widget.title ?? '',
          style: TextStyle(
              color: secondaryClr, fontSize: 17, fontWeight: FontWeight.w700),
        ),
        leading: Icon(
          widget.icon,
          color: secondaryClr,
        ),
      ),
    );
  }
}
