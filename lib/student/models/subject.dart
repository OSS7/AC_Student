import 'dart:convert';

class Subject{
  final int? id;
  final String? name;
  final int? year;
  final int? season;
  final int? department;

  Subject({this.id, this.name,this.season,this.year,this.department});

  factory Subject.fromJson(Map<String, dynamic> jsonData) {
    return Subject(
      // id: jsonData['id'],
      id: jsonData['subject_id'],
      name: jsonData['name'],
      season: jsonData['season'],
      year: jsonData['year'],
      department: jsonData['department'],
    );
  }

  static Map<String, dynamic>? toMap(Subject sub) => {
    // 'id' : msg.id,
    'subject_id' : sub.id,
    'name': sub.name,
    'season': sub.season,
    'year': sub.year,
    'department': sub.department,
  };

  static String encode(List<Subject> sub) => json.encode(
    sub.map<Map<String, dynamic>?>((subs) => Subject.toMap(subs)).toList(),
  );

  static List<Subject> decode(String sub) =>
      (json.decode(sub) as List<dynamic>)
          .map<Subject>((item) => Subject.fromJson(item))
          .toList();
}