import 'dart:convert';

class Photo {
  final String? id;
  final String? url;
  final String? title;

  Photo({this.id, this.title, this.url});

  factory Photo.fromJson(Map<String, dynamic> jsonData) {
    return Photo(
      id: jsonData['objectId'],
      title: jsonData['title'],
      url: jsonData['image']['url'],
    );
  }

  static Map<String, dynamic>? toMap(Photo news) => {
        'objectId': news.id,
        'title': news.title,
        'url': news.url,
      };

  static String encode(List<Photo> news) => json.encode(
        news.map<Map<String, dynamic>?>((newss) => Photo.toMap(newss)).toList(),
      );

  static List<Photo> decode(String news) => (json.decode(news) as List<dynamic>)
      .map<Photo>((item) => Photo.fromJson(item))
      .toList();
}
