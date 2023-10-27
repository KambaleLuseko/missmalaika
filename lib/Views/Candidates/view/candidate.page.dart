import 'package:flutter/material.dart';
import '../../Home/footer.widget.dart';
import '../../../Resources/Models/partner.model.dart';
import '../../../Resources/Components/button.dart';
import '../../../Resources/Components/dialogs.dart';
import '../../../Resources/Components/text_fields.dart';
import '../../../Resources/Components/texts.dart';
import '../../../Resources/Constants/global_variables.dart';
import '../../../Resources/Constants/responsive.dart';
import '../../../Resources/Providers/candidates.provider.dart';
import '../../../Resources/Providers/users_provider.dart';
import 'candidate.list.dart';
import 'candidatePayment.page.dart';
import 'new-candidate.page.dart';
import '../../parent.page.dart';
import 'package:provider/provider.dart';

class CandidatePage extends StatefulWidget {
  const CandidatePage({super.key});

  @override
  State<CandidatePage> createState() => _CandidatePageState();
}

class _CandidatePageState extends State<CandidatePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CandidateProvider>().getOnline();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ParentPage(
        listData: ListView(
          controller: ScrollController(),
          children: [
            Container(
              padding: EdgeInsets.zero,
              child: Stack(children: [
                Container(
                  width: double.maxFinite,
                  height: 300,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage(
                            'Assets/Images/main_back.jpg',
                          ),
                          // alignment: Alignment.topCenter,
                          fit: BoxFit.cover)),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        color: AppColors.kBlackColor.withOpacity(0.5)),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.zero,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextWidgets.textNormal(
                              title: "Candidates",
                              fontSize: 48,
                              textColor: AppColors.kWhiteColor),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            Container(
              // height: 400,
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 32),
              // decoration: BoxDecoration(color: AppColors.kBlackLightColor),
              child: Flex(
                direction: Responsive.isMobile(context)
                    ? Axis.vertical
                    : Axis.horizontal,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 2,
                    // fit: FlexFit.tight,
                    child: Container(
                      height: 500,
                      padding: EdgeInsets.zero,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.asset(
                          "Assets/Images/pictures/queen.jpg",
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  Flexible(
                      // fit: FlexFit.tight,
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          TextWidgets.textBold(
                              title: "Miss Malaika",
                              fontSize: 56,
                              textColor: AppColors.kBlackColor),
                          const SizedBox(
                            height: 32,
                          ),
                          TextWidgets.text300(
                              title:
                                  """MISS MALAIKA est une compétition organisée à Goma par OZZONE Productions, NAWEZA Foundation et AGRORECOLT pour célébrer la jeune femme congolaise, belle et future pilier de la nation. La compétition s'étale sur 4 mois, de Mai à Aout 2023, avec des candidates des 18 quartiers de Goma.
                            """,
                              fontSize: 20,
                              textColor: AppColors.kBlackColor),
                          const SizedBox(
                            height: 0,
                          ),
                          const MissionItemWidget(
                            title: "Concours",
                            icon: Icons.movie_filter_rounded,
                            description:
                                "Participez au concours pour gagner le grand prix de la compétition.\nLa compétition s'étale sur 10 mois, de Novembre 2023 à Août 2024 avec des candidates de Goma et Bukavu.",
                          ),
                          const MissionItemWidget(
                            title: "Vote",
                            icon: Icons.payments_rounded,
                            description:
                                "Recevez les votes de vos proches pour gagner la compétition.",
                          ),
                          const MissionItemWidget(
                            title: "Finale",
                            icon: Icons.cases_rounded,
                            description:
                                "Tentez votre chance d'être élue MISS MALAIKA 2024. On ne sait jamais!",
                          ),
                          Flex(
                            direction: Responsive.isMobile(context)
                                ? Axis.vertical
                                : Axis.horizontal,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: CustomButton(
                                    size: 300,
                                    text: "Je m'enrolle",
                                    backColor: AppColors.kPrimaryColor,
                                    textColor: AppColors.kWhiteColor,
                                    callback: () {
                                      Dialogs.showPositionedModal(
                                          // title: "",
                                          child: const NewCandidatePage());
                                    }),
                              ),
                              if (context
                                      .select<UserProvider, CandidateModel?>(
                                          (value) => value.candidate)
                                      ?.status !=
                                  2)
                                Flexible(
                                  child: CustomButton(
                                      size: 300,
                                      text: "J'active mon compte",
                                      backColor: AppColors.kSecondaryColor,
                                      textColor: AppColors.kWhiteColor,
                                      callback: () {
                                        if (context
                                                .read<UserProvider>()
                                                .candidate ==
                                            null) {
                                          final TextEditingController
                                              usernameCtrller =
                                              TextEditingController();
                                          final TextEditingController
                                              pwdCtrller =
                                              TextEditingController();
                                          Dialogs
                                              .showDialogWithActionCustomContent(
                                                  title: "",
                                                  content:
                                                      SingleChildScrollView(
                                                          child: Column(
                                                    children: [
                                                      TextWidgets.text300(
                                                          textColor: AppColors
                                                              .kBlackColor,
                                                          fontSize: 14,
                                                          title:
                                                              "Saisissez vos identifiants pour continuer"),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      TextFormFieldWidget(
                                                          hintText: "Username",
                                                          textColor: AppColors
                                                              .kBlackColor,
                                                          backColor: AppColors
                                                              .kTextFormBackColor,
                                                          // icon: Icons.person,
                                                          inputType:
                                                              TextInputType
                                                                  .text,
                                                          isEnabled: true,
                                                          editCtrller:
                                                              usernameCtrller),
                                                      TextFormFieldWidget(
                                                          maxLines: 1,
                                                          hintText: "Password",
                                                          textColor: AppColors
                                                              .kBlackColor,
                                                          backColor: AppColors
                                                              .kTextFormBackColor,
                                                          inputType:
                                                              TextInputType
                                                                  .text,
                                                          isObsCured: true,
                                                          isEnabled: true,
                                                          editCtrller:
                                                              pwdCtrller),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      CustomButton(
                                                          canSync: true,
                                                          backColor: AppColors
                                                              .kPrimaryColor,
                                                          textColor: AppColors
                                                              .kWhiteColor,
                                                          text: 'Vérifier',
                                                          callback: () {
                                                            context
                                                                .read<
                                                                    UserProvider>()
                                                                .fetchCandidate(
                                                                    data: {
                                                                  "username":
                                                                      usernameCtrller
                                                                          .text
                                                                          .toString()
                                                                          .trim(),
                                                                  "password":
                                                                      pwdCtrller
                                                                          .text
                                                                          .toString()
                                                                          .trim(),
                                                                },
                                                                    callback:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                      Dialogs.showDialogWithActionCustomContent(
                                                                          title:
                                                                              "",
                                                                          content:
                                                                              CandidatePaymentPage());
                                                                    });
                                                          }),
                                                    ],
                                                  )));
                                        } else {
                                          Dialogs
                                              .showDialogWithActionCustomContent(
                                                  title: "",
                                                  content:
                                                      CandidatePaymentPage());
                                        }
                                      }),
                                )
                            ],
                          )
                        ],
                      ))
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(24),
              child: TextWidgets.textBold(
                  title: 'Nos candidates',
                  fontSize: 32,
                  textColor: AppColors.kBlackColor),
            ),
            const CandidateListWidget(),
            const SizedBox(
              height: 24,
            ),
            FooterWidget()
          ],
        ),
        callback: () {});
  }
}

class MissionItemWidget extends StatelessWidget {
  final IconData icon;
  final String title, description;
  const MissionItemWidget(
      {super.key,
      required this.icon,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(4),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(
          icon,
          size: 40,
          color: AppColors.kPrimaryColor,
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidgets.textBold(
                  title: title, fontSize: 18, textColor: AppColors.kBlackColor),
              const SizedBox(
                height: 8,
              ),
              TextWidgets.text300(
                  title: description,
                  fontSize: 14,
                  textColor: AppColors.kBlackColor),
            ],
          ),
        )
      ]),
    );
  }
}
