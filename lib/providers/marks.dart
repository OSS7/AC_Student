import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:ac_students/student/models/mark.dart';
import 'package:permission_handler/permission_handler.dart';

class Marks extends ChangeNotifier {
  List<Mark> allMarks = [];
  List<Mark> marks = [];

  Future getMarks({required int userDep}) async {


    if (marks.isEmpty) {
      final QueryBuilder<ParseObject> fileQuery =
      QueryBuilder<ParseObject>(ParseObject('Marks'));
      ParseResponse fileApiResponse = await fileQuery.query();
      allMarks = Mark.decode(fileApiResponse.results.toString());
      marks = allMarks.where((element) => userDep==1 ?  element.subjectId! < 50 : element.subjectId! > 50 ).toList();
      notifyListeners();
    } else {}
  }

  void addMarks(BuildContext context, int id, String link) async {
    final mark = ParseObject('Marks')
      ..set('subject_id', id)
      ..set('link', link);

    var response = await mark.save();
    response.success
        ? showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("success!"),
                content: const Text('marks added successfully'),
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

  void deleteMarks(BuildContext context,String id) async {

    final marks = ParseObject('Marks')
      ..set('objectId',id);

    var response = await marks.delete();
    response.success ? showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("success!"),
          content: const Text('file deleted successfully'),
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
    ) : showDialog(
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

  Future downloadMarks(BuildContext context,String fileName,fileLink) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      //add more permission to request here.
    ].request();


    if(Theme.of(context).platform == TargetPlatform.android){
      if (statuses[Permission.storage]!.isGranted) {
        await Permission.storage.request();

        var dir = '/storage/emulated/0/Download/AppliedCollege/Marks';
        String saveName = '$fileName.pdf';
        String savePath = dir + "/$saveName";

        try {
          await Dio().download(
              fileLink,
              savePath,
              onReceiveProgress: (received, total) {
                if (total != -1) {
                  // print((received / total * 100).toStringAsFixed(0) + "%");
                }
              });
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("done!"),
                content: Text('the $fileName file has been downloaded to /Downloads/AppliedCollege'),
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
        } on DioError catch (e) {
          print(e.message);
        }
      } else {
      }
    }
  }
}
