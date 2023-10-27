import 'package:flutter/material.dart';

import '../../Resources/Constants/enums.dart';
import '../../Resources/Constants/global_variables.dart';
import '../../Resources/Constants/navigators.dart';
import '../../Resources/Constants/responsive.dart';
import '../../main.dart';
import 'applogo.dart';
import 'button.dart';
import 'texts.dart';

class Dialogs {
  static showDialogNoAction(
      {BuildContext? context,
      MessageType? dialogType = MessageType.warning,
      required String title,
      required String content,
      double heightFactor = 2}) {
    return showDialog(
        context: navKey.currentContext!,
        builder: (BuildContext context) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(0),
                // height: MediaQuery.of(context).size.height /
                //     (heightFactor == 2 ? 2 : heightFactor),
                width: Responsive.isMobile(context)
                    ? MediaQuery.of(context).size.width
                    : MediaQuery.of(context).size.width / 2.5,
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(
                          left: 16.0,
                          top: 20.0 + 16.0,
                          right: 16.0,
                          bottom: 16.0),
                      margin: const EdgeInsets.only(top: 50.0, bottom: 50),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: AppColors.kWhiteColor,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black,
                                offset: Offset(0, 1),
                                blurRadius: 5),
                          ]),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const SizedBox(height: 20),
                          TextWidgets.textBold(
                              align: TextAlign.center,
                              title: title,
                              fontSize: 18,
                              textColor: AppColors.kBlackColor),
                          const SizedBox(
                            height: 15,
                          ),
                          SingleChildScrollView(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [Container(width: double.maxFinite)],
                              ),
                              TextWidgets.text300(
                                  title: content,
                                  fontSize: 14,
                                  textColor: AppColors.kBlackColor),
                            ],
                          )),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                    size: 120,
                                    callback: () async {
                                      Navigator.pop(navKey.currentContext!);
                                    },
                                    text: "Fermer",
                                    backColor: dialogType == MessageType.error
                                        ? AppColors.kRedColor
                                        : dialogType == MessageType.success
                                            ? AppColors.kGreenColor
                                            : AppColors.kPrimaryColor,
                                    textColor: AppColors.kWhiteColor),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      left: 50,
                      right: 50,
                      top: 0,
                      child: Center(
                        child: Container(
                            width: 100,
                            height: 100,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: AppColors.kWhiteColor,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            alignment: Alignment.bottomCenter,
                            child: const AppLogo(
                              size: Size(90, 90),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  static showDialogWithAction(
      {BuildContext? context,
      MessageType? dialogType = MessageType.warning,
      required String title,
      required String content,
      double heightFactor = 2,
      var callback}) {
    return showDialog(
        context: navKey.currentContext!,
        builder: (BuildContext context) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(0),
                // height: MediaQuery.of(context).size.height /
                //     (heightFactor == 2 ? 2 : heightFactor),
                width: Responsive.isMobile(context)
                    ? MediaQuery.of(context).size.width
                    : MediaQuery.of(context).size.width / 2.5,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.only(
                          left: 16.0,
                          top: 20.0 + 16.0,
                          right: 16.0,
                          bottom: 16.0),
                      margin: const EdgeInsets.only(top: 50.0, bottom: 50),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: AppColors.kWhiteColor,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black,
                                offset: Offset(0, 1),
                                blurRadius: 5),
                          ]),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const SizedBox(height: 20),
                          TextWidgets.textBold(
                              align: TextAlign.center,
                              title: title,
                              fontSize: 18,
                              textColor: AppColors.kBlackColor),
                          const SizedBox(
                            height: 15,
                          ),
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                ),
                                TextWidgets.text300(
                                    title: content,
                                    align: TextAlign.center,
                                    fontSize: 14,
                                    textColor: AppColors.kBlackColor),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                    callback: () async {
                                      Navigator.pop(context);
                                    },
                                    text: "Fermer",
                                    backColor: Colors.grey[200]!,
                                    textColor: AppColors.kBlackColor),
                              ),
                              const SizedBox(height: 20),
                              Expanded(
                                child: CustomButton(
                                    callback: () {
                                      Navigator.pop(context);
                                      callback();
                                    },
                                    text: "Confirmer",
                                    backColor: dialogType == MessageType.error
                                        ? AppColors.kRedColor
                                        : dialogType == MessageType.success
                                            ? AppColors.kGreenColor
                                            : AppColors.kPrimaryColor,
                                    textColor: AppColors.kWhiteColor),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      left: 50,
                      right: 50,
                      top: 0,
                      child: Center(
                        child: Container(
                            width: 100,
                            height: 100,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: AppColors.kWhiteColor,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            alignment: Alignment.bottomCenter,
                            child: const AppLogo(size: Size(90, 90))),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  static showDialogWithActionCustomContent(
      {BuildContext? context,
      MessageType? dialogType = MessageType.warning,
      required String title,
      required Widget content,
      double heightFactor = 2,
      var callback}) {
    return showDialog(
        context: navKey.currentContext!,
        builder: (BuildContext context) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(0),
                // height: MediaQuery.of(context).size.height /
                //     (heightFactor == 2 ? 2 : heightFactor),
                width: Responsive.isMobile(context)
                    ? MediaQuery.of(context).size.width
                    : MediaQuery.of(context).size.width / 2.5,
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(
                          left: 16.0,
                          top: 20.0 + 16.0,
                          right: 16.0,
                          bottom: 16.0),
                      margin: const EdgeInsets.only(top: 50.0, bottom: 50),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: AppColors.kWhiteColor,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black,
                                offset: Offset(0, 1),
                                blurRadius: 5),
                          ]),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const SizedBox(height: 20),
                          if (title.isNotEmpty)
                            TextWidgets.textBold(
                                align: TextAlign.center,
                                title: title,
                                fontSize: 22,
                                textColor: AppColors.kBlackColor),
                          if (title.isNotEmpty)
                            const SizedBox(
                              height: 15,
                            ),
                          Flexible(
                            child: content,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          if (callback != null)
                            Row(
                              children: [
                                Expanded(
                                  child: CustomButton(
                                      callback: () async {
                                        Navigator.pop(context);
                                      },
                                      text: "Fermer",
                                      backColor: Colors.grey[200]!,
                                      textColor: AppColors.kBlackColor),
                                ),
                                const SizedBox(height: 20),
                                Expanded(
                                  child: CustomButton(
                                      callback: () async {
                                        await callback();
                                        Navigator.pop(context);
                                      },
                                      text: "Confirmer",
                                      backColor: dialogType == MessageType.error
                                          ? AppColors.kRedColor
                                          : dialogType == MessageType.success
                                              ? AppColors.kGreenColor
                                              : AppColors.kPrimaryColor,
                                      textColor: AppColors.kWhiteColor),
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                    Positioned(
                      left: 50,
                      right: 50,
                      top: 0,
                      child: Center(
                        child: Container(
                            width: 100,
                            height: 100,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: AppColors.kWhiteColor,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            alignment: Alignment.bottomCenter,
                            child: const AppLogo(size: Size(90, 90))),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  static showChoiceDialog(
      {BuildContext? context,
      MessageType? dialogType = MessageType.warning,
      required String title,
      required Widget content,
      double heightFactor = 2,
      var callback}) {
    return showDialog(
        context: context ?? navKey.currentContext!,
        // barrierDismissible: true,
        builder: (BuildContext context) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(0),
                // height: MediaQuery.of(context).size.height /
                //     (heightFactor == 2 ? 2 : heightFactor),
                width: Responsive.isMobile(context)
                    ? MediaQuery.of(context).size.width
                    : MediaQuery.of(context).size.width / 2.5,
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * .75),
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(8),
                      // margin: const EdgeInsets.only(top: 8.0, bottom: 50),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: AppColors.kWhiteColor,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black,
                                offset: Offset(0, 1),
                                blurRadius: 5),
                          ]),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextWidgets.textBold(
                              align: TextAlign.center,
                              title: title,
                              fontSize: 14,
                              textColor: AppColors.kBlackColor),
                          const SizedBox(
                            height: 15,
                          ),
                          Flexible(
                            fit: FlexFit.loose,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [Row(), content],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  static showBottomModalSheet(
      {BuildContext? context, required Widget content}) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: AppColors.kTransparentColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        context: navKey.currentContext!,
        builder: (builder) {
          return Scaffold(
            backgroundColor: AppColors.kTransparentColor,
            body: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.only(bottom: 0),
                constraints: BoxConstraints(
                  maxWidth: Responsive.isMobile(navKey.currentContext!)
                      ? MediaQuery.of(navKey.currentContext!).size.width
                      : MediaQuery.of(navKey.currentContext!).size.width / 1.7,
                  minWidth: 10,
                  minHeight: 10,
                  maxHeight:
                      MediaQuery.of(navKey.currentContext!).size.height / 1.7,
                ),
                decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    color: AppColors.kWhiteColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                            color: AppColors.kPrimaryColor,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ),
                    Flexible(
                      child: content,
                    )
                    // SingleChildScrollView(
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [Row(), ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          );
        });
  }

  static showModalCustomWidth({
    required Widget content,
    double heightFactor = 2,
    double width = 400,
  }) {
    return showDialog(
        context: navKey.currentContext!,
        builder: (BuildContext context) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(0),
                // height: MediaQuery.of(context).size.height /
                //     (heightFactor == 2 ? 2 : heightFactor),
                width: Responsive.isMobile(context)
                    ? MediaQuery.of(context).size.width - 16
                    : width,
                child: Scaffold(
                  backgroundColor: AppColors.kTransparentColor,
                  body: Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 0),
                      constraints: BoxConstraints(
                        maxWidth: width,
                        minWidth: 10,
                        minHeight: 10,
                        maxHeight:
                            MediaQuery.of(navKey.currentContext!).size.height *
                                .75,
                      ),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          color: AppColors.kWhiteColor),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              fit: FlexFit.loose,
                              child: content,
                            )
                            // SingleChildScrollView(
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     mainAxisSize: MainAxisSize.min,
                            //     children: [Row(), ],
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }

  // static showDialogWithActionCustomContent(
  //     {required BuildContext context,
  //     required String title,
  //     required Widget content,
  //     required Function callback()}) {
  //   return showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       child: Dialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(16.0),
  //         ),
  //         elevation: 0,
  //         backgroundColor: Colors.transparent,
  //         child: Center(
  //           child: Container(
  //             height: MediaQuery.of(context).size.height / 2,
  //             child: Stack(
  //               children: <Widget>[
  //                 Container(
  //                   padding: EdgeInsets.only(
  //                       left: 16.0,
  //                       top: 20.0 + 16.0,
  //                       right: 16.0,
  //                       bottom: 16.0),
  //                   margin: EdgeInsets.only(top: 50.0, bottom: 50),
  //                   decoration: BoxDecoration(
  //                       shape: BoxShape.rectangle,
  //                       color: MyColors.whiteColor,
  //                       borderRadius: BorderRadius.circular(16.0),
  //                       boxShadow: [
  //                         BoxShadow(
  //                             color: Colors.black,
  //                             offset: Offset(0, 1),
  //                             blurRadius: 5),
  //                       ]),
  //                   child: Column(
  //                     children: <Widget>[
  //                       SizedBox(height: 20),
  //                       TextWidgets.textBoldCenter(
  //                           text: title,
  //                           size: 18,
  //                           textColor: MyColors.blackColor),
  //                       SizedBox(height: 10),
  //                       Expanded(
  //                           child: Center(
  //                         child: SingleChildScrollView(
  //                           child: Column(
  //                             children: [
  //                               Row(
  //                                 children: [
  //                                   Container(width: double.maxFinite)
  //                                 ],
  //                               ),
  //                               content
  //                             ],
  //                           ),
  //                         ),
  //                       )),
  //                       Row(
  //                         children: [
  //                           Expanded(
  //                             child: MyWidgets.buttonForm(
  //                                 callBack: () async {
  //                                   Navigator.pop(context);
  //                                 },
  //                                 title: "Annuler",
  //                                 backColor: Colors.grey[200],
  //                                 textColor: MyColors.blackColor),
  //                           ),
  //                           SizedBox(width: 20),
  //                           Expanded(
  //                             child: MyWidgets.buttonForm(
  //                                 callBack: () async {
  //                                   callback();
  //                                 },
  //                                 title: "Continuer",
  //                                 backColor: MyColors.appColor,
  //                                 textColor: MyColors.whiteColor),
  //                           ),
  //                         ],
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //                 Positioned(
  //                   left: 50,
  //                   right: 50,
  //                   top: 0,
  //                   child: Center(
  //                     child: Container(
  //                       width: 100,
  //                       height: 100,
  //                       padding: EdgeInsets.all(10.0),
  //                       decoration: BoxDecoration(
  //                         shape: BoxShape.rectangle,
  //                         color: MyColors.whiteColor,
  //                         borderRadius: BorderRadius.circular(100),
  //                       ),
  //                       alignment: Alignment.bottomCenter,
  //                       child: appLogo(width: 80, height: 80, isBlack: false),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ));
  // }

  static showModal({required Widget child}) {
    Widget page = Scaffold(
        backgroundColor: AppColors.kScaffoldColor,
        appBar: AppBar(),
        body: ListView(
            shrinkWrap: true,
            controller: ScrollController(),
            children: [child]));
    if (Responsive.isWeb(navKey.currentContext!)) {
      showDialog(
          barrierDismissible: true,
          barrierColor: AppColors.kBlackColor.withOpacity(0.3),
          // useRootNavigator: true,
          context: navKey.currentContext!,
          builder: (context) => Scaffold(
                backgroundColor: AppColors.kTransparentColor,
                body: AlertDialog(
                  contentPadding: const EdgeInsets.all(0),
                  backgroundColor: AppColors.kScaffoldColor,
                  content: Container(
                      constraints: BoxConstraints(
                          minHeight: 200,
                          maxHeight: MediaQuery.of(navKey.currentContext!)
                                  .size
                                  .height -
                              80),
                      width: Responsive.isMobile(context)
                          ? MediaQuery.of(navKey.currentContext!).size.width -
                              40
                          : MediaQuery.of(navKey.currentContext!).size.width /
                              1.9,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.clear,
                                      color: AppColors.kBlackColor,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Flexible(
                            child: ListView(
                                shrinkWrap: true,
                                controller: ScrollController(),
                                children: [child]),
                          ),
                        ],
                      )),
                ),
              ));
    } else {
      Navigation.pushNavigate(page: page, isFullDialog: true);
    }
  }

  static showPositionedModal({required Widget child}) {
    Widget page = Scaffold(
        backgroundColor: AppColors.kScaffoldColor,
        appBar: AppBar(),
        body: ListView(
            shrinkWrap: true,
            controller: ScrollController(),
            children: [child]));
    if (Responsive.isWeb(navKey.currentContext!)) {
      showDialog(
          barrierDismissible: true,
          barrierColor: AppColors.kBlackColor.withOpacity(0.3),
          // useRootNavigator: true,
          useSafeArea: true,
          context: navKey.currentContext!,
          builder: (context) => Scaffold(
                backgroundColor: AppColors.kTransparentColor,
                body: Dialog(
                  insetPadding: EdgeInsets.zero,
                  // contentPadding: const EdgeInsets.all(0),
                  backgroundColor: AppColors.kTransparentColor,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned(
                        top: 0,
                        bottom: 0,
                        right: 0,
                        left: MediaQuery.of(context).size.width / 1.8,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                              width: double.maxFinite,
                              color: AppColors.kScaffoldColor,
                              constraints: const BoxConstraints(
                                minHeight: 200,
                              ),
                              // width: Responsive.isMobile(context)
                              //     ? MediaQuery.of(navKey.currentContext!)
                              //             .size
                              //             .width -
                              //         40
                              //     : MediaQuery.of(navKey.currentContext!)
                              //             .size
                              //             .width /
                              //         1.9,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButtonWidget(
                                          backColor:
                                              AppColors.kTransparentColor,
                                          textColor: AppColors.kBlackColor,
                                          callback: () {
                                            Navigator.pop(context);
                                          },
                                          icon: Icons.clear)
                                    ],
                                  ),
                                  Expanded(
                                    child: child,
                                  )
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
    } else {
      Navigation.pushNavigate(page: page, isFullDialog: true);
    }
  }
}
