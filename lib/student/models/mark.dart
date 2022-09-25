import 'dart:convert';

class Mark {
  final String? id;
  final int? subjectId;
  final String? link;

  Mark({this.id,this.subjectId, this.link});

  factory Mark.fromJson(Map<String, dynamic> jsonData) {
    return Mark(
      id: jsonData['objectId'],
      subjectId: jsonData['subject_id'],
      link: jsonData['link'],
    );
  }

  static Map<String, dynamic>? toMap(Mark mark) => {
    'objectId': mark.id,
    'subject_id': mark.subjectId,
    'link': mark.link,
  };

  static String encode(List<Mark> mark) => json.encode(
    mark.map<Map<String, dynamic>?>((marks) => Mark.toMap(marks)).toList(),
  );

  static List<Mark> decode(String mark) => (json.decode(mark) as List<dynamic>)
      .map<Mark>((item) => Mark.fromJson(item))
      .toList();
}
