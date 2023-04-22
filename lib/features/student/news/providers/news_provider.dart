import 'package:ac_students/features/student/news/model/news.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class NewsesProvider extends ChangeNotifier {
  List<News> news = [];

  Future getNews() async {
    if (news.isEmpty) {
      final QueryBuilder<ParseObject> newsQuery = QueryBuilder<ParseObject>(
        ParseObject('News'),
      )..orderByDescending('createdAt');
      ParseResponse newsApiResponse = await newsQuery.query();
      news = News.decode(
        newsApiResponse.results.toString(),
      );

      notifyListeners();
    } else {}
  }

  void addNews(BuildContext context, String title) async {
    final news = ParseObject('News')..set('Title', title);

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

  void deleteNews(BuildContext context, String id) async {
    final news = ParseObject('News')..set('objectId', id);

    var response = await news.delete();
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
