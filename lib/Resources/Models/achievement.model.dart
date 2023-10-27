class AchievementModel {
  int? id;
  String title, comment, username;
  String images;

  AchievementModel(
      {required this.title,
      required this.comment,
      required this.images,
      required this.username,
      this.id});

  static fromJSON(json) {}

  toJSON() {
    return {
      "title": title.toString().trim(),
      "comment": comment.trim(),
      "username": username.trim(),
      "images": (images)
    };
  }
}

class GetAchievementModel {
  String? id;
  String? title;
  String? comment;
  String? username;
  String? createdAt;
  List<Images>? images;

  GetAchievementModel(
      {this.id,
      this.title,
      this.comment,
      this.username,
      this.createdAt,
      this.images});

  static fromJSON(json) {
    GetAchievementModel data = GetAchievementModel()
      ..id = json['id']
      ..title = json['title']
      ..comment = json['comment']
      ..username = json['username']
      ..createdAt = json['created_at']
      ..images = [];
    if (json['images'] != null) {
      json['images'].forEach((v) {
        data.images!.add(Images.fromJSON(v));
      });
    }
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['comment'] = comment;
    data['username'] = username;
    data['created_at'] = createdAt;
    data['images'] = images?.map((v) => v.toJson()).toList() ?? [];
    return data;
  }
}

class Images {
  String? id;
  String? name;
  String? postRef;
  String? createdAt;

  Images({this.id, this.name, this.postRef, this.createdAt});

  static fromJSON(Map<String, dynamic> json) {
    Images data = Images()
      ..id = json['id']
      ..name = json['name']
      ..postRef = json['post_ref']
      ..createdAt = json['created_at'];
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['post_ref'] = postRef;
    data['created_at'] = createdAt;
    return data;
  }
}

class MediaModel {
  String? id;
  String? uuid;
  String? title;
  String? comment;
  String? username;
  String? link;
  String? createdAt;

  MediaModel(
      {this.id,
      this.uuid,
      this.title,
      this.comment,
      this.username,
      this.link,
      this.createdAt});

  static fromJSON(Map<String, dynamic> json) {
    MediaModel data = MediaModel()
      ..id = json['id']
      ..uuid = json['uuid']
      ..title = json['title']
      ..comment = json['comment']
      ..username = json['username']
      ..link = json['link']
      ..createdAt = json['created_at'];
    return data;
  }

  Map<String, dynamic> toJSON() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id ?? '';
    data['uuid'] = uuid ?? '';
    data['title'] = title;
    data['comment'] = comment;
    data['username'] = username;
    data['link'] = link;
    data['created_at'] = createdAt ?? '';
    return data;
  }
}
