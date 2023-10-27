import 'package:flutter/material.dart';
import '../../../Resources/Components/empty_model.dart';
import '../../../Resources/Components/list_item.dart';
import '../../../Resources/Components/texts.dart';
import '../../../Resources/Constants/global_variables.dart';
import '../../../Resources/Models/Menu/list_item.model.dart';
import '../../../Resources/Models/Menu/menu.model.dart';
import '../../../Resources/Models/dashboard.model.dart';
import '../../../Resources/Models/partner.model.dart';
import '../../../Resources/Providers/dashboard.provider.dart';
import '../../../Resources/Providers/menu_provider.dart';
import 'candidate.dashboard.dart';
import '../../parent.page.dart';
import 'package:provider/provider.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<DashboardProvider>().getOnline();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ParentPage(
        listData: Column(
          children: [
            Row(
              children: [
                Flexible(
                    child: ListItem(
                  icon: Icons.group,
                  title: "Candidates",
                  subtitle: "Nombre des candidates inscrites",
                  keepMidleFields: true,
                  middleFields: ListItemModel(
                    title: "Value",
                    value: context
                            .select<DashboardProvider, DashboardModel?>(
                                (value) => value.dashboardValue)
                            ?.dashboard
                            ?.totalCandidates
                            ?.toString() ??
                        '0',
                    displayLabel: true,
                  ),
                  backColor: AppColors.kTextFormBackColor,
                  textColor: AppColors.kBlackColor,
                  detailsFields: const [],
                  hasUpdate: true,
                  updateCallback: () {
                    context.read<MenuProvider>().setActivePage(
                        newPage: MenuModel(
                            title: 'cand',
                            page: const CandidateDashboardPage()));
                  },
                )),
                Flexible(
                    child: ListItem(
                  icon: Icons.group,
                  title: "Confirmées",
                  subtitle: "Nombre d'inscription confirmées",
                  keepMidleFields: true,
                  middleFields: ListItemModel(
                    title: "Value",
                    value: context
                            .select<DashboardProvider, DashboardModel?>(
                                (value) => value.dashboardValue)
                            ?.dashboard
                            ?.confirmedInscriptions
                            ?.toString() ??
                        '0',
                    displayLabel: true,
                  ),
                  backColor: AppColors.kTextFormBackColor,
                  textColor: AppColors.kBlackColor,
                  detailsFields: const [],
                )),
                Flexible(
                    child: ListItem(
                  icon: Icons.payments_rounded,
                  title: "Votes",
                  subtitle: "Nombre des votes ",
                  keepMidleFields: true,
                  middleFields: ListItemModel(
                    title: "Value",
                    value: context
                            .select<DashboardProvider, DashboardModel?>(
                                (value) => value.dashboardValue)
                            ?.dashboard
                            ?.userConfirmedVotes
                            ?.toString() ??
                        '0',
                    displayLabel: true,
                  ),
                  backColor: AppColors.kTextFormBackColor,
                  textColor: AppColors.kBlackColor,
                  detailsFields: const [],
                )),
                Flexible(
                    child: ListItem(
                  icon: Icons.card_giftcard,
                  title: "Points",
                  subtitle: "Nombre des points",
                  keepMidleFields: true,
                  middleFields: ListItemModel(
                    title: "Value",
                    value: context
                            .select<DashboardProvider, DashboardModel?>(
                                (value) => value.dashboardValue)
                            ?.dashboard
                            ?.totalUserConfirmedPoints
                            ?.toString() ??
                        '0',
                    displayLabel: true,
                  ),
                  backColor: AppColors.kTextFormBackColor,
                  textColor: AppColors.kBlackColor,
                  detailsFields: const [],
                )),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Selector<DashboardProvider, List<CandidateModel>?>(
                    selector: (_, provider) =>
                        provider.dashboardValue?.candidatesStats,
                    builder: (_, offlineData, __) {
                      return offlineData == null
                          ? EmptyModel(color: AppColors.kGreyColor)
                          : GridView.builder(
                              shrinkWrap: true,
                              itemCount: offlineData.length,
                              // physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 4 / 2.8,
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8),
                              itemBuilder: (context, index) {
                                return CandidateStatItemWidget(
                                  displayImage: true,
                                  data: offlineData[index],
                                );
                              });
                    }),
              ),
            )
          ],
        ),
        callback: () {});
  }
}

class CandidateStatItemWidget extends StatelessWidget {
  bool? hasSpace, displayImage;
  CandidateModel data;
  CandidateStatItemWidget(
      {super.key,
      this.hasSpace = false,
      required this.data,
      this.displayImage = false});

  @override
  Widget build(BuildContext context) {
    // print(data.status);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.kWhiteColor, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (displayImage == true)
                SizedBox(
                  width: 64,
                  height: 64,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(120),
                    child: (data.imageUrl != null)
                        ? FadeInImage(
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
                              "${BaseUrl.ip}${data.imageUrl!}",
                            ),
                          )
                        : Image.asset(
                            "Assets/Images/logo.png",
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              if (displayImage == true)
                const SizedBox(
                  width: 16,
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidgets.textBold(
                            title: data.fullname ?? 'Unknown',
                            fontSize: 18,
                            textColor: AppColors.kBlackColor),
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                              color: data.status == 2
                                  ? AppColors.kGreenColor
                                  : data.status == 1
                                      ? AppColors.kBlueColor
                                      : AppColors.kRedColor,
                              borderRadius: BorderRadius.circular(20)),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextWidgets.text500(
                        title: data.phone ?? 'Unknown',
                        fontSize: 14,
                        textColor: AppColors.kBlackColor),
                    TextWidgets.text300(
                        title: "No : ${data.uuid ?? ''}",
                        fontSize: 14,
                        textColor: AppColors.kBlackColor),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          if (hasSpace == true) const Spacer(),
          progressWidget(
              title: "Votes",
              value: double.parse(data.votes?.userConfirmedVotes ?? '0'),
              max: double.parse(context
                      .select<DashboardProvider, DashboardModel?>(
                          (value) => value.dashboardValue)
                      ?.dashboard
                      ?.userConfirmedVotes ??
                  '0'),
              color: Colors.blue.shade800),
          progressWidget(
              title: "Votes en attente",
              value: double.parse(data.votes?.userPendingVotes ?? '0'),
              max: double.parse(context
                      .select<DashboardProvider, DashboardModel?>(
                          (value) => value.dashboardValue)
                      ?.dashboard
                      ?.userPendingVotes ??
                  '0'),
              color: Colors.orange),
          const SizedBox(
            height: 16,
          ),
          progressWidget(
              title: "Points",
              value: double.parse(data.votes?.totalUserConfirmedPoints ?? '0'),
              max: double.parse(data.votes?.totalConfirmedPoints ?? '0'),
              color: AppColors.kGreenColor),
          progressWidget(
              title: "Points en attente",
              max: double.parse(context
                      .select<DashboardProvider, DashboardModel?>(
                          (value) => value.dashboardValue)
                      ?.dashboard
                      ?.totalUserPendingPoints ??
                  '0'),
              value: double.parse(data.votes?.totalUserPendingPoints ?? '0'),
              color: AppColors.kRedColor),
        ],
      ),
    );
  }
}

progressWidget(
    {required String title,
    required double max,
    required double value,
    required Color color}) {
  return Container(
    padding: const EdgeInsets.all(0.0),
    child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      // TextWidgets.text300(
      //     title: title, fontSize: 12, textColor: AppColors.kBlackColor),
      // const SizedBox(height: 8),
      Expanded(
        child: LayoutBuilder(builder: (context, constraints) {
          double percent = 0;
          if (max > 0) {
            percent = (value * 100) / max;
          }
          // return Row(
          //   children: [
          //     Container(
          //       color: AppColors.kRedColor,
          //       width: (constraints.maxHeight) * (percent / 100),
          //       height: 20,
          //     ),
          //   ],
          // );
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidgets.text300(
                      title: title,
                      fontSize: 12,
                      textColor: AppColors.kBlackColor),
                  TextWidgets.text300(
                      title:
                          "$value ${title.toLowerCase()} - ${(percent).toStringAsFixed(4)}%",
                      fontSize: 12,
                      textColor: AppColors.kBlackColor),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: constraints.maxWidth,
                      // width: 40,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: 10,
                          width: (constraints.maxWidth) * (percent / 100),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      )
    ]),
  );
}
