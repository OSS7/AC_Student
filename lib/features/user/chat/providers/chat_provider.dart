import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ChatProvider extends ChangeNotifier {
  final LiveQuery liveQuery = LiveQuery();
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject("Messages"));

  List<ParseObject> messages = [];

  void startLiveQuery(int userDep, int userYear) async {
    Subscription subscription = await liveQuery.client.subscribe(
      query
        ..whereEqualTo(
          'user_year',
          userYear,
        )
        ..whereEqualTo(
          'user_department',
          userDep,
        ),
    );

    subscription.on(LiveQueryEvent.create, (value) {
      debugPrint("OBJECT CREATED: $value");
      messages.add(value);
      notifyListeners();
      // scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });

    subscription.on(LiveQueryEvent.update, (value) {
      debugPrint("OBJECT UPDATED: $value");
    });

    subscription.on(LiveQueryEvent.delete, (value) {
      debugPrint("OBJECT DELETED: $value");
      messages.removeWhere((element) => element.objectId == value);
      notifyListeners();
    });

    subscription.on(LiveQueryEvent.enter, (value) {
      debugPrint("OBJECT ENTERED: $value");
    });

    subscription.on(LiveQueryEvent.leave, (value) {
      debugPrint("OBJECT LEFT: $value");
    });
  }

  Future<List<ParseObject>> getMessages() async {
    // int userYear = box.read('year');
    // int userDepartment= box.read('year');
    final ParseResponse apiResponse = await query.query();
    messages = apiResponse.results as List<ParseObject>;
    // scrollController.jumpTo(scrollController.position.maxScrollExtent);

    return messages;
  }

  Future addMessage(
      {required BuildContext context,
      required String message,
      required String user,
      required String userId,
      required int userImg,
      required int year,
      required int department}) async {
    final msg = ParseObject('Messages')
      ..set('message', message)
      ..set('user_id', userId)
      ..set('user_department', department)
      ..set('user_name', user)
      ..set('user_img', userImg)
      ..set('user_year', year);
    notifyListeners();
    await msg.save();
  }

  deleteMessage(BuildContext context, String id) async {
    final msg = ParseObject(
      'Messages',
    )..set(
        'objectId',
        id,
      );
    await msg.delete();
  }
}
