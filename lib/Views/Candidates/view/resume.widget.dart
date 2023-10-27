import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Resources/Components/texts.dart';
import '../../../Resources/Constants/enums.dart';
import '../../../Resources/Constants/global_variables.dart';
import '../../../Resources/Models/partner.model.dart';
import '../../../Resources/Models/payment.model.dart';
import '../../../Resources/Providers/candidates.provider.dart';

class ResumeWidget extends StatefulWidget {
  ClientModel? client;
  Function callback;
  ResumeWidget({Key? key, this.client, required this.callback})
      : super(key: key);

  @override
  State<ResumeWidget> createState() => _ResumeWidgetState();
}

class _ResumeWidgetState extends State<ResumeWidget> {
  List<PaymentModel> payments = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      total = payments
          .map((e) => double.parse(e.amount ?? '0'))
          .fold(0.0, (prev, next) => prev + next);
      setState(() {});
    });
  }

  String? paymentGateway;

  double total = 0;
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.kTransparentColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 24,
                ),
                Center(
                  child: Stack(
                    children: [
                      SizedBox(
                          width: 80,
                          height: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(150),
                            child: context
                                        .select<CandidateProvider, Uint8List?>(
                                            (provider) => provider.fileBytes) ==
                                    null
                                ? Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(120),
                                        border: Border.all(
                                            color: AppColors.kBlackColor)),
                                    child: Center(
                                      child: Icon(
                                        Icons.person,
                                        size: 72,
                                        color: AppColors.kBlackColor,
                                      ),
                                    ),
                                  )
                                : Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(120),
                                        border: Border.all(
                                            color: AppColors.kBlackColor)),
                                    child: Image.memory(
                                      context.select<CandidateProvider,
                                              Uint8List?>(
                                          (provider) => provider.fileBytes)!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ) //load image from file
                          ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () async {
                              await FilePicker.platform
                                  .pickFiles(
                                      allowMultiple: false,
                                      allowedExtensions: ['jpeg', 'jpg', 'png'],
                                      withData: true,
                                      dialogTitle: "Choisissez votre photo",
                                      type: FileType.custom)
                                  .then((value) {
                                if (value != null) {
                                  if ((value.files.single.size /
                                          (1024 * 1024)) >
                                      1) {
                                    ToastNotification.showToast(
                                        msg:
                                            "Taille de l'image non supportée.\nVeuillez choisir une image inférieure a 1mb",
                                        title: "Taille invalide",
                                        msgType: MessageType.error);
                                    return;
                                  }
                                  context
                                      .read<CandidateProvider>()
                                      .setPickedFile(
                                          data: value.files.single.bytes!);
                                  setState(() {});
                                }
                              }).catchError((error) {
                                print(error.toString());
                              });
                            },
                            child: Card(
                              elevation: 0,
                              color: AppColors.kBlackColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(48)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 24,
                                  color: AppColors.kWhiteColor,
                                ),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
                Card(
                  color: AppColors.kTextFormBackColor,
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(),
                              TextWidgets.textHorizontalWithLabel(
                                  title: "Nom",
                                  fontSize: 16,
                                  textColor: AppColors.kBlackColor,
                                  value: widget.client?.fullname ?? ''),
                              TextWidgets.textHorizontalWithLabel(
                                  title: "E-mail",
                                  fontSize: 16,
                                  textColor: AppColors.kBlackColor,
                                  value: widget.client?.email ?? ''),
                              TextWidgets.textHorizontalWithLabel(
                                  title: "Telephone",
                                  fontSize: 16,
                                  textColor: AppColors.kBlackColor,
                                  value: widget.client?.phone ?? ''),
                              TextWidgets.textHorizontalWithLabel(
                                  title: "Adresse",
                                  fontSize: 16,
                                  textColor: AppColors.kBlackColor,
                                  value: widget.client?.address ?? ''),
                              TextWidgets.textHorizontalWithLabel(
                                  title: "Utilisateur",
                                  fontSize: 16,
                                  textColor: AppColors.kBlackColor,
                                  value: widget.client?.username ?? ''),
                              // TextWidgets.textBold(
                              //     title: widget.client?.fullname ?? '',
                              //     fontSize: 16,
                              //     textColor: AppColors.kBlackColor),
                              // const SizedBox(height: 8),
                              // TextWidgets.text300(
                              //     icon: Icons.call,
                              //     title: widget.client?.phone ?? '',
                              //     fontSize: 14,
                              //     textColor: AppColors.kBlackColor),
                              // const SizedBox(height: 8),
                              // TextWidgets.text300(
                              //     icon: Icons.mail,
                              //     title: widget.client?.email ?? '',
                              //     fontSize: 12,
                              //     textColor: AppColors.kBlackColor),
                              // const SizedBox(height: 8),
                              // TextWidgets.text300(
                              //     icon: Icons.location_city,
                              //     title: widget.client?.address ?? '',
                              //     fontSize: 12,
                              //     textColor: AppColors.kBlackColor),
                              // const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 48,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     TextWidgets.textBold(
                //         title: 'Paiement',
                //         fontSize: 18,
                //         textColor: AppColors.kBlackColor),
                //     TextWidgets.textBold(
                //         title: "USD 0",
                //         fontSize: 18,
                //         textColor: AppColors.kGreenColor),
                //   ],
                // ),
                // const SizedBox(
                //   height: 8,
                // ),
                // Column(
                //   children: [
                //     CustomDropdownButton(
                //         backColor: AppColors.kTextFormBackColor,
                //         dropdownColor: AppColors.kWhiteColor,
                //         textColor: AppColors.kBlackColor,
                //         displayLabel: false,
                //         value: paymentGateway,
                //         hintText: "Moyen de paiement",
                //         callBack: (value) {
                //           paymentGateway = value;
                //           setState(() {});
                //         },
                //         items: const ['Mobile Money', 'Carte bancaire']),
                //     TextFormFieldWidget(
                //       hintText: 'Numero *',
                //       textColor: AppColors.kBlackColor,
                //       backColor: AppColors.kTextFormBackColor,
                //       editCtrller: _numberCtrller,
                //       inputType: TextInputType.number,
                //       maxLines: 1,
                //     ),
                //     if (paymentGateway?.toLowerCase() != 'mobile money')
                //       TextFormFieldWidget(
                //         hintText: 'Date expiration *',
                //         textColor: AppColors.kBlackColor,
                //         backColor: AppColors.kTextFormBackColor,
                //         editCtrller: _expiryDateCtrller,
                //         inputType: TextInputType.text,
                //         maxLines: 1,
                //       ),
                //     if (paymentGateway?.toLowerCase() != 'mobile money')
                //       TextFormFieldWidget(
                //         hintText: 'CVV *',
                //         textColor: AppColors.kBlackColor,
                //         backColor: AppColors.kTextFormBackColor,
                //         editCtrller: _cvvCtrller,
                //         inputType: TextInputType.number,
                //         maxLines: 1,
                //       ),
                //     TextFormFieldWidget(
                //       hintText: 'Nom du proprietaire *',
                //       textColor: AppColors.kBlackColor,
                //       backColor: AppColors.kTextFormBackColor,
                //       editCtrller: _cardNameCtrller,
                //       inputType: TextInputType.text,
                //       maxLines: 1,
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ));
  }
}
