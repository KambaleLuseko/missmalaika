import '../../Resources/Components/reusable.dart';
import '../../Resources/Components/texts.dart';
import '../../Resources/Constants/responsive.dart';
import '../../Resources/Helpers/date_parser.dart';
import '../../Resources/Models/Menu/menu.model.dart';
import '../../Resources/Models/news.model.dart';
import '../../Resources/Providers/menu_provider.dart';
import '../Admin/News/controller/news.provider.dart';
import '../Admin/News/news.details.page.dart';
import 'package:provider/provider.dart';

import '../../Resources/Constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class LatestUpdatesWidget extends StatelessWidget {
  const LatestUpdatesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: AppColors.kPrimaryColor),
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: Row(children: [
            TextWidgets.textBold(
                title: 'Derniers articles',
                fontSize: 18,
                textColor: AppColors.kWhiteColor),
          ]),
        ),
        Selector<NewsProvider, List<NewsModel>>(
            selector: (_, provider) => provider.latestData,
            builder: (__, latestData, _) {
              return FlexWidget(
                content: [
                  // ...List.generate(latestData.length, (index) {
                  //   return Flexible(child: ItemHome(
                  //   isMain: true,
                  //   data: NewsModel(),
                  //   title: '',
                  // ));
                  // }),
                  Flexible(
                      child: latestData.firstOrNull != null
                          ? ItemHome(
                              isMain: true,
                              data: latestData.first,
                              title: '',
                            )
                          : Container()),
                  const SizedBox(
                    width: 16,
                  ),
                  Flexible(
                      child: Column(
                    children: [
                      latestData.length > 1
                          ? ItemHome(
                              data: latestData[1],
                              title: '',
                            )
                          : Container(),
                      latestData.length > 2
                          ? ItemHome(
                              data: latestData[2],
                              title: '',
                            )
                          : Container(),
                    ],
                  )),
                ],
              );
            }),
      ],
    );
  }
}

class ItemHome extends StatelessWidget {
  ItemHome(
      {super.key,
      required this.data,
      required this.title,
      this.backColor = Colors.transparent,
      this.textColor = Colors.black,
      this.align = Alignment.center,
      this.isMain = false});

  NewsModel data;
  String title;
  Color? backColor, textColor;
  Alignment? align;
  bool? isMain;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<MenuProvider>().setActivePage(
            newPage: MenuModel(
                title: 'News details',
                page: NewsDetailsPage(
                  data: data,
                )));
      },
      child: Container(
        // padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(color: backColor),
        alignment: Alignment.center,
        child: Stack(children: [
          data.image == null || data.image!.isEmpty
              ? Image.asset(
                  "Assets/Images/main_back.jpg",
                  fit: BoxFit.cover,
                  height: isMain == true && !Responsive.isMobile(context)
                      ? 416
                      : 200,
                  width: double.maxFinite,
                )
              : FadeInImage(
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      "Assets/Images/logo.png",
                      fit: BoxFit.cover,
                    );
                  },
                  height: isMain == true && !Responsive.isMobile(context)
                      ? 416
                      : 200,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                  placeholder: const AssetImage(
                    "Assets/Images/logo.png",
                  ),
                  image: NetworkImage(
                    "${BaseUrl.ip}${data.image!}",
                  ),
                ),

          // Image.asset(
          //   "Assets/Images/logo.png",
          //   fit: BoxFit.cover,

          // ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutCubic,
              opacity: 1,
              child: Container(
                padding: const EdgeInsets.all(16),
                // width: double.maxFinite,
                // height: double.maxFinite,
                decoration: BoxDecoration(
                    color: AppColors.kPrimaryColor.withOpacity(0.6)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidgets.textBold(
                        title: data.title ?? '',
                        fontSize: 20,
                        textColor: AppColors.kWhiteColor),
                    const SizedBox(
                      height: 8,
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        iconTextWidget(
                            title: data.publisher ?? 'Miss Malaika',
                            icon: Icons.person,
                            textColor: AppColors.kWhiteColor),
                        iconTextWidget(
                            title: parseDate(date: data.createdAt ?? '')
                                .toString()
                                .substring(0, 10),
                            icon: Icons.calendar_month,
                            textColor: AppColors.kWhiteColor),
                        // iconTextWidget(
                        //     title: "6 comments",
                        //     icon: Icons.message_outlined,
                        //     textColor: AppColors.kWhiteColor),
                        // TextWidgets.text300(
                        //     icon: Icons.person,
                        //     title: "Publisher",
                        //     fontSize: 14,
                        //     textColor: AppColors.kWhiteColor),
                        // TextWidgets.textBold(
                        //     icon: Icons.calendar_month,
                        //     title: "Date",
                        //     fontSize: 14,
                        //     textColor: AppColors.kWhiteColor),
                        // TextWidgets.textBold(
                        //     icon: CupertinoIcons.chat_bubble_2_fill,
                        //     title: "6 comments",
                        //     fontSize: 14,
                        //     textColor: AppColors.kWhiteColor),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }

  iconTextWidget(
      {required String title,
      required IconData icon,
      required Color textColor}) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: textColor,
          ),
          const SizedBox(
            width: 8,
          ),
          TextWidgets.text300(
              icon: Icons.person,
              title: title,
              fontSize: 14,
              textColor: textColor)
        ]);
  }
}
