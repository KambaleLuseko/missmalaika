import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../Components/button.dart';
import '../Components/dialogs.dart';
import '../Components/text_fields.dart';
import '../Components/texts.dart';
import '../Constants/app_providers.dart';
import '../Constants/enums.dart';
import '../Constants/global_variables.dart';
import '../Helpers/uuid_generator.dart';
import '../Models/partner.model.dart';
import '../Models/payment.model.dart';

class CandidateProvider extends ChangeNotifier {
  ClientModel? newClient;

  setClient({required ClientModel client}) {
    newClient = client;
    notifyListeners();
  }

  save(
      {required ClientModel data,
      EnumActions? action = EnumActions.SAVE,
      required Function callback}) async {
    // print(jsonEncode(data.toJSON()));
    // return;
    Response response;
    response = await AppProviders.appProvider.httpPost(
        url: BaseUrl.saveData,
        body: {"transaction": "newcandidate", ...data.toJSON()});
    // print(response.body);
    // print(response.statusCode);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var decoded = jsonDecode(response.body);
      if (decoded['state'].toString().toLowerCase() == 'success') {
        callback();
        fileBytes = null;

        ToastNotification.showToast(
            msg:
                "Félicitations !\nVotre inscription a bien été reçue. \nVeuillez vérifier votre adresse mail pour activer votre compte candidate. Ou fermez et cliquez ici sur le bouton J'ACTIVE MON COMPTE pour procéder au paiement de votre inscription.",
            msgType: MessageType.success,
            title: 'Success');
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
      callback();
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

  Uint8List? fileBytes;
  setPickedFile({required Uint8List data}) {
    fileBytes = data;
    newClient?.imageBytes = base64Encode(data);
    notifyListeners();
  }

  List<CandidateModel> offlineData = [];
  getOnline({bool? isRefresh = false, String? value}) async {
    if (isRefresh == false && offlineData.isNotEmpty) return;
    var response = await AppProviders.appProvider.httpPost(
        url: BaseUrl.transaction, body: {"transaction": "getcandidate"});
    List data = [];
    // print(response.body);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) is String) return;
      data = jsonDecode(response.body);
    } else {
      return;
    }
    List<CandidateModel> dataList = List<CandidateModel>.from(
        data.map((item) => CandidateModel.fromJson(item)));
    offlineData = dataList;
    notifyListeners();
  }

  savePayment(
      {required PaymentModel data,
      EnumActions? action = EnumActions.SAVE,
      required Function callback}) async {
    Response response;
    if (data.type!.toLowerCase().contains('mobile')) {
      // print({
      //   "phonenumber": data.number,
      //   "amount": data.totalAmount,
      //   "currency": data.currency,
      //   "event_id": data.eventID,
      //   "userUUID": data.userUUID,
      // });
      // return;
      response = await AppProviders.appProvider
          .httpPost(url: BaseUrl.allPaymentUrl, body: {
        "gateway": data.type,
        "action": data.action ?? 'Inscription',
        "phonenumber": data.number,
        "amount": data.amount,
        "currency": data.currency,
        "event_id": data.eventId,
        "userUUID": data.userUUID,
      });
      handleMobilePayment(response: response, callback: callback);
    } else if (data.type!.toLowerCase().contains('illico')) {
      Map body = {
        "gateway": data.type,
        "action": data.action ?? 'Inscription',
        "phonenumber": data.number,
        "amount": data.amount,
        "currency": data.currency,
        "event_id": data.eventId,
        "userUUID": data.userUUID,
        "referencenumber": uuidGenerator(),
        "step": "getotp",
        "otp": "false",
      };
      response = await AppProviders.appProvider
          .httpPost(url: BaseUrl.allPaymentUrl, body: body);
      // response = Response("data", 200);

      handleIllicoPayment(response: response, callback: callback, data: body);
    } else {
      response = await AppProviders.appProvider
          .httpPost(url: BaseUrl.getData, body: {"transaction": "getevent"});
    }
    // return;
    // print(response.body);
    // print(response.statusCode);
    // if (response.statusCode >= 200 && response.statusCode < 300) {
    //   var decoded = jsonDecode(response.body);
    //   if (decoded['code'].toString().toLowerCase() == '0' &&
    //       decoded['orderNumber'] != null) {
    //     callback();
    //     ToastNotification.showToast(
    //         msg:
    //             "Paiement initié, confirmer sur le portable qui utilise ce numéro",
    //         msgType: MessageType.success,
    //         title: 'Success');
    //     notifyListeners();
    //     return;
    //   } else {
    //     ToastNotification.showToast(
    //         msg: decoded['message']?.toString().trim() ??
    //             decoded['error']?.toString().trim() ??
    //             'Une erreur est survenue',
    //         msgType: MessageType.error,
    //         title: 'Error');
    //   }
    // } else if (response.statusCode == 408 || response.statusCode == 500) {
    //   callback();
    //   ToastNotification.showToast(
    //       msg: "Erreur de connexion veuillez réessayer",
    //       msgType: MessageType.error,
    //       title: 'Error');

    //   notifyListeners();
    //   return;
    // } else {
    //   var decoded = jsonDecode(response.body);
    //   ToastNotification.showToast(
    //       msg: decoded['content']?.toString().trim() ??
    //           "Une erreur est survenue, veuillez contacter l'Administrateur",
    //       msgType: MessageType.error,
    //       title: 'Error');
    // }
  }

  reset() {
    newClient = null;
    offlineData.clear();
    fileBytes = null;
    notifyListeners();
  }

  handleMobilePayment(
      {required Response response, required Function callback}) {
    var decoded = jsonDecode(response.body);
    handleErrors(response: response);
    if (decoded['code'].toString().toLowerCase() == '0' &&
        decoded['orderNumber'] != null) {
      callback();
      ToastNotification.showToast(
          msg:
              "Paiement initié, confirmer sur le portable qui utilise ce numéro",
          msgType: MessageType.success,
          title: 'Success');
      notifyListeners();
      return;
    } else {
      ToastNotification.showToast(
          msg: decoded['message']?.toString().trim() ??
              decoded['error']?.toString().trim() ??
              'Une erreur est survenue',
          msgType: MessageType.error,
          title: 'Error');
      return;
    }
  }

  handleErrors({required Response response}) {
    if (response.statusCode == 408 || response.statusCode == 500) {
      ToastNotification.showToast(
          msg: "Erreur de connexion veuillez réessayer",
          msgType: MessageType.error,
          title: 'Error');
      return;
    } else if (response.statusCode.toString().contains('40')) {
      var decoded = jsonDecode(response.body);
      ToastNotification.showToast(
          msg: decoded['content']?.toString().trim() ??
              decoded['message']?.toString().trim() ??
              decoded['respcodedesc']?.toString().trim() ??
              "Une erreur est survenue, veuillez contacter l'Administrateur",
          msgType: MessageType.error,
          title: 'Error');
      return;
    } else {}
  }

  handleIllicoPayment(
      {required Response response,
      required Function callback,
      required Map data}) {
    if (jsonDecode(response.body)['respcode'] == '00') {
      TextEditingController otpCtrller = TextEditingController();
      Dialogs.showDialogWithActionCustomContent(
          title: 'OTP',
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextWidgets.text300(
                  title:
                      'Veuillez saisir votre code OTP reçu pour valider la transaction.',
                  fontSize: 14,
                  textColor: AppColors.kBlackColor),
              const SizedBox(
                height: 24,
              ),
              TextFormFieldWidget(
                  editCtrller: otpCtrller,
                  inputType: TextInputType.number,
                  maxLength: 10,
                  maxLines: 1,
                  hintText: 'Code OTP',
                  textColor: AppColors.kBlackColor,
                  backColor: AppColors.kTextFormBackColor),
              CustomButton(
                text: 'Vérifier le code',
                backColor: AppColors.kPrimaryColor,
                textColor: AppColors.kWhiteColor,
                callback: () async {
                  if (otpCtrller.text.trim().isEmpty) {
                    ToastNotification.showToast(
                        msg: "Veuillez saisir le code",
                        title: "Code invalide",
                        msgType: MessageType.error);
                    return;
                  }
                  data['step'] = 'terminate';
                  data['otp'] = 'true';
                  Response result = await AppProviders.appProvider
                      .httpPost(url: BaseUrl.illicoUrl, body: data);
                  if (result.statusCode == 200 &&
                      jsonDecode(result.body)['respcode'] == '00') {
                    ToastNotification.showToast(
                        msg:
                            "Paiement ${data['action'].toString().toLowerCase()} effectué avec succès",
                        msgType: MessageType.error,
                        title: 'Error');
                    return;
                  }
                },
                canSync: true,
                size: 220,
                secondBackColor: AppColors.kBlackColor,
              )
            ],
          ));
      return;
    } else {
      var decoded = jsonDecode(response.body);
      ToastNotification.showToast(
          msg: decoded['content']?.toString().trim() ??
              decoded['message']?.toString().trim() ??
              decoded['respcodedesc']?.toString().trim() ??
              "Une erreur est survenue, veuillez contacter l'Administrateur",
          msgType: MessageType.error,
          title: 'Error');
      return;
    }
  }
}
