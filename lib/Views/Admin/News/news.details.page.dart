import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:missmalaika/Resources/Models/Menu/menu.model.dart';
import 'package:missmalaika/Resources/Providers/menu_provider.dart';
import '../../../Resources/Components/texts.dart';
import '../../../Resources/Constants/global_variables.dart';
import '../../../Resources/Helpers/date_parser.dart';
import '../../../Resources/Models/news.model.dart';
import 'controller/news.provider.dart';
import '../../parent.page.dart';
import 'package:provider/provider.dart';

class NewsDetailsPage extends StatefulWidget {
  NewsModel data;
  NewsDetailsPage({super.key, required this.data});

  @override
  State<NewsDetailsPage> createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return ParentPage(
        listData: SingleChildScrollView(
          controller: ScrollController(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        height: 300,
                        child: widget.data.image == null ||
                                widget.data.image!.isEmpty
                            ? Image.asset(
                                "Assets/Images/main_back.jpg",
                                fit: BoxFit.cover,
                              )
                            : FadeInImage(
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.asset(
                                    "Assets/Images/logo.png",
                                    fit: BoxFit.cover,
                                  );
                                },
                                fit: BoxFit.cover,
                                placeholder: const AssetImage(
                                  "Assets/Images/logo.png",
                                ),
                                image: NetworkImage(
                                  "${BaseUrl.ip}${widget.data.image!}",
                                ),
                              ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextWidgets.textBold(
                          title: widget.data.title ?? '',
                          fontSize: 24,
                          textColor: AppColors.kBlackColor),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                left: BorderSide(
                                    color: AppColors.kPrimaryColor, width: 3))),
                        padding: const EdgeInsets.all(8),
                        child: TextWidgets.text300(
                            maxLines: 10,
                            title: widget.data.summary?.trim() ?? '',
                            fontSize: 14,
                            textColor: AppColors.kBlackColor),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          iconTextWidget(
                              title: widget.data.publisher ?? 'Miss Malaika',
                              icon: Icons.person,
                              textColor: AppColors.kBlackColor),
                          iconTextWidget(
                              title:
                                  parseDate(date: widget.data.createdAt ?? '')
                                      .toString()
                                      .substring(0, 10),
                              icon: Icons.calendar_month,
                              textColor: AppColors.kBlackColor),
                          // iconTextWidget(
                          //     title: "6 comments",
                          //     icon: Icons.message_outlined,
                          //     textColor: AppColors.kBlackColor),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      HtmlWidget(widget.data.content ?? '')
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration:
                            BoxDecoration(color: AppColors.kPrimaryColor),
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
                            return Column(
                              children: [
                                ...List.generate(
                                    latestData.length,
                                    (index) => SmallLatestWidget(
                                        data: latestData[index]))
                              ],
                            );
                          }),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        callback: () {});
  }
}

iconTextWidget(
    {required String title, required IconData icon, required Color textColor}) {
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
            textColor: textColor),
        const SizedBox(
          width: 16,
        ),
      ]);
}

class SmallLatestWidget extends StatelessWidget {
  NewsModel data;
  SmallLatestWidget({super.key, required this.data});

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
        padding: const EdgeInsets.all(8),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: SizedBox(
                  width: double.maxFinite,
                  height: 88,
                  child: data.image == null || data.image!.isEmpty
                      ? Image.asset(
                          "Assets/Images/main_back.jpg",
                          fit: BoxFit.cover,
                        )
                      : FadeInImage(
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              "Assets/Images/logo.png",
                              fit: BoxFit.cover,
                            );
                          },
                          fit: BoxFit.cover,
                          placeholder: const AssetImage(
                            "Assets/Images/logo.png",
                          ),
                          image: NetworkImage(
                            "${BaseUrl.ip}${data.image!}",
                          ),
                        ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextWidgets.textBold(
                          maxLines: 2,
                          title: data.title?.toString() ?? '',
                          fontSize: 18,
                          textColor: AppColors.kBlackColor),
                      const SizedBox(
                        height: 16,
                      ),
                      TextWidgets.text300(
                          maxLines: 2,
                          title:
                              parseDate(date: data.createdAt?.toString() ?? ''),
                          fontSize: 12,
                          textColor: AppColors.kBlackColor.withOpacity(0.6)),
                    ],
                  ))
            ]),
      ),
    );
  }
}
