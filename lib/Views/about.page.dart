import 'package:flutter/material.dart';
import 'package:missmalaika/Resources/Components/texts.dart';
import 'package:missmalaika/Resources/Constants/global_variables.dart';
import 'package:missmalaika/Resources/Constants/responsive.dart';
import 'package:missmalaika/Views/Home/footer.widget.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                                title: "A propos de Miss Malaika",
                                fontSize: 48,
                                textColor: AppColors.kWhiteColor),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              const SizedBox(
                height: 24,
              ),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
              //   child: Column(
              //     children: [
              //       TextWidgets.textNormal(
              //           title:
              //               """MISS MALAIKA est une compétition organisée à Goma par OZZONE Productions, NAWEZA Foundation et AGRORECOLT pour célébrer la jeune femme congolaise, belle et future pilier de la nation. La compétition s'étale sur 4 mois, de Mai à Aout 2023, avec des candidates des 18 quartiers de Goma.
              //                     """,
              //           fontSize: 14,
              //           textColor: AppColors.kBlackColor),
              //       const SizedBox(
              //         height: 24,
              //       ),
              //     ],
              //   ),
              // ),
              AboutSectionItemWidget(
                  imageName: 'event.png',
                  title: "C'est quoi MISS MALAIKA?",
                  content:
                      """MISS MALAIKA est une compétition organisée à Goma pour célébrer la jeune femme congolaise, belle et future pilier de la nation.\n\nLa compétition s'étale sur 10 mois, de Novembre 2023 à Aout 2024, avec plus de 500 Candidates de Bukavu et Goma pour les éliminatoires avant la phase finale à l'issu de laquelle nous aurons la Miss et ses 3 Dauphines élues pour un an.
"""),
              AboutSectionItemWidget(
                  isReversed: true,
                  imageName: 'diffusion.png',
                  title: "Nous diffusons chaque semaine",
                  content:
                      """MISS MALAIKA produit et diffuse chaque semaine une émission à la télévision qui porte le titre MISS MALAIKA. Avec rediffusion le lendemain. L'émission passe sur HOPE Channel et RTNK (tous disponibles sur Canal +). L'émission est aussi publiée en entier et par extraits sur les réseaux sociaux pour atteindre encore plus de public à travers le Congo et le monde.\n\nNos partenaires et sponsors utilisent cette exposition pendant toute l'année à travers notre émission pour présenter leurs différents produits et services aux jeunes et aux entrepreneurs qui sont notre audience principale. Plusieurs possibilités leur sont offertes dont notamment les spots videos, leur représentant comme nvité sur le plateau, des reportages sur vos activités, etc.
"""),
              AboutSectionItemWidget(
                  // isReversed: true,
                  imageName: 'impact.png',
                  title:
                      "Nous impactons la vie de tous les jours dans notre communaute",
                  content:
                      """Grâce à MISS MALAIKA, quatre autres business de jeunes femmes vont naitre à Goma cette année. Portés par la Miss et ses trois Dauphines avec le financement de nos partenaires (banques et humanitaires).\n\nQuatre business qui vont impacter la communauté et contribuer à la réduction de la pauvreté et la création d'une génération de jeunes entrepreneurs en RDC.\n\nChaque année, des nouveaux business seront créés en RDC grâce à MISS MALAIKA.
"""),
              AboutSectionItemWidget(
                  isReversed: true,
                  imageName: 'votes.png',
                  title: "Comment voter une candidate?",
                  content:
                      """Le public votera encore en ligne ou en payant des jetons de 1\$, 5\$, 10\$, 20\$ et 40\$ dans les salles.\n\n1\$ pour 1 voix\n5\$ pour 10 voix\n10\$ pour 30 voix\n20\$ pour 100 voix\n40\$ pour 500 voix.
"""),
              // const GoalsWidget(),
              // const SizedBox(
              //   height: 24,
              // ),
              // const MembersWidget(),
              // const SizedBox(
              //   height: 24,
              // ),
              // const TeamWidget(),
              // const SizedBox(
              //   height: 24,
              // ),
              // const AccessionWidget()
              // TextWidgets.textBold(
              //     title: "Objectifs",
              //     fontSize: 16,
              //     textColor: AppColors.kBlackColor),
              FooterWidget()
            ],
          ),
        ),
      ],
    );
  }
}

dotItem({required String text}) {
  return Row(children: [
    const SizedBox(
      width: 24,
    ),
    TextWidgets.textBold(
        title: "\u2022", fontSize: 30, textColor: AppColors.kBlackColor),
    const SizedBox(
      width: 16,
    ), //space between bullet and text
    Expanded(
      child: TextWidgets.textNormal(
          title: text, fontSize: 14, textColor: AppColors.kBlackColor),
    ), //text
  ]);
}

class AboutSectionItemWidget extends StatelessWidget {
  final String imageName, title, content;
  bool? isReversed;
  AboutSectionItemWidget(
      {super.key,
      required this.imageName,
      required this.title,
      required this.content,
      this.isReversed = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      constraints: BoxConstraints(
          maxHeight: Responsive.isMobile(context) ? double.maxFinite : 400),
      child: Flex(
        textDirection: isReversed == true && !Responsive.isMobile(context)
            ? TextDirection.rtl
            : TextDirection.ltr,
        direction:
            Responsive.isMobile(context) ? Axis.vertical : Axis.horizontal,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(0),
            child: Image.asset(
              "Assets/Images/about/$imageName",
              height: 400,
              fit: BoxFit.cover,
            ),
          )),
          // const SizedBox(
          //   width: 24,
          // ),
          Flexible(
            child: Container(
              // margin: const EdgeInsets.only(left: 24),
              height: Responsive.isMobile(context) ? null : 400,
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextWidgets.textBold(
                      title: title,
                      fontSize: 24,
                      textColor: AppColors.kBlackColor),
                  const SizedBox(
                    height: 24,
                  ),
                  TextWidgets.text300(
                      align: TextAlign.left,
                      maxLines: Responsive.isMobile(context) ? 100 : 30,
                      title: content,
                      fontSize: 16,
                      textColor: AppColors.kBlackColor)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MembersWidget extends StatelessWidget {
  const MembersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidgets.textBold(
              title: "Membres", fontSize: 16, textColor: AppColors.kBlackColor),
          const SizedBox(
            height: 16,
          ),
          TextWidgets.textNormal(
              title: "l'assemblée générale de l'ASMR est composé de : ",
              fontSize: 14,
              textColor: AppColors.kBlackColor),
          dotItem(text: "Les membres fondateurs et co-fondateurs"),
          dotItem(text: "Les membres d'honneurs"),
          dotItem(text: "Les membres d'organes du club en règle de cotisation"),
          dotItem(text: "Membres adhérant en règle de cotisation"),
          dotItem(
              text:
                  "Délégués de section ou sympatisant ou supporteurs au prorata du montant versé au compte du club, ils ont une voix consultative"),
          dotItem(text: "Les membres fondateurs et co-fondateurs"),
        ],
      ),
    );
  }
}

// class AccessionWidget extends StatelessWidget {
//   const AccessionWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           TextWidgets.textBold(
//               title: "Adhésion",
//               fontSize: 16,
//               textColor: AppColors.kBlackColor),
//           const SizedBox(
//             height: 16,
//           ),
//           TextWidgets.textNormal(
//               title: "Les conditions d’adhésion à l'ASMR asbl sont :",
//               fontSize: 14,
//               textColor: AppColors.kBlackColor),
//           dotItem(text: "Avoir au moins 18 ans d'age"),
//           dotItem(text: "S'interesser aux activités de l'association"),
//           dotItem(text: "Etre de bonne moralité"),
//           dotItem(text: "Acquérir la carte d'adhésion"),
//           dotItem(text: "Souscrire à l'idéal de l'association"),
//         ],
//       ),
//     );
//   }
// }

// class TeamWidget extends StatelessWidget {
//   const TeamWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           TextWidgets.textBold(
//               title: "Equipe", fontSize: 16, textColor: AppColors.kBlackColor),
//           const SizedBox(
//             height: 16,
//           ),
//           TextWidgets.textNormal(
//               title: "L'ASMR est composée de : ",
//               fontSize: 14,
//               textColor: AppColors.kBlackColor),
//           dotItem(
//               text: "Camille PALUKU: président du conseil d'administration"),
//           dotItem(
//               text:
//                   "Berky Chirimwami : 1er vice-président du conseil d'administration"),
//           dotItem(text: "Jérémie Kasienene: Secrétaire"),
//           dotItem(text: "Senpho Kabali: Trésorier"),
//           dotItem(text: "Camille LUSENGE: Membre fondateur"),
//         ],
//       ),
//     );
//   }
// }
