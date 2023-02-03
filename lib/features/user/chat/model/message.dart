import 'dart:convert';

class Message {
  String? message;
  String? userName;
  DateTime? createdAt;
  int? year;

  Message({this.message, this.userName, this.year, this.createdAt});

  factory Message.fromJson(Map<String, dynamic> jsonData) {
    return Message(
      // id: jsonData['id'],
      message: jsonData['message'],
      userName: jsonData['user_name'],
      createdAt: DateTime.parse(jsonData['createdAt']),
      year: jsonData['user_year'],
    );
  }

  static Map<String, dynamic>? toMap(Message msg) => {
        // 'id' : msg.id,
        'message': msg.message,
        'user_name': msg.userName,
        'createdAt': msg.createdAt,
        'user_year': msg.year,
      };

  static String encode(List<Message> msg) => json.encode(
        msg.map<Map<String, dynamic>?>((mssg) => Message.toMap(mssg)).toList(),
      );

  static List<Message> decode(String msg) => (json.decode(msg) as List<dynamic>)
      .map<Message>((item) => Message.fromJson(item))
      .toList();
}
