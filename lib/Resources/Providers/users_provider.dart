import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../Resources/Constants/app_providers.dart';
import '../../Resources/Constants/enums.dart';
import '../../Resources/Constants/global_variables.dart';
import '../../main.dart';
import '../Models/partner.model.dart';
import '../Models/user.model.dart';
import 'candidates.provider.dart';
import 'dashboard.provider.dart';
import 'menu_provider.dart';

class UserProvider extends ChangeNotifier {
  String keyName = 'users';
  List<UserModel> offlineData = [], filteredData = [];

  save(
      {required UserModel data,
      EnumActions? action = EnumActions.SAVE,
      required Function callback}) async {
    if (data.fullname.isEmpty ||
        data.phone.isEmpty ||
        data.type.isEmpty ||
        data.password.isEmpty) {
      ToastNotification.showToast(
          msg: "Veuillez remplir tous les champs",
          msgType: MessageType.error,
          title: "Erreur");
      return;
    }
    if (action == EnumActions.UPDATE && data.uuid == null) {
      ToastNotification.showToast(
          msg: "Données invalides", msgType: MessageType.error, title: "Error");
      return;
    }
    // print(data.toJSON());
    // return;
    Response res;
    if (action == EnumActions.UPDATE) {
      res = await AppProviders.appProvider
          .httpPut(url: "${BaseUrl.getData}${data.uuid}", body: data.toJSON());
    } else {
      res = await AppProviders.appProvider
          .httpPost(url: BaseUrl.getData, body: data.toJSON());
    }
    if (res.statusCode >= 200 && res.statusCode < 300) {
      ToastNotification.showToast(
          msg: jsonDecode(res.body)['message'] ??
              "Informations sauvegardées avec succès",
          msgType: MessageType.success,
          title: "Success");
      notifyListeners();
      callback();
      return;
    }
    if (res.statusCode == 500) {
      ToastNotification.showToast(
          msg: jsonDecode(res.body)['message'] ??
              'Une erreur est survenue, veuillez réessayer',
          msgType: MessageType.info,
          title: "Information");
    }
    if (res.statusCode != 200 && res.statusCode != 500) {
      ToastNotification.showToast(
          msg: jsonDecode(res.body)['message'] ??
              'Une erreur est survenue, Veuillez réessayer plus tard',
          msgType: MessageType.error,
          title: "Erreur");
      return;
    }
  }

  getOnline({bool? isRefresh = false}) async {
    if (isRefresh == false && offlineData.isNotEmpty) return;
    var response = await AppProviders.appProvider.httpGet(url: BaseUrl.getData);
    List data = [];
    // print(response.body);
    if (response.statusCode == 200) {
      data = jsonDecode(response.body)['data'];
    }
    if (data.isEmpty) {
      offlineData.clear();
      notifyListeners();
      return;
    }
    notifyListeners();
  }

  validateSearch({required List<UserModel> data}) {
    filteredData = data;
    notifyListeners();
  }

  Map? connectedUser;
  login({required Map data, required Function callback}) async {
    if (data['username'].isEmpty) {
      ToastNotification.showToast(
          msg: "Veuillez saisir un nom d'utilisateur",
          msgType: MessageType.error,
          title: "Erreur");
      return;
    }
    if (data['password'].isEmpty) {
      ToastNotification.showToast(
          msg: "Veuillez remplir un mot de passe",
          msgType: MessageType.error,
          title: "Erreur");
      return;
    }
    Response res;

    res = await AppProviders.appProvider.httpPost(
        url: BaseUrl.getData, body: {"transaction": "login", ...data});
    // print(res.body);
    if (res.statusCode == 200) {
      // prefs.setString("loggedUser", (res.body));

      if (jsonDecode(res.body) is String) {
        ToastNotification.showToast(
            // align: Alignment.center,
            msg: "Identifiants invalides",
            msgType: MessageType.error,
            title: "Error");
        return;
      }
      Map userData = jsonDecode(res.body)[0];
      connectedUser = {"user": userData};
      prefs.setString('admin', jsonEncode(connectedUser));
      // ToastNotification.showToast(
      //     msg: "Connexion effectuée avec succès",
      //     msgType: MessageType.success,
      //     title: "Success");
      notifyListeners();
      callback();
      return;
    }
    // print(res.body);
    // print(jsonDecode(res.body));
    ToastNotification.showToast(
        // align: Alignment.center,
        msg: jsonDecode(res.body)['message'] ??
            "Username ou mot de passe incorrect",
        msgType: MessageType.error,
        title: "Error");
  }

  CandidateModel? candidate;
  fetchCandidate({
    required Map data,
    required Function callback,
  }) async {
    if (data['username'].isEmpty) {
      ToastNotification.showToast(
          msg: "Veuillez saisir un nom d'utilisateur",
          msgType: MessageType.error,
          title: "Erreur");
      return;
    }
    if (data['password'].isEmpty) {
      ToastNotification.showToast(
          msg: "Veuillez remplir un mot de passe",
          msgType: MessageType.error,
          title: "Erreur");
      return;
    }
    // return;
    Response res;

    res = await AppProviders.appProvider.httpPost(
        url: BaseUrl.transaction,
        body: {"transaction": "getcandidate", ...data});

    if (res.statusCode == 200) {
      // prefs.setString("loggedUser", (res.body));

      if (jsonDecode(res.body) is String) {
        ToastNotification.showToast(
            // align: Alignment.center,
            msg: "Identifiants invalides",
            msgType: MessageType.error,
            title: "Error");
        return;
      }
      // print(res.body);
      // return;
      List result = jsonDecode(res.body);
      if (result.length == 1) {
        Map userData = jsonDecode(res.body)[0];
        candidate = CandidateModel.fromJson(userData);
        connectedUser = userData;
        prefs.setString('candidate', jsonEncode(candidate!.toJson()));
        notifyListeners();
        callback();
      } else {
        // Navigator.pop(navKey.currentContext!);
        ToastNotification.showToast(
            // align: Alignment.center,
            msg: "Identifiants invalides",
            msgType: MessageType.error,
            title: "Error");
        return;
      }
      return;
    }
    // print(res.body);
    // print(jsonDecode(res.body));
    ToastNotification.showToast(
        // align: Alignment.center,
        msg: jsonDecode(res.body)['message'] ??
            "Username ou mot de passe incorrect",
        msgType: MessageType.error,
        title: "Error");
  }

  CandidateModel? userLogged;
  // ConnectedUser connectedUser = ConnectedUser.guest;
  getUserData() async {
    String? loggedUser = prefs.getString('candidate');
    userLogged = loggedUser != null
        ? CandidateModel.fromJson(jsonDecode(loggedUser))
        : null;
    candidate = userLogged;
    connectedUser = candidate?.toJson();

    notifyListeners();
  }

  reset() {
    userLogged = null;
    // userWallet = null;
    offlineData.clear();
    filteredData.clear();
    candidate = null;
    connectedUser = null;
  }

  logOut() {
    prefs.clear();
    // key = ValueKey(DateTime.now().toString());
    notifyListeners();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppProviders.appProvider.reset();
      connectedUser = null;
      notifyListeners();
      // LocalDataHelper.resetLocalData();
      // Navigation.pushRemove(page: const LoginPage());
      navKey.currentContext!.read<MenuProvider>().reset();
      navKey.currentContext!.read<DashboardProvider>().reset();
      navKey.currentContext!.read<CandidateProvider>().reset();
      navKey.currentContext!.read<UserProvider>().reset();
    });
    // Navigation.pushRemove(page: const LoginPage());
  }
}
