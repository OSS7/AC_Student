import 'package:flutter/cupertino.dart';

class DrawerModel {
  final String? title;
  final String? route;
  final IconData? icon;
  final bool? isForAdmin;

  const DrawerModel(
      {this.isForAdmin = false, this.title, this.route, this.icon});
}
