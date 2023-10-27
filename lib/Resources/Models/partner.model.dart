// import '../../Resources/Helpers/uuid_generator.dart';

import 'package:missmalaika/Resources/Models/dashboard.model.dart';
import 'package:missmalaika/Resources/Models/payment.model.dart';

import '../../Resources/Helpers/uuid_generator.dart';

class ClientModel {
  int? id;
  String fullname, phone, username, password;
  String? address, uuid, email, imageUrl, imageBytes;
  int? isActive;

  ClientModel(
      {this.uuid,
      required this.fullname,
      required this.phone,
      required this.username,
      required this.password,
      this.email,
      this.id,
      this.isActive,
      this.address,
      this.imageBytes,
      this.imageUrl});

  static fromJSON(json) {
    return ClientModel(
      uuid: json['uuid']?.toString(),
      fullname: json['fullname'] ?? '',
      phone: json['phone'] ?? '',
      id: int.tryParse(json['id'].toString()) ?? 0,
      email: json['email']?.toString(),
      username: json['username'].toString(),
      password: json['password'].toString(),
      address: json['address']?.toString(),
      isActive: int.tryParse(json['isActive'].toString()) ?? 1,
      imageBytes: json['imageBytes'],
      imageUrl: json['imageUrl'],
    );
  }

  toJSON() {
    return {
      "uuid": uuid ?? uuidGenerator(),
      "fullname": fullname,
      "phone": phone,
      "id": id,
      "email": email,
      "username": username,
      "password": password,
      "isActive": isActive,
      "address": address,
      "imageBytes": imageBytes,
      "imageUrl": imageUrl
    };
  }
}

class CandidateModel {
  String? id;
  String? fullname;
  String? email, address;
  String? phone;
  String? uuid;
  String? createdAt;
  String? imageUrl;
  List<Event>? event;
  List<PaymentModel>? history;
  Votes? votes;
  int? isActive, status;

  CandidateModel(
      {this.id,
      this.fullname,
      this.email,
      this.address,
      this.phone,
      this.uuid,
      this.createdAt,
      this.event,
      this.imageUrl,
      this.history,
      this.votes,
      this.isActive,
      this.status});

  static fromJson(Map json) {
    // print(json['history']);
    CandidateModel data = CandidateModel()
      ..id = json['id']
      ..fullname = json['fullname']
      ..email = json['email']
      ..phone = json['phone']
      ..uuid = json['uuid']
      ..createdAt = json['created_at']
      ..imageUrl = json['imageUrl']
      ..event = <Event>[]
      ..history = []
      ..isActive = int.tryParse(json['isActive'].toString())
      ..status = int.tryParse(json['status'].toString())
      ..address = (json['address'].toString())
      ..votes = null;
    if (json['event'] != null) {
      json['event'].forEach((v) {
        data.event!.add(Event.fromJson(v));
      });
    }
    if (json['history'] != null) {
      json['history'].forEach((v) {
        data.history!.add(PaymentModel.fromJSON(v));
      });
    }
    data.votes = json['votes'] != null ? Votes.fromJson(json['votes']) : null;
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullname'] = fullname;
    data['email'] = email;
    data['phone'] = phone;
    data['uuid'] = uuid;
    data['created_at'] = createdAt;
    data['imageUrl'] = imageUrl;
    data['isActive'] = isActive;
    data['status'] = status;
    data['address'] = address;
    data['votes'] = votes?.toJson();
    if (event != null) {
      data['event'] = event!.map((v) => v.toJson()).toList();
    }
    if (history != null) {
      data['history'] = history!.map((v) => v.toJSON()).toList();
    }
    return data;
  }
}

class Event {
  String? eventName;
  String? eventDescription;
  String? price, eventID;

  Event({this.eventName, this.eventDescription, this.price, this.eventID});

  static fromJson(Map<String, dynamic> json) {
    Event data = Event()
      ..eventName = json['eventName']
      ..eventDescription = json['eventDescription']
      ..price = json['price']
      ..eventID = json['event_id'];
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['eventName'] = eventName;
    data['eventDescription'] = eventDescription;
    data['price'] = price;
    data['event_id'] = eventID;
    return data;
  }
}
