import 'dart:convert';

class Variabel {
  final String? id;
  final bool? enable;
  final int? year;
  final int? department;

  Variabel({
    this.id,
    this.enable,
    this.year,
    this.department,
  });

  factory Variabel.fromJson(Map<String, dynamic> jsonData) {
    return Variabel(
      id: jsonData['objectId'],
      enable: jsonData['enable'],
      year: jsonData['year'],
      department: jsonData['department'],
    );
  }

  static List<Variabel> decode(String variable) =>
      (json.decode(variable) as List<dynamic>)
          .map<Variabel>((item) => Variabel.fromJson(item))
          .toList();
}
