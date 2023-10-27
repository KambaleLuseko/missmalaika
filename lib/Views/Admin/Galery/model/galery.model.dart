import '../../../../Resources/Helpers/uuid_generator.dart';

class GalleryModel {
  String? id;
  String? title;
  String? publisher;
  String? uuid;
  String? image;
  String? imageBytes;
  String? createdAt;

  GalleryModel(
      {this.id,
      this.title,
      this.publisher,
      this.uuid,
      this.image,
      this.imageBytes,
      this.createdAt});

  static fromJson(Map<String, dynamic> json) {
    GalleryModel data = GalleryModel()
      ..id = json['id']
      ..title = json['title']
      ..publisher = json['publisher']
      ..uuid = json['uuid']
      ..image = json['path']
      ..createdAt = json['created_at'];
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['publisher'] = publisher;
    data['uuid'] = uuid ?? uuidGenerator();
    data['path'] = image;
    data['imageBytes'] = imageBytes;
    data['created_at'] = createdAt;
    return data;
  }
}
