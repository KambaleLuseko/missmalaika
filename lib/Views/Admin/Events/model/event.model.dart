class EventModel {
  String? id;
  String? eventName;
  String? eventDescription;
  String? eventCategorie;
  String? eventDate;
  String? price;
  String? places;
  String? isActive;
  String? state;
  String? createdAt;

  EventModel(
      {this.id,
      this.eventName,
      this.eventDescription,
      this.eventCategorie,
      this.eventDate,
      this.price,
      this.places,
      this.isActive,
      this.state,
      this.createdAt});

  static fromJson(Map<String, dynamic> json) {
    EventModel data = EventModel()
      ..id = json['id']
      ..eventName = json['eventName']
      ..eventDescription = json['eventDescription']
      ..eventCategorie = json['eventCategorie']
      ..eventDate = json['eventDate']
      ..price = json['price']
      ..places = json['places']
      ..isActive = json['isActive']
      ..state = json['state']
      ..createdAt = json['created_at'];
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['eventName'] = eventName;
    data['eventDescription'] = eventDescription;
    data['eventCategorie'] = eventCategorie;
    data['eventDate'] = eventDate;
    data['price'] = price;
    data['places'] = places;
    data['isActive'] = isActive;
    data['state'] = state;
    data['created_at'] = createdAt;
    return data;
  }
}
