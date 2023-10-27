// import 'package:missmalaika/Resources/Helpers/uuid_generator.dart';

// class PaymentModel {
//   int? id;
//   String? uuid, createdAt, type, currency, action, points, paymentReference;
//   String number, expiryDate, cvv, cardName, totalAmount, userUUID, eventID;
//   PaymentModel(
//       {required this.number,
//       required this.totalAmount,
//       required this.expiryDate,
//       required this.cvv,
//       required this.cardName,
//       required this.userUUID,
//       required this.eventID,
//       this.type,
//       this.currency,
//       this.id,
//       this.uuid,
//       this.createdAt,
//       this.action = "Inscription",
//       this.points,
//       this.paymentReference});

//   static fromJSON(json) {
//     // print(json);
//     return PaymentModel(
//         number: json['number'],
//         expiryDate: json['expiryDate'],
//         cvv: json['cvv'],
//         cardName: json['cardName'],
//         totalAmount: json['amount']?.toString() ?? '0',
//         currency: json['currency'],
//         type: json['type'],
//         id: json['id'],
//         uuid: json['uuid'],
//         userUUID: json['userUUID'],
//         eventID: json['event_id'],
//         points: json['points'],
//         paymentReference: json['payment_reference'],
//         createdAt: json['createdAt'] ?? DateTime.now().toString(),
//         action: json['action']);
//   }

//   toJSON() {
//     return {
//       "id": id,
//       "uuid": uuid ?? uuidGenerator(),
//       "number": number,
//       "expiryDate": expiryDate,
//       "cvv": cvv,
//       "cardName": cardName,
//       "amount": totalAmount,
//       "type": type ?? "Mobile Money",
//       "currency": currency ?? "USD",
//       "userUUID": userUUID,
//       "event_id": eventID,
//       "points": points,
//       "payment_reference": paymentReference,
//       "createdAt": createdAt ?? DateTime.now().toString(),
//       "action": action ?? 'Inscription',
//     };
//   }
// }

class PaymentModel {
  String? id;
  String? number;
  String? type;
  String? amount;
  String? currency;
  String? expiryDate;
  String? cvv;
  String? userUUID;
  String? eventId;
  String? action;
  String? isPayed;
  String? points;
  String? paymentReference;
  String? createdAt;

  PaymentModel(
      {this.id,
      this.number,
      this.type,
      this.amount,
      this.currency,
      this.expiryDate,
      this.cvv,
      this.userUUID,
      this.eventId,
      this.action,
      this.isPayed,
      this.points,
      this.paymentReference,
      this.createdAt});

  static fromJSON(Map<String, dynamic> json) {
    PaymentModel data = PaymentModel()
      ..id = json['id']?.toString()
      ..number = json['number']
      ..type = json['type']
      ..amount = json['amount']
      ..currency = json['currency']
      ..expiryDate = json['expiryDate']
      ..cvv = json['cvv']
      ..userUUID = json['userUUID']
      ..eventId = json['event_id']?.toString()
      ..action = json['action']
      ..isPayed = json['isPayed']?.toString()
      ..points = json['points']?.toString()
      ..paymentReference = json['payment_reference']
      ..createdAt = json['created_at'];
    return data;
  }

  Map<String, dynamic> toJSON() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['number'] = number;
    data['type'] = type;
    data['amount'] = amount;
    data['currency'] = currency;
    data['expiryDate'] = expiryDate;
    data['cvv'] = cvv;
    data['userUUID'] = userUUID;
    data['event_id'] = eventId;
    data['action'] = action;
    data['isPayed'] = isPayed;
    data['points'] = points;
    data['payment_reference'] = paymentReference;
    data['created_at'] = createdAt;
    return data;
  }
}
