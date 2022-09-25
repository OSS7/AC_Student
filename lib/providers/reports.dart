import 'package:ac_students/student/models/report.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class Reports extends ChangeNotifier {
  List<Report> reports = [];

  Future getReports() async {
    if (reports.isEmpty) {
      final QueryBuilder<ParseObject> reportsQuery = QueryBuilder<ParseObject>(
        ParseObject('Reports'),
      )..orderByDescending('createdAt');
      ParseResponse newsApiResponse = await reportsQuery.query();
      reports = Report.decode(
        newsApiResponse.results.toString(),
      );

      notifyListeners();
    } else {}
  }

  void addReport(BuildContext context, String title) async {
    final news = ParseObject('Reports')..set('title', title);

    var response = await news.save();
    response.success
        ? showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("success!"),
                content: const Text('news added successfully'),
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

  void deleteReports(BuildContext context, String id) async {
    final report = ParseObject('Reports')..set('objectId', id);

    var response = await report.delete();
    response.success
        ? showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("success!"),
                content: const Text('news deleted successfully'),
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
