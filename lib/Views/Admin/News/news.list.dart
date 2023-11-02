import 'package:flutter/material.dart';
import 'package:missmalaika/Resources/Components/dialogs.dart';
import 'package:missmalaika/Views/Admin/News/add_news.page.dart';
import '../../../Resources/Components/texts.dart';
import '../../../Resources/Constants/global_variables.dart';
import '../../../Resources/Helpers/date_parser.dart';
import '../../../Resources/Models/news.model.dart';
import 'controller/news.provider.dart';
import 'package:provider/provider.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({super.key});

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<NewsProvider>().getOnline(value: 'none');
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      // crossAxisAlignment: CrossAxisAlignment.start,
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              // mainAxisSize: MainAxisSize.max,
              children: [
                Selector<NewsProvider, List<NewsModel>>(
                    selector: (_, provider) => provider.offlineData,
                    builder: (_, offlineData, __) {
                      return DataTable(dataRowHeight: 72, columns: [
                        DataColumn(
                          label: TextWidgets.textBold(
                              title: 'Image',
                              fontSize: 14,
                              textColor: AppColors.kBlackColor),
                        ),
                        DataColumn(
                            label: TextWidgets.textBold(
                                title: 'Titre',
                                fontSize: 14,
                                textColor: AppColors.kBlackColor)),
                        DataColumn(
                            label: TextWidgets.textBold(
                                title: 'Resume',
                                fontSize: 14,
                                textColor: AppColors.kBlackColor)),
                        DataColumn(
                            label: TextWidgets.textBold(
                                title: 'Auteur',
                                fontSize: 14,
                                textColor: AppColors.kBlackColor)),
                        DataColumn(
                            label: TextWidgets.textBold(
                                title: 'Date',
                                fontSize: 14,
                                textColor: AppColors.kBlackColor)),
                        DataColumn(
                            label: TextWidgets.textBold(
                                title: 'Actions',
                                fontSize: 14,
                                textColor: AppColors.kBlackColor)),
                      ], rows: [
                        ...List.generate(offlineData.length, (index) {
                          return DataRow(cells: [
                            DataCell(SizedBox(
                              width: 64,
                              height: 64,
                              child: offlineData[index].image == null ||
                                      offlineData[index].image!.isEmpty
                                  ? Image.asset(
                                      "Assets/Images/main_back.jpg",
                                      fit: BoxFit.cover,
                                      height: 64,
                                    )
                                  : FadeInImage(
                                      height: 64,
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
                                        "${BaseUrl.ip}${offlineData[index].image!}",
                                      ),
                                    ),
                            )),
                            DataCell(
                              ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxWidth: 180),
                                child: TextWidgets.text300(
                                    title: offlineData[index].title ?? '',
                                    maxLines: 3,
                                    fontSize: 12,
                                    textColor: AppColors.kBlackColor),
                              ),
                            ),
                            DataCell(
                              ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxWidth: 250),
                                child: TextWidgets.text300(
                                    title: offlineData[index].summary ?? '',
                                    maxLines: 3,
                                    fontSize: 12,
                                    textColor: AppColors.kBlackColor),
                              ),
                            ),
                            DataCell(
                              TextWidgets.text300(
                                  title: offlineData[index].publisher ?? '',
                                  fontSize: 12,
                                  textColor: AppColors.kBlackColor),
                            ),
                            DataCell(
                              TextWidgets.text300(
                                  title: parseDate(
                                      date: offlineData[index].createdAt ?? ''),
                                  fontSize: 12,
                                  textColor: AppColors.kBlackColor),
                            ),
                            DataCell(Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Dialogs.showModal(
                                        child: AddNewsPage(
                                      data: offlineData[index],
                                    ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.edit_note_rounded,
                                      color: AppColors.kBlackColor,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Dialogs.showDialogWithAction(
                                        title: "Confirmatiio",
                                        content:
                                            "Vous allez supprimer cet article du site.\nVoulez-vous continuer?",
                                        callback: () {
                                          context
                                              .read<NewsProvider>()
                                              .deleteNews(
                                                  data: offlineData[index]);
                                        });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.delete_rounded,
                                      color: AppColors.kRedColor,
                                    ),
                                  ),
                                )
                              ],
                            )),
                          ]);
                        })
                      ]);
                    })
              ]),
        )
      ],
    );
  }
}
