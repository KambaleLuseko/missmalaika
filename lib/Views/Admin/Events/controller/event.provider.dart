import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:missmalaika/Views/Admin/Events/model/event.model.dart';
import '../../../../Resources/Constants/app_providers.dart';
import '../../../../Resources/Constants/enums.dart';
import '../../../../Resources/Constants/global_variables.dart';

class EventProvider extends ChangeNotifier {
  List<EventModel> offlineData = [], latestData = [];

  save(
      {required EventModel data,
      EnumActions? action = EnumActions.SAVE,
      required Function callback}) async {
    // print(jsonEncode(data.toJSON()));
    // return;
    Response response;
    response = await AppProviders.appProvider.httpPost(
        url: BaseUrl.saveData,
        body: {"transaction": "addevent", ...data.toJson()});
    // print(response.body);
    // print(response.statusCode);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var decoded = jsonDecode(response.body);
      if (decoded['state'].toString().toLowerCase() == 'success') {
        callback();
        ToastNotification.showToast(
            msg: "L'événement a été enregistrés avec succès",
            msgType: MessageType.success,
            title: 'Success');
        if (action == EnumActions.UPDATE) {
          offlineData.where((element) => element.id == data.id).toList()[0] =
              data;
        }
        notifyListeners();
        return;
      } else {
        ToastNotification.showToast(
            msg: decoded['content']?.toString().trim() ??
                decoded['error']?.toString().trim() ??
                'Une erreur est survenue',
            msgType: MessageType.error,
            title: 'Error');
        return;
      }
    } else if (response.statusCode == 408 || response.statusCode == 500) {
      ToastNotification.showToast(
          msg: "Erreur de connexion veuillez réessayer",
          msgType: MessageType.error,
          title: 'Error');

      notifyListeners();
      return;
    } else {
      var decoded = jsonDecode(response.body);
      ToastNotification.showToast(
          msg: decoded['content']?.toString().trim() ??
              decoded['error']?.toString().trim() ??
              "Une erreur est survenue, veuillez contacter l'Administrateur",
          msgType: MessageType.error,
          title: 'Error');
    }
  }

  getOnline({bool? isRefresh = false, String? value}) async {
    if (isRefresh == false && offlineData.isNotEmpty) return;
    var response = await AppProviders.appProvider.httpPost(
        url: BaseUrl.getData,
        body: {"transaction": "getevent", "filter": value ?? 'active'});
    List data = [];
    // print(response.body);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is String) return;
      data = jsonDecode(response.body);
    } else {
      return;
    }
    List<EventModel> dataList =
        List<EventModel>.from(data.map((item) => EventModel.fromJson(item)));
    offlineData = dataList;
    latestData =
        dataList.length > 3 ? dataList.sublist(0, 3).toList() : dataList;
    notifyListeners();
  }

  deleteImage({required EventModel data}) async {
    var response =
        await AppProviders.appProvider.httpPost(url: BaseUrl.saveData, body: {
      "transaction": "deleteevent",
      "id": data.id,
    });

    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is String) return;
      if (jsonDecode(response.body)['state'].toString().toLowerCase() ==
          'ssucess') {
        offlineData.removeWhere((element) => element.id == data.id);
        latestData = offlineData.length > 3
            ? offlineData.sublist(0, 3).toList()
            : offlineData;
        notifyListeners();
      }
    }
  }
}
