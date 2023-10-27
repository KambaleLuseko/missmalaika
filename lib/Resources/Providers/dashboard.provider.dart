import 'dart:convert';

import 'package:flutter/material.dart';

import '../Constants/app_providers.dart';
import '../Constants/global_variables.dart';
import '../Models/dashboard.model.dart';

class DashboardProvider extends ChangeNotifier {
  DashboardModel? dashboardValue;
  getOnline({bool? isRefresh = false, String? value}) async {
    if (isRefresh == false && dashboardValue != null) return;
    var response = await AppProviders.appProvider.httpPost(
        url: BaseUrl.transaction,
        body: {"transaction": "getvotes", "uuid": value});
    Map data = {};
    // print(value);
    // print(response.body);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is String) return;
      data = jsonDecode(response.body);
    } else {
      return;
    }
    dashboardValue = DashboardModel.fromJson(data);
    notifyListeners();
  }

  reset() {
    dashboardValue = null;
    notifyListeners();
  }
}
