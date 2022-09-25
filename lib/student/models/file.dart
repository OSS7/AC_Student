import 'dart:convert';

class File {
  final String? id;
  final int? subjectId;
  final String? link;
  final String? name;

  File({this.id,this.subjectId, this.link, this.name});

  factory File.fromJson(Map<String, dynamic> jsonData) {
    return File(
      id: jsonData['objectId'],
      subjectId: jsonData['subject_id'],
      name: jsonData['name'],
      link: jsonData['link'],
    );
  }

  static Map<String, dynamic>? toMap(File file) => {
        'objectId': file.id,
        'subject_id': file.subjectId,
        'name': file.name,
        'link': file.link,
      };

  static String encode(List<File> file) => json.encode(
        file.map<Map<String, dynamic>?>((files) => File.toMap(files)).toList(),
      );

  static List<File> decode(String file) => (json.decode(file) as List<dynamic>)
      .map<File>((item) => File.fromJson(item))
      .toList();
}
