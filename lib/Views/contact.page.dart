import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:http/http.dart';
import 'package:latlong2/latlong.dart';
import 'package:missmalaika/Resources/Components/button.dart';
import 'package:missmalaika/Resources/Components/reusable.dart';
import 'package:missmalaika/Resources/Components/text_fields.dart';
import 'package:missmalaika/Resources/Constants/app_providers.dart';
import 'package:missmalaika/Resources/Constants/enums.dart';
import 'Home/footer.widget.dart';
import '../Resources/Components/texts.dart';
import '../Resources/Constants/global_variables.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  TextEditingController _emailCtrller = TextEditingController(),
      _nameCtrller = TextEditingController(),
      _subjectCtrller = TextEditingController(),
      _msgCgtrller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListView(physics: const BouncingScrollPhysics(), children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidgets.textBold(
                title: 'Contact',
                fontSize: 24,
                textColor: AppColors.kBlackColor),
            const SizedBox(
              height: 24,
            ),
            TextWidgets.textNormal(
                title:
                    """MISS MALAIKA est une compétition organisée à Goma par OZZONE Productions, NAWEZA Foundation et AGRORECOLT pour célébrer la jeune femme congolaise, belle et future pilier de la nation. La compétition s'étale sur 4 mois, de Mai à Aout 2023, avec des candidates des 18 quartiers de Goma.
                              """,
                fontSize: 14,
                textColor: AppColors.kBlackColor),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              width: double.maxFinite,
              height: 400,
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(-1.6582840671144308, 29.172952784110876),
                  zoom: 18,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        // "https://mt.google.com/vt/lyrs=y&x={x}&y={y}&z={z}"
                        "https://mt.google.com/vt/lyrs=m&x={x}&y={y}&z={z}",

                    // 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    // userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  ),
                  // RichAttributionWidget(
                  //   popupInitialDisplayDuration: const Duration(seconds: 5),
                  //   animationConfig: const ScaleRAWA(),
                  //   showFlutterMapAttribution: false,
                  //   attributions: [
                  //     TextSourceAttribution(
                  //       'OpenStreetMap contributors',
                  //       onTap: () => launchUrl(
                  //         Uri.parse('https://openstreetmap.org/copyright'),
                  //       ),
                  //     ),
                  //     const TextSourceAttribution(
                  //       'This attribution is the same throughout this app, except where otherwise specified',
                  //       prependCopyright: false,
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            FlexWidget(content: [
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_city,
                          color: AppColors.kPrimaryColor,
                          size: 40,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidgets.textNormal(
                                title: "Goma, Nord-Kivu, DRC",
                                fontSize: 18,
                                textColor: AppColors.kBlackColor),
                            TextWidgets.textNormal(
                                title: "57 Avenue Kizito, Keshero",
                                fontSize: 14,
                                textColor: AppColors.kGreyColor)
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.call,
                          color: AppColors.kPrimaryColor,
                          size: 40,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidgets.textNormal(
                                title: "+243 998647551",
                                fontSize: 18,
                                textColor: AppColors.kBlackColor),
                            TextWidgets.textNormal(
                                title: "Du lundi au samedi",
                                fontSize: 14,
                                textColor: AppColors.kGreyColor)
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.mail,
                          color: AppColors.kPrimaryColor,
                          size: 40,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidgets.textNormal(
                                title: "info@missmalaikardc.com",
                                fontSize: 18,
                                textColor: AppColors.kBlackColor),
                            TextWidgets.textNormal(
                                title: "Contactez-nous",
                                fontSize: 14,
                                textColor: AppColors.kGreyColor)
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormFieldWidget(
                        editCtrller: _nameCtrller,
                        hintText: 'Saisissez votre nom complet',
                        label: "Nom",
                        textColor: AppColors.kBlackColor,
                        backColor: AppColors.kTextFormBackColor),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormFieldWidget(
                        editCtrller: _emailCtrller,
                        hintText: 'Entrez votre email',
                        label: "E-mail",
                        textColor: AppColors.kBlackColor,
                        backColor: AppColors.kTextFormBackColor),
                    TextFormFieldWidget(
                        editCtrller: _subjectCtrller,
                        hintText: 'Entrez le sujet du message',
                        label: 'Sujet',
                        textColor: AppColors.kBlackColor,
                        backColor: AppColors.kTextFormBackColor),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormFieldWidget(
                        editCtrller: _msgCgtrller,
                        hintText: 'Entrez le message',
                        label: 'Message',
                        maxLines: 9,
                        textColor: AppColors.kBlackColor,
                        backColor: AppColors.kTextFormBackColor),
                    CustomButton(
                        text: "J'envoi le message",
                        backColor: AppColors.kPrimaryColor,
                        textColor: AppColors.kWhiteColor,
                        callback: () async {
                          if (_emailCtrller.text.isEmpty ||
                              _subjectCtrller.text.isEmpty ||
                              _msgCgtrller.text.isEmpty) {
                            ToastNotification.showToast(
                                msg: "Veuillez remplir tous les champs",
                                msgType: MessageType.error,
                                title: "Valeurs invalides",
                                isToast: true);
                            return;
                          }
                          Map data = {
                            "sender_email": _emailCtrller.text.trim(),
                            "sender_name": _nameCtrller.text.trim(),
                            "subject": _subjectCtrller.text.trim(),
                            "content": _msgCgtrller.text.trim(),
                          };
                          Response res = await AppProviders.appProvider
                              .httpPost(url: BaseUrl.mailing, body: data);

                          if (res.statusCode == 200) {
                            ToastNotification.showToast(
                                msg: "Message envoyé",
                                msgType: MessageType.success,
                                title: "Success",
                                isToast: true);
                            _msgCgtrller.text = '';
                            _emailCtrller.text = '';
                            _nameCtrller.text = '';
                            _subjectCtrller.text = '';
                            setState(() {});
                          }
                        })
                  ],
                ),
              )
            ]),
            FooterWidget()
          ],
        ),
      ),
    ]);
  }
}
