import 'dart:io';

import 'package:ac_students/features/user/images/gallery/model/photo.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ImagesProvider extends ChangeNotifier {
  // final box = GetStorage();

  List<Photo> images = [];

  Future<List<ParseObject>> getSpecificImages(String objectId) async {
    QueryBuilder<ParseObject> queryTodo =
        QueryBuilder<ParseObject>(ParseObject('Images'))
          ..whereEqualTo('objectId', objectId);

    final ParseResponse apiResponse = await queryTodo.query();
    if (apiResponse.success && apiResponse.results != null) {
      return apiResponse.results!.reversed.toList() as List<ParseObject>;
    } else {
      return [];
    }
  }

  Future getImages() async {
    if (images.isEmpty) {
      QueryBuilder<ParseObject> queryTodo =
          QueryBuilder<ParseObject>(ParseObject('Images'));

      final ParseResponse apiResponse = await queryTodo.query();
      images = Photo.decode(apiResponse.results.toString());
      notifyListeners();
    } else {}
  }

  Future addImage(BuildContext context, String title, File parseFile) async {
    final image = ParseObject('Images')
      ..set('image', ParseFile(parseFile))
      ..set('title', title);

    var response = await image.save();
    response.success
        ? showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("success!"),
                content: const Text('image added successfully'),
                actions: <Widget>[
                  TextButton(
                    child: const Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          )
        : showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Error!"),
                content: Text(response.error!.message.toString()),
                actions: <Widget>[
                  TextButton(
                    child: const Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
  }

  void deleteImages(BuildContext context, String id) async {
    final photo = ParseObject('Images')..set('objectId', id);

    var response = await photo.delete();
    response.success
        ? showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("success!"),
                content: const Text('photo deleted successfully'),
                actions: <Widget>[
                  TextButton(
                    child: const Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          )
        : showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Error!"),
                content: Text(response.error!.message.toString()),
                actions: <Widget>[
                  TextButton(
                    child: const Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
  }
}
