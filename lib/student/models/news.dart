import 'dart:convert';

class News{
  final String? id;
  final String? title;
  final DateTime? createdAt;

  News({this.id,this.title,
    this.createdAt,
  });

  factory News.fromJson(Map<String, dynamic> jsonData) {
    return News(
      id: jsonData['objectId'],
      title: jsonData['Title'],
      createdAt: DateTime.parse(jsonData['createdAt']),
    );
  }

  static Map<String, dynamic>? toMap(News news) => {
    'objectId' : news.id,
    'Title' : news.title,
    'createdAt': news.createdAt?.toIso8601String(),
  };

  static String encode(List<News> news) => json.encode(
    news.map<Map<String, dynamic>?>((newss) => News.toMap(newss)).toList(),
  );

  static List<News> decode(String news) =>
      (json.decode(news) as List<dynamic>)
          .map<News>((item) => News.fromJson(item))
          .toList();
}