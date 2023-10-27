import '../Helpers/uuid_generator.dart';

class NewsModel {
  String? id;
  String? title;
  String? summary;
  String? content;
  String? publisher;
  String? uuid;
  String? image;
  String? imageBytes;
  String? createdAt;

  NewsModel(
      {this.id,
      this.title,
      this.summary,
      this.content,
      this.publisher,
      this.uuid,
      this.image,
      this.imageBytes,
      this.createdAt});

  static fromJson(Map<String, dynamic> json) {
    NewsModel data = NewsModel()
      ..id = json['id']?.toString()
      ..title = json['title']
      ..summary = json['summary']
      ..content = json['content']
      ..publisher = json['publisher']
      ..uuid = json['uuid']
      ..image = json['image']
      ..createdAt = json['created_at'];
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['summary'] = summary;
    data['content'] = content;
    data['publisher'] = publisher;
    data['uuid'] = uuid ?? uuidGenerator();
    data['image'] = image;
    data['imageBytes'] = imageBytes;
    data['created_at'] = createdAt;
    return data;
  }
}
