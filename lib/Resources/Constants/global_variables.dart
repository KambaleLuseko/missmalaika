import 'package:flutter/material.dart';

import '../../main.dart';
import '../Components/dialogs.dart';
import '../Components/texts.dart';
import 'enums.dart';
import 'responsive.dart';

Map<String, String> headers = {
  'Accept': '*/*',
  // 'Accept': 'application/json; charset=UTF-8',
  'Content-Type': 'application/json',
  // 'Authorization': 'Bearer ${Provider.of<AppStateProvider>(navKey.currentContext!, listen: false).userToken}'
};

double kDefaultPadding = 16;
String walkinCustomUUID = "00000000000000";

class AppColors {
  static Color kPrimaryColor = const Color.fromRGBO(109, 8, 15, 1);
  static Color kSecondaryColor = const Color.fromRGBO(60, 60, 60, 1);
  static Color kScaffoldColor = const Color.fromRGBO(239, 239, 239, 1);
  static Color kAccentColor = const Color.fromRGBO(60, 60, 60, 1);
  static Color kBlackColor = const Color.fromRGBO(0, 0, 0, 1);

  // static Color kBlackColor = Colors.black;
  static Color kBlackLightColor = const Color.fromRGBO(40, 40, 40, 1);
  static Color kWhiteColor = Colors.white;
  static Color kWhiteDarkColor = Colors.grey.shade400;
  static Color kGreenColor = const Color.fromRGBO(72, 131, 80, 1);
  static Color kRedColor = Colors.red;
  static Color kBlueColor = Colors.blue;
  static Color kGreyColor = Colors.grey;
  static Color kWarningColor = Colors.orange;

  // static Color kYellowColor = const Color.fromRGBO(255, 184, 57, 1);
  static Color kYellowColor = const Color.fromRGBO(255, 185, 35, 1);
  static Color kTextFormWhiteColor = Colors.white.withOpacity(0.05);
  static Color kTextFormBackColor = Colors.black.withOpacity(0.05);
  static Color kTransparentColor = Colors.transparent;
}

class BaseUrl {
  // static String ip = "http://asmontruwenzori.org/cloud_functions/api";
  // static String ip = "http://127.0.0.1:8000";
  static String mailIP = "https://testprojects01.000webhostapp.com/malaika/api";
  static String ip = "https://missmalaikardc.com/api";
  // static String ip = "http://app.missmalaikardc.com/api";
  static String paymentURL = "$ip/vendor-frameworks/php/flexpayapi.php";
  static String illicoUrl = "$ip/vendor-frameworks/php/illicocashapi.php";
  static String allPaymentUrl = "$ip/vendor-frameworks/php/payment.php";
  static String apiUrl = ip;
  static String getData = '$apiUrl/get_data.php';
  static String saveData = '$apiUrl/saveFunctions.php';
  static String mailing = '$apiUrl/send_mail.php';
  static String cardPayment =
      '$apiUrl/vendor-frameworks/card/confirm_payment.php';
  static String transaction = '$apiUrl/transactions.php';
  static String stats = '$apiUrl/stats/';

  //=================User========================
}

class ToastNotification {
  static showToast(
      {required String msg,
      String title = "Information",
      Alignment? align = Alignment.topCenter,
      MessageType? msgType = MessageType.warning,
      bool? isToast = false}) {
    if (isToast == false) {
      Dialogs.showDialogNoAction(title: title, content: msg);
      return;
    }
    // showToastFullBack(msg: msg, title: title, msgType: msgType);
    ScaffoldMessenger.of(navKey.currentContext!).removeCurrentSnackBar();
    ScaffoldMessenger.of(navKey.currentContext!).showSnackBar(
      SnackBar(
        elevation: 5,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        margin: !Responsive.isMobile(navKey.currentContext!)
            ? EdgeInsets.only(
                left: align == Alignment.center
                    ? MediaQuery.of(navKey.currentContext!).size.width / 2.5
                    : MediaQuery.of(navKey.currentContext!).size.width / 1.5,
                right: align == Alignment.center
                    ? MediaQuery.of(navKey.currentContext!).size.width / 2.5
                    : 8,
                bottom: 8)
            : const EdgeInsets.only(left: 8, right: 8, bottom: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: AppColors.kWhiteColor,
        content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.kWhiteColor,
              // msgType == MessageType.error
              //     ? AppColors.kRedColor.withOpacity(0.1)
              //     : msgType == MessageType.success
              //         ? AppColors.kGreenColor.withOpacity(0.1)
              //         : AppColors.kWarningColor.withOpacity(0.1),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 56,
                  height: 64,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: msgType == MessageType.info
                        ? AppColors.kBlueColor
                        : msgType == MessageType.error
                            ? AppColors.kRedColor
                            : msgType == MessageType.success
                                ? AppColors.kGreenColor
                                : AppColors.kWarningColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    msgType == MessageType.info
                        ? Icons.info
                        : msgType == MessageType.error
                            ? Icons.cancel
                            : msgType == MessageType.success
                                ? Icons.check_circle
                                : Icons.warning_amber_rounded,
                    color: Colors.white,
                    // color: msgType == MessageType.info
                    //     ? AppColors.kBlueColor
                    //     : msgType == MessageType.error
                    //         ? AppColors.kRedColor
                    //         : msgType == MessageType.success
                    //             ? AppColors.kGreenColor
                    //             : AppColors.kWarningColor,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 4,
                        ),
                        TextWidgets.textBold(
                            title: title,
                            fontSize: 18,
                            textColor: msgType == MessageType.info
                                ? AppColors.kBlueColor
                                : msgType == MessageType.error
                                    ? AppColors.kRedColor
                                    : msgType == MessageType.success
                                        ? AppColors.kGreenColor
                                        : AppColors.kWarningColor),
                        TextWidgets.textNormal(
                            title: msg,
                            fontSize: 14,
                            textColor: msgType == MessageType.info
                                ? AppColors.kBlueColor
                                : msgType == MessageType.error
                                    ? AppColors.kRedColor
                                    : msgType == MessageType.success
                                        ? AppColors.kGreenColor
                                        : AppColors.kWarningColor),
                      ]),
                ),
              ],
            )),
      ),
    );
  }
}
