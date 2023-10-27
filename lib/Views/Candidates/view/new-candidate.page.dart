import 'package:flutter/material.dart';
import '../../../Resources/Components/dialogs.dart';
import '../../../Resources/Components/texts.dart';
import '../../../Resources/Constants/enums.dart';
import '../../../Resources/Constants/global_variables.dart';
import '../../../Resources/Models/Menu/list_item.model.dart';
import '../../../Resources/Models/partner.model.dart';
import '../../../Resources/Providers/app_state_provider.dart';
import '../../../Resources/Providers/candidates.provider.dart';
import '../widgets/client-info.widget.dart';
import '../widgets/personal-client-info.widget.dart';
import 'resume.widget.dart';
import '../../parent.page.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NewCandidatePage extends StatefulWidget {
  const NewCandidatePage({super.key});

  @override
  State<NewCandidatePage> createState() => _NewCandidatePageState();
}

class _NewCandidatePageState extends State<NewCandidatePage> {
  int currentPage = 0;
  late PageController _pageCtrller;
  ChooseClientWidget clientData = ChooseClientWidget();
  PersonalClientInfoWidget personalClientData = PersonalClientInfoWidget();
  @override
  void initState() {
    super.initState();
    _pageCtrller = PageController(initialPage: currentPage, keepPage: false);
  }

  List<ListItemModel> titleSteppers = [
    ListItemModel(title: "Compte", value: "Compte du client"),
    ListItemModel(
        title: "Informations",
        value: "Informations personnelles de la candidate"),
    ListItemModel(title: "Resumé", value: "Informations fournies"),
  ];

  @override
  Widget build(BuildContext context) {
    return ParentPage(
        listData: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: TextWidgets.textBold(
                    title: "Nouvelle candidate",
                    fontSize: 24,
                    textColor: AppColors.kBlackColor),
              ),
              Card(
                margin: const EdgeInsets.all(8),
                color: AppColors.kTextFormBackColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // progressWidget(
                            //     title: "Etape",
                            //     max: 3,
                            //     value: currentPage + 1,
                            //     color: AppColors.kGreenColor),
                            CircularProgressIndicator(
                              strokeWidth: 8,
                              backgroundColor: AppColors.kTextFormBackColor,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.kPrimaryColor),
                              value: (currentPage + 1) / 3,
                            ),
                            const SizedBox(height: 8),
                            TextWidgets.text300(
                                title: "Etape ${currentPage + 1} sur 3",
                                fontSize: 12,
                                textColor: AppColors.kBlackColor)
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextWidgets.textBold(
                                title: titleSteppers[currentPage].title,
                                fontSize: 24,
                                textColor: AppColors.kBlackColor),
                            const SizedBox(height: 8),
                            TextWidgets.text300(
                                title: titleSteppers[currentPage].value,
                                fontSize: 12,
                                textColor: AppColors.kBlackColor)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: PageView(
                  controller: _pageCtrller,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: null,
                  scrollDirection: Axis.horizontal,
                  children: [
                    clientData,
                    personalClientData,
                    ResumeWidget(
                        callback: () {
                          currentPage = 0;
                          _pageCtrller.animateToPage(currentPage,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease);
                          setState(() {});
                        },
                        client: context.read<CandidateProvider>().newClient)
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (currentPage <= 2 && currentPage > 0)
                    InkWell(
                      onTap: () {
                        if (currentPage == 0) return;
                        currentPage--;
                        setState(() {});
                        _pageCtrller.animateToPage(currentPage,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease);
                      },
                      child: Card(
                        color: Colors.grey.shade200,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 32),
                          child: TextWidgets.text500(
                              title: "Retour",
                              fontSize: 18,
                              textColor: AppColors.kBlackColor),
                        ),
                      ),
                    ),
                  context.select<AppStateProvider, bool>(
                              (provider) => provider.isAsync) ==
                          false
                      ? InkWell(
                          onTap: () {
                            if (currentPage < 2) {
                              if (currentPage == 0) {
                                ClientModel client = ClientModel(
                                    fullname: "",
                                    phone: "phone",
                                    username:
                                        clientData.usernameCtrller.text.trim(),
                                    password:
                                        clientData.passwordCtrller.text.trim(),
                                    email: clientData.emailCtrller.text.trim());
                                if (client.email!.isEmpty ||
                                    client.username.isEmpty ||
                                    client.password.isEmpty ||
                                    clientData.confirmPwdCtrller.text.isEmpty) {
                                  ToastNotification.showToast(
                                      msg:
                                          "Veuillez remplir toutes les données",
                                      msgType: MessageType.error,
                                      title: "Erreur");
                                  return;
                                }
                                if (client.password.length < 4) {
                                  ToastNotification.showToast(
                                      msg:
                                          "Le mot de passe doit avoir au moins 4 caractères",
                                      msgType: MessageType.error,
                                      title: "Erreur");
                                  return;
                                }
                                if (client.password !=
                                    clientData.confirmPwdCtrller.text.trim()) {
                                  ToastNotification.showToast(
                                      msg:
                                          "Les mots de passe ne correspondent pas",
                                      msgType: MessageType.error,
                                      title: "Erreur");
                                  return;
                                }
                                context
                                    .read<CandidateProvider>()
                                    .setClient(client: client);
                              }
                              // client = clientData.client;
                              if (currentPage == 1) {
                                if (personalClientData
                                        .fullnameCtrller.text.isEmpty ||
                                    personalClientData
                                        .phoneCtrller.text.isEmpty ||
                                    personalClientData.city == null) {
                                  ToastNotification.showToast(
                                      msg: "Veuillez remplir tous les champs",
                                      msgType: MessageType.error,
                                      title: "Erreur");
                                  return;
                                }
                                context.read<CandidateProvider>().newClient
                                  ?..fullname = personalClientData
                                      .fullnameCtrller.text
                                      .trim()
                                  // ..address = personalClientData
                                  //     .addressCtrller.text
                                  //     .trim()
                                  ..phone = personalClientData.phoneCtrller.text
                                      .trim()
                                  ..address = personalClientData.city;
                                //"${personalClientData.city}/${personalClientData.addressCtrller.text.trim()}";
                                context.read<CandidateProvider>().setClient(
                                    client: context
                                        .read<CandidateProvider>()
                                        .newClient!);
                              }
                              currentPage++;
                              setState(() {});
                              _pageCtrller.animateToPage(currentPage,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.ease);
                            } else {
                              // if (context.read<CandidateProvider>().fileBytes ==
                              //     null) {
                              //   ToastNotification.showToast(
                              //       msg:
                              //           "Veuillez choisir votre image de profil",
                              //       title: "image indisponible",
                              //       msgType: MessageType.error);
                              //   return;
                              // }
                              // context
                              //         .read<CandidateProvider>()
                              //         .newClient
                              //         ?.imageBytes =
                              //     base64Encode(context
                              //         .read<CandidateProvider>()
                              //         .fileBytes!
                              //         .toList());
                              // context.read<CandidateProvider>().setClient(
                              //     client: context
                              //         .read<CandidateProvider>()
                              //         .newClient!);
                              Dialogs.showDialogWithActionCustomContent(
                                  title: "Conditions générales",
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextWidgets.text300(
                                          title:
                                              "En cliquant sur CONFIRMER, je confirme avoir lu et j'adhère au règlement de la compétition Miss Malaika.",
                                          fontSize: 16,
                                          textColor: AppColors.kBlackColor),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      TextWidgets.text300(
                                          title:
                                              "Télécharger le fichier du Règlement de la Compétition. (Optionnel)",
                                          fontSize: 16,
                                          textColor: AppColors.kBlackColor),
                                      IconButton(
                                          onPressed: () {
                                            launchUrl(
                                              Uri.parse(
                                                  "http://app.missmalaikardc.com/missmalaika_conditions.pdf"),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.cloud_download_rounded,
                                            size: 32,
                                            color: AppColors.kBlackColor,
                                          ))
                                    ],
                                  ),
                                  callback: () {
                                    context.read<CandidateProvider>().save(
                                        data: context
                                            .read<CandidateProvider>()
                                            .newClient!,
                                        callback: () {
                                          Navigator.pop(context);
                                        });
                                  });
                            }
                          },
                          child: Card(
                            color: AppColors.kPrimaryColor,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 32),
                              child: TextWidgets.text500(
                                  title: currentPage < 2
                                      ? "Suivant"
                                      : 'Enregistrer',
                                  fontSize: 18,
                                  textColor: AppColors.kWhiteColor),
                            ),
                          ),
                        )
                      : Center(
                          child: SizedBox(
                              width: 40,
                              height: 40,
                              child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors.kPrimaryColor)))),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
        callback: () {});
  }
}
