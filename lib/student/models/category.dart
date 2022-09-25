import 'package:flutter/cupertino.dart';

class Category {

  final String? title;
  final String? route;
  final IconData? icon;
  final bool? isForAdmin;
  const Category({ this.isForAdmin = false, this.title,this.route, this.icon});
}
