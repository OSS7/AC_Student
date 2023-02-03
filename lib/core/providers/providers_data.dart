import 'dart:async';

import 'package:ac_students/features/user/file/model/file.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../constant/constant.dart';

class ProvidersData with ChangeNotifier {
  bool isFileInComputerDep(File file) {
    return file.subjectId! <= 50 ? true : false;
  }

  final box = GetStorage();

  changSecColor(int color) {
    secondaryClr = Color(color);
    box.write('color', color);
    notifyListeners();
  }

  changPriColor() {
    if (primaryClr == Colors.white) {
      primaryClr = Colors.black;
      box.write('mode', true);
    } else {
      primaryClr = Colors.white;
      box.write('mode', false);
    }
    notifyListeners();
  }

  Future<ParseUser> getCurrentUser() async {
    return await ParseUser.currentUser();
  }
}
