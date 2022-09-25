import 'dart:convert';

class Report{
  final String? id;
  final String? title;
  final DateTime? createdAt;

  Report({this.id,this.title,
    this.createdAt,
  });

  factory Report.fromJson(Map<String, dynamic> jsonData) {
    return Report(
      id: jsonData['objectId'],
      title: jsonData['title'],
      createdAt: DateTime.parse(jsonData['createdAt']),
    );
  }

  static Map<String, dynamic>? toMap(Report news) => {
    'objectId' : news.id,
    'title' : news.title,
    'createdAt': news.createdAt?.toIso8601String(),
  };

  static String encode(List<Report> report) => json.encode(
    report.map<Map<String, dynamic>?>((reports) => Report.toMap(reports)).toList(),
  );

  static List<Report> decode(String report) =>
      (json.decode(report) as List<dynamic>)
          .map<Report>((item) => Report.fromJson(item))
          .toList();
}