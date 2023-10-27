import 'package:flutter/material.dart';
import '../../../Resources/Components/applogo.dart';
import '../../../Resources/Components/empty_model.dart';
import '../../../Resources/Components/list_item.dart';
import '../../../Resources/Components/texts.dart';
import '../../../Resources/Constants/global_variables.dart';
import '../../../Resources/Helpers/date_parser.dart';
import '../../../Resources/Models/Menu/list_item.model.dart';
import '../../../Resources/Models/dashboard.model.dart';
import '../../../Resources/Models/payment.model.dart';
import '../../../Resources/Providers/dashboard.provider.dart';
import '../../../Resources/Providers/users_provider.dart';
import 'admin.dashboard.dart';
import '../../parent.page.dart';
import 'package:provider/provider.dart';

class CandidateDashboardPage extends StatefulWidget {
  const CandidateDashboardPage({super.key});

  @override
  State<CandidateDashboardPage> createState() => _CandidateDashboardPageState();
}

class _CandidateDashboardPageState extends State<CandidateDashboardPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context
          .read<DashboardProvider>()
          .getOnline(value: context.read<UserProvider>().candidate!.uuid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ParentPage(
        listData: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Flexible(child: AppLogo(size: Size(200, 200))),
                Flexible(
                    fit: FlexFit.tight,
                    flex: 2,
                    child: Column(
                      children: [
                        Row(),
                        if (context.select<DashboardProvider, DashboardModel?>(
                                (value) => value.dashboardValue) !=
                            null)
                          CandidateStatItemWidget(
                            data: context
                                .select<DashboardProvider, DashboardModel?>(
                                    (value) => value.dashboardValue)!
                                .candidatesStats![0],
                            hasSpace: false,
                          ),
                        const SizedBox(
                          height: 24,
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: TextWidgets.textBold(
                              title: "Historique des votes",
                              fontSize: 18,
                              textColor: AppColors.kBlackColor),
                        ),
                        Selector<DashboardProvider, DashboardModel?>(
                            selector: (_, provider) => provider.dashboardValue,
                            builder: (__, dashbordValue, _) {
                              return dashbordValue != null
                                  ? ListView.builder(
                                      itemCount: dashbordValue
                                          .candidatesStats![0].history!.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        PaymentModel data = dashbordValue
                                            .candidatesStats![0]
                                            .history![index];
                                        return ListItem(
                                          icon: Icons.payment,
                                          backColor:
                                              AppColors.kTextFormBackColor,
                                          textColor: AppColors.kBlackColor,
                                          title: data.number ?? '',
                                          subtitle:
                                              "${data.points ?? '0'} points",
                                          keepMidleFields: true,
                                          updateIcon: int.tryParse(data.isPayed
                                                          ?.toString() ??
                                                      '') ==
                                                  1
                                              ? Icons.check_circle
                                              : Icons.autorenew,
                                          hasUpdate: true,
                                          hasDelete: true,
                                          deleteIcon: Icons.call,
                                          deleteCallback: () {},
                                          middleFields: ListItemModel(
                                              displayLabel: true,
                                              title: 'Montant',
                                              value: "${data.amount ?? '0'}\$"),
                                          detailsFields: [
                                            ListItemModel(
                                                title: 'Date',
                                                value: parseDate(
                                                    date:
                                                        data.createdAt ?? '')),
                                            ListItemModel(
                                                title: 'Reference',
                                                value: data.paymentReference ??
                                                    ''),
                                          ],
                                        );
                                      })
                                  : EmptyModel(color: AppColors.kGreyColor);
                            })
                      ],
                    ))
              ],
            ),
          ],
        ),
        callback: () {});
  }
}
