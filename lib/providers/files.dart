import 'package:ac_students/providers/show_messages.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ac_students/student/models/file.dart';

class Files extends ChangeNotifier {
  List<File> files = [];
  List<File> specificFiles = [];

  Future getFiles({
    required int userDep,
    required int userYear,
  }) async {
    if (files.isEmpty) {
      final QueryBuilder<ParseObject> fileQuery =
          QueryBuilder<ParseObject>(ParseObject('Files'))
            ..orderByDescending('createdAt');
      ParseResponse fileApiResponse = await fileQuery.query();
      files = File.decode(fileApiResponse.results.toString());
      notifyListeners();

      specificFiles = files
          .where((e) => userDep == 1 && userYear == 1
                  ? e.subjectId! < 13 && e.subjectId! > 0
                  : userDep == 1 && userYear == 2
                      ? e.subjectId! < 24 && e.subjectId! > 13
                      : userDep == 1 && userYear == 3
                          ? e.subjectId! < 37 && e.subjectId! > 26
                          : userDep == 1 && userYear == 4
                              ? e.subjectId! < 49 && e.subjectId! > 38
                              : userDep == 2 && userYear == 1
                                  ? e.subjectId! < 64 && e.subjectId! > 51
                                  : userDep == 1 && userYear == 2
                                      ? e.subjectId! < 78 && e.subjectId! > 65
                                      : userDep == 1 && userYear == 3
                                          ? e.subjectId! < 92 &&
                                              e.subjectId! > 79
                                          : e.subjectId! < 100 &&
                                              e.subjectId! > 93
              // e.subjectId! < 50 : e.subjectId! > 50
              )
          .toList();
    } else {}
  }

  void addFile(BuildContext context, String name, int id, String link) async {
    String downloadLink = link;
    if (link.contains('d/')) {
      String str = link.toString();
      String start = "/d/";
      String end = "/view";

      final startIndex = str.indexOf(start);
      final endIndex = str.indexOf(end, startIndex + start.length);

      downloadLink =
          "https://drive.google.com/uc?export=download&id=${str.substring(startIndex + start.length, endIndex)}";
    }
    final file = ParseObject('Files')
      ..set('name', name)
      ..set('subject_id', id)
      ..set('link', downloadLink);

    var response = await file.save();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return response.success
            ? const ShowSuccessMessages(message: 'file added successfully')
            : ShowErrorMessages(message: response.error!.message.toString());
      },
    );
  }

  void deleteFile(BuildContext context, String id) async {
    final file = ParseObject('Files')..set('objectId', id);

    var response = await file.delete();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return response.success
            ? const ShowSuccessMessages(message: 'file deleted successfully')
            : ShowErrorMessages(message: response.error!.message.toString());
      },
    );
  }

  Future downloadFile(BuildContext context, String fileName, fileLink) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      //add more permission to request here.
    ].request();

    if (Theme.of(context).platform == TargetPlatform.android) {
      if (statuses[Permission.storage]!.isGranted) {
        await Permission.storage.request();

        var dir = '/storage/emulated/0/Download/AppliedCollege/Files';
        String saveName = '$fileName.pdf';
        String savePath = dir + "/$saveName";

        try {
          await Dio().download(fileLink, savePath,
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
                content: Text(
                    'the $fileName has been downloaded to /Downloads/AppliedCollege'),
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
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ShowErrorMessages(message: e.message);
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const ShowErrorMessages(
                message: 'no permission to read and write');
          },
        );
      }
    }
  }
}
