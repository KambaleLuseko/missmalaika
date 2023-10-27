import 'package:flutter/material.dart';
import 'package:missmalaika/Resources/Constants/responsive.dart';
import '../../Home/footer.widget.dart';
import '../../../Resources/Models/Menu/menu.model.dart';
import '../../../Resources/Providers/menu_provider.dart';
import '../../../Resources/Components/empty_model.dart';
import '../../../Resources/Components/texts.dart';
import '../../../Resources/Constants/global_variables.dart';
import '../../../Resources/Helpers/date_parser.dart';
import '../../../Resources/Models/news.model.dart';
import 'controller/news.provider.dart';
import 'news.details.page.dart';
import 'package:provider/provider.dart';

class ClientNewsListPage extends StatefulWidget {
  const ClientNewsListPage({super.key});

  @override
  State<ClientNewsListPage> createState() => _ClientNewsListPageState();
}

class _ClientNewsListPageState extends State<ClientNewsListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<NewsProvider>().getOnline(value: 'none', isRefresh: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Flex(
          direction:
              Responsive.isMobile(context) ? Axis.vertical : Axis.horizontal,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     IconButton(
                    //         onPressed: () {
                    //           context
                    //               .read<NewsProvider>()
                    //               .getOnline(value: 'none', isRefresh: true);
                    //         },
                    //         icon: Icon(
                    //           Icons.autorenew,
                    //           color: AppColors.kBlackColor,
                    //         ))
                    //   ],
                    // ),
                    Selector<NewsProvider, List<NewsModel>>(
                        selector: (_, provider) => provider.offlineData,
                        builder: (_, offlineData, __) {
                          return offlineData.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    EmptyModel(color: AppColors.kGreyColor),
                                    IconButton(
                                        onPressed: () {
                                          context
                                              .read<NewsProvider>()
                                              .getOnline(
                                                  value: 'none',
                                                  isRefresh: true);
                                        },
                                        icon: Icon(
                                          Icons.autorenew,
                                          color: AppColors.kBlackColor,
                                        ))
                                  ],
                                )
                              : ListView.builder(
                                  itemCount: offlineData.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return NewsWidget(data: offlineData[index]);
                                  });
                        })
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
        FooterWidget()
      ],
    );
  }
}

class NewsWidget extends StatelessWidget {
  NewsModel data;
  NewsWidget({super.key, required this.data});

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
                  height: 132,
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
                          fontSize: 20,
                          textColor: AppColors.kBlackColor),
                      const SizedBox(
                        height: 16,
                      ),
                      Wrap(
                        alignment: WrapAlignment.start,
                        runAlignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: [
                          iconTextWidget(
                              title: data.publisher ?? 'Miss Malaika',
                              icon: Icons.person,
                              textColor: AppColors.kBlackColor),
                          iconTextWidget(
                              title: parseDate(date: data.createdAt ?? '')
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
                        height: 16,
                      ),
                      TextWidgets.textNormal(
                          maxLines: 3,
                          title: data.summary?.toString() ?? '',
                          fontSize: 16,
                          textColor: AppColors.kBlackColor.withOpacity(0.6)),
                    ],
                  ))
            ]),
      ),
    );
  }
}
