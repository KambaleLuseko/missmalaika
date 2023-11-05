import 'package:flutter/material.dart';
import 'package:missmalaika/Resources/Components/dialogs.dart';
import 'package:missmalaika/Resources/Components/texts.dart';
import 'package:missmalaika/Resources/Constants/global_variables.dart';
import 'package:missmalaika/Resources/Helpers/date_parser.dart';
import 'package:missmalaika/Views/Admin/Events/controller/event.provider.dart';
import 'package:missmalaika/Views/Admin/Events/model/event.model.dart';
import 'package:missmalaika/Views/Admin/Events/view/add_event.page.dart';
import 'package:provider/provider.dart';

class EventListPage extends StatefulWidget {
  const EventListPage({super.key});

  @override
  State<EventListPage> createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<EventProvider>().getOnline(value: 'all');
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
                Selector<EventProvider, List<EventModel>>(
                    selector: (_, provider) => provider.offlineData,
                    builder: (_, offlineData, __) {
                      return DataTable(dataRowHeight: 72, columns: [
                        DataColumn(
                          label: TextWidgets.textBold(
                              title: 'Nom',
                              fontSize: 14,
                              textColor: AppColors.kBlackColor),
                        ),
                        DataColumn(
                            label: TextWidgets.textBold(
                                title: 'Description',
                                fontSize: 14,
                                textColor: AppColors.kBlackColor)),
                        DataColumn(
                            label: TextWidgets.textBold(
                                title: 'Category',
                                fontSize: 14,
                                textColor: AppColors.kBlackColor)),
                        DataColumn(
                            label: TextWidgets.textBold(
                                title: 'Date',
                                fontSize: 14,
                                textColor: AppColors.kBlackColor)),
                        DataColumn(
                            label: TextWidgets.textBold(
                                title: 'Prix',
                                fontSize: 14,
                                textColor: AppColors.kBlackColor)),
                        DataColumn(
                            label: TextWidgets.textBold(
                                title: 'Active',
                                fontSize: 14,
                                textColor: AppColors.kBlackColor)),
                        DataColumn(
                            label: TextWidgets.textBold(
                                title: 'Status',
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
                            DataCell(
                              ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxWidth: 180),
                                child: TextWidgets.text300(
                                    title: offlineData[index].eventName ?? '',
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
                                    title:
                                        offlineData[index].eventDescription ??
                                            '',
                                    maxLines: 3,
                                    fontSize: 12,
                                    textColor: AppColors.kBlackColor),
                              ),
                            ),
                            DataCell(
                              TextWidgets.text300(
                                  title:
                                      offlineData[index].eventCategorie ?? '',
                                  fontSize: 12,
                                  textColor: AppColors.kBlackColor),
                            ),
                            DataCell(
                              TextWidgets.text300(
                                  title: parseDate(
                                          date: offlineData[index].eventDate ??
                                              '')
                                      .toString()
                                      .substring(0, 10),
                                  fontSize: 12,
                                  textColor: AppColors.kBlackColor),
                            ),
                            DataCell(
                              TextWidgets.text300(
                                  title: "${offlineData[index].price ?? ''}\$",
                                  fontSize: 12,
                                  textColor: AppColors.kBlackColor),
                            ),
                            DataCell(
                              TextWidgets.text300(
                                  title:
                                      offlineData[index].isActive?.toString() ==
                                              '1'
                                          ? "Active"
                                          : "Desactive",
                                  fontSize: 12,
                                  textColor: AppColors.kBlackColor),
                            ),
                            DataCell(
                              TextWidgets.text300(
                                  title: offlineData[index].state ?? '',
                                  fontSize: 12,
                                  textColor: AppColors.kBlackColor),
                            ),
                            DataCell(Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Dialogs.showModal(
                                        child: NewEventPage(
                                      updatingData: true,
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
                                        title: "Confirmation",
                                        content:
                                            "Vous allez supprimer cet article du site.\nVoulez-vous continuer?",
                                        callback: () {
                                          // context
                                          //     .read<NewsProvider>()
                                          //     .deleteNews(
                                          //         data: offlineData[index]);
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
