import '../Helpers/uuid_generator.dart';

class UserModel {
  final String fullname, countryCode, phone, password, type;
  String? email, uuid, verificationMode, createdAt;
  int? syncStatus, isActive, id;

  UserModel({
    required this.fullname,
    required this.phone,
    required this.countryCode,
    required this.password,
    required this.type,
    this.verificationMode,
    this.email,
    this.isActive,
    this.syncStatus,
    this.uuid,
    this.id,
    this.createdAt,
  });

  static fromJSON(json) {
    return UserModel(
      fullname: json['name'],
      countryCode: json['countryCode'],
      phone: json['phone'],
      password: json['password'],
      type: json['type'] ?? '',
      verificationMode: json['verificationMode'] ?? 'email',
      email: json['email'],
      isActive: int.tryParse(json['isActive'].toString()) ?? 1,
      syncStatus: int.tryParse(json['syncStatus'].toString()) ?? 0,
      uuid: json['uuid'],
      id: int.tryParse(json['id'].toString()) ?? 0,
      createdAt: json['createdAt']?.toString(),
    );
  }

  toJSON() {
    return {
      "name": fullname,
      "countryCode": countryCode,
      "phone": phone,
      "password": password,
      "type": type,
      "verificationMode": verificationMode ?? 'email',
      "email": email,
      "isActive": isActive ?? 1,
      "syncStatus": syncStatus ?? 1,
      "uuid": uuid ?? uuidGenerator(),
      "id": id,
      "createdAt": createdAt ?? DateTime.now().toString(),
    };
  }
}

class AuthModel {
  final UserModel user;
  final String token;
  AuthModel({required this.user, required this.token});

  static fromJSON(json) {
    return AuthModel(
        user: UserModel.fromJSON(json['user']), token: json['token']);
  }

  toJSON() {
    return {"user": user.toJSON(), 'token': token};
  }
}
