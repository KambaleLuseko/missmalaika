import 'package:flutter/material.dart';

import '../../Resources/Components/texts.dart';
import '../../Resources/Constants/global_variables.dart';
import '../../Resources/Constants/responsive.dart';
import '../../Resources/Helpers/date_parser.dart';
import '../../Resources/Models/match.model.dart';
import 'home.page.dart';

class MatchItemWidget extends StatelessWidget {
  MatchItemWidget({super.key, required this.data});
  MatchModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      decoration: BoxDecoration(color: AppColors.kBlackColor.withOpacity(0.05)),
      child: Column(
        children: [
          TextWidgets.text300(
              align: TextAlign.end,
              title:
                  "${parseDate(date: data.matchDate ?? '').toString().substring(0, 10)} à ${data.matchTime ?? ''}",
              fontSize: 14,
              textColor: AppColors.kBlackColor),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              if (!Responsive.isMobile(context)) Expanded(child: Container()),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: TextWidgets.text500(
                                align: TextAlign.end,
                                title: data.firstTeam!,
                                fontSize: 16,
                                textColor: AppColors.kBlackColor),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 64,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    color: AppColors.kPrimaryColor),
                                child: Text(
                                  data.firstTeamScore ?? '',
                                  style: testStyle(
                                      fontSize: 24,
                                      weight: FontWeight.bold,
                                      color: AppColors.kSecondaryColor),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 64,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    color: AppColors.kSecondaryColor),
                                child: Text(
                                  data.secondTeamScore ?? '',
                                  style: testStyle(
                                      fontSize: 24,
                                      weight: FontWeight.bold,
                                      color: AppColors.kPrimaryColor),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextWidgets.text500(
                                title: data.secondTeam!,
                                fontSize: 16,
                                textColor: AppColors.kBlackColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextWidgets.text300(
                        align: TextAlign.center,
                        maxLines: 2,
                        title: data.comment ?? '',
                        fontSize: 12,
                        textColor: AppColors.kGreyColor),
                  ],
                ),
              ),
              if (!Responsive.isMobile(context)) Expanded(child: Container()),
            ],
          ),
          TextWidgets.text300(
              align: TextAlign.end,
              title: data.isPassed == '1' ? 'Terminé' : '',
              fontSize: 14,
              textColor: AppColors.kBlackColor),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
