import 'package:date_count_down/date_count_down.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:missmalaika/Resources/Components/dialogs.dart';
import 'package:missmalaika/Views/Candidates/view/new-candidate.page.dart';
import 'footer.widget.dart';
import '../../Resources/Components/button.dart';
import '../../Resources/Constants/responsive.dart';

import '../../Resources/Components/texts.dart';
import '../../Resources/Constants/global_variables.dart';
import 'latest.widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List features = const [
    "Des recompenses enormes pour la gagnante",
    "Se faire voter par tout le monde",
    "Suivre ses votes et remercier ses votants",
    "Suivre les votes en direct"
  ];

  final List<String> sliderImgs = const ["img-1.jpg", "img-2.jpg", "img-3.jpg"];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      padding: EdgeInsets.zero,
      // physics: const NeverScrollableScrollPhysics(),
      controller: ScrollController(),
      child: Column(
        children: [
          // const SizedBox(
          //   height: 48,
          // ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 300,
            child: Stack(
              children: [
                SizedBox(
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height - 300,
                  child: CarouselSlider.builder(
                      // key: _sliderKey,
                      enableAutoSlider: true,
                      autoSliderDelay: const Duration(seconds: 10),
                      autoSliderTransitionCurve: Curves.easeInOutCirc,
                      unlimitedMode: true,
                      slideBuilder: (index) {
                        return Image.asset(
                          "Assets/Images/caroussel/${sliderImgs[index].trim()}",
                          width: double.maxFinite,
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.center,
                        );
                      },
                      slideTransform: const CubeTransform(),
                      slideIndicator: CircularSlideIndicator(
                        indicatorBackgroundColor:
                            AppColors.kWhiteColor.withOpacity(0.5),
                        currentIndicatorColor: AppColors.kPrimaryColor,
                        padding: const EdgeInsets.only(bottom: 32),
                      ),
                      itemCount: sliderImgs.length),
                ),
                // Image.asset(
                //   "Assets/Images/pictures/candidates.jpg",
                //   // width: double.maxFinite,
                //   width: MediaQuery.of(context).size.width,
                //   fit: BoxFit.cover,
                // ),
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 48, vertical: 0),
                      decoration: BoxDecoration(
                          color: AppColors.kBlackColor.withOpacity(0.7)),
                      child: Flex(
                        direction: Responsive.isMobile(context)
                            ? Axis.vertical
                            : Axis.horizontal,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidgets.text300(
                                    title:
                                        "DES CENTAINES DE CANDIDATES POUR LES ÉLIMINATOIRES AVANT LA FINALE À L'ISSU DE LAQUELLE NOUS AURONS LA MISS ET SES 3 DAUPHINES ÉLUES POUR UN AN",
                                    fontSize: 18,
                                    textColor: AppColors.kWhiteColor),
                                const SizedBox(
                                  height: 24,
                                ),
                                FittedBox(
                                  child: TextWidgets.textBold(
                                      title: "MISS MALAIKA",
                                      fontSize: 72,
                                      textColor: AppColors.kWhiteColor),
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                CustomButton(
                                    size: 300,
                                    text: "Je m'inscris",
                                    backColor: AppColors.kPrimaryColor,
                                    textColor: AppColors.kWhiteColor,
                                    callback: () {
                                      Dialogs.showPositionedModal(
                                          // title: "",
                                          child: const NewCandidatePage());
                                    })
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                          if (!Responsive.isMobile(context))
                            Flexible(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Image.asset(
                                  "Assets/Images/pictures/hero-right.png",
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            )
                        ],
                      ),
                    ))
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 32),
            decoration: BoxDecoration(color: AppColors.kBlackLightColor),
            child: Flex(
              direction: Responsive.isMobile(context)
                  ? Axis.vertical
                  : Axis.horizontal,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  flex: 2,
                  fit: FlexFit.loose,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(),
                      TextWidgets.text300(
                          title: "Les votes approchent",
                          fontSize: 16,
                          textColor: AppColors.kWhiteColor),
                      const SizedBox(
                        height: 16,
                      ),
                      TextWidgets.textBold(
                          title:
                              "Compte chaque seconde\nJusqu'au début des votes",
                          fontSize: 24,
                          textColor: AppColors.kWhiteColor),
                    ],
                  ),
                ),
                Flexible(
                    fit: Responsive.isMobile(context)
                        ? FlexFit.loose
                        : FlexFit.tight,
                    flex: 3,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: FittedBox(
                              child: CountDownText(
                                due: DateTime.parse('2024-01-01'),
                                finishedText: "Done",
                                showLabel: true,
                                // longDateName: true,
                                daysTextLong: "j ",
                                hoursTextLong: "h ",
                                minutesTextLong: "m ",
                                secondsTextLong: "s ",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 64,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
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
                    height: 315,
                    padding: EdgeInsets.zero,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: const HtmlWidget(
                            '<iframe width="560" height="315" src="https://www.youtube.com/embed/9QM0hVaJbUI?si=GX0Ux0p0xT7lec-p" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>')),
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
                          height: 24,
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
                          height: 16,
                        ),
                        ...List.generate(
                            features.length,
                            (index) => Row(
                                  children: [
                                    Icon(
                                      Icons.check,
                                      color: AppColors.kPrimaryColor,
                                      // size: 28,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Flexible(
                                        child: TextWidgets.text300(
                                            title: features[index],
                                            fontSize: 20,
                                            textColor: AppColors.kBlackColor)),
                                  ],
                                ))
                      ],
                    ))
              ],
            ),
          ),
          const LatestUpdatesWidget(),
          FooterWidget(),
        ],
      ),
    ));
  }
}

testStyle(
    {double? fontSize = 12,
    FontWeight? weight = FontWeight.normal,
    Color? color = Colors.black}) {
  return TextStyle(fontSize: fontSize, fontWeight: weight, color: color);
}
