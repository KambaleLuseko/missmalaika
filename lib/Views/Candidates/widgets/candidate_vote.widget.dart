import 'package:flutter/material.dart';

import '../../../Resources/Components/button.dart';
import '../../../Resources/Components/dialogs.dart';
import '../../../Resources/Components/list_item.dart';
import '../../../Resources/Components/texts.dart';
import '../../../Resources/Constants/global_variables.dart';
import '../../../Resources/Models/Menu/list_item.model.dart';
import '../../../Resources/Models/partner.model.dart';
import '../view/candidatePayment.page.dart';

class VoteCandidateWidget extends StatefulWidget {
  CandidateModel data;
  VoteCandidateWidget({super.key, required this.data});

  @override
  State<VoteCandidateWidget> createState() => _VoteCandidateWidgetState();
}

class _VoteCandidateWidgetState extends State<VoteCandidateWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        ListItem(
          title: widget.data.fullname?.toUpperCase() ?? '',
          subtitle: widget.data.address?.toUpperCase() ?? '',
          detailsFields: const [],
          keepMidleFields: true,
          middleFields: ListItemModel(
            value: widget.data.uuid ?? '',
            title: "Code",
            displayLabel: true,
          ),
          textColor: AppColors.kBlackColor,
          backColor: AppColors.kTextFormBackColor,
          icon: Icons.person,
        ),
        // TextWidgets.text500(
        //     title: 'Voter pour votre candidate ${widget.data.fullname}',
        //     fontSize: 16,
        //     textColor: AppColors.kBlackColor),
        const SizedBox(
          height: 24,
        ),
        voteItem(points: '1', amount: '1', activeColor: AppColors.kGreenColor),
        voteItem(points: '10', amount: '5', activeColor: AppColors.kGreenColor),
        voteItem(
            points: '30', amount: '10', activeColor: AppColors.kGreenColor),
        voteItem(
            points: '100', amount: '20', activeColor: AppColors.kGreenColor),
        voteItem(
            points: '500', amount: '40', activeColor: AppColors.kGreenColor),
        CustomButton(
            size: 150,
            text: "Confirmer",
            backColor: AppColors.kPrimaryColor,
            textColor: AppColors.kWhiteColor,
            callback: () {
              if (voteAmount.isEmpty || votePoint.isEmpty) {
                Dialogs.showDialogNoAction(
                    title: "Erreur",
                    content:
                        "Vous devez sélectrionner les points à donner à votre candidate");
                return;
              }
              Navigator.pop(context);
              Dialogs.showDialogWithAction(
                  title: 'Confirmation',
                  content:
                      "Vous allez faire un paiement de $voteAmount\$ pour $votePoint point(s) en faveur de la candidate.\nVoulez-vous continuer?",
                  callback: () {
                    Dialogs.showDialogWithActionCustomContent(
                        title: "",
                        content: CandidatePaymentPage(
                          amount: voteAmount,
                          action: "Vote",
                        ));
                  });
            })
      ],
    );
  }

  String votePoint = "", voteAmount = "";

  voteItem(
      {required String points,
      required String amount,
      required Color activeColor}) {
    return GestureDetector(
      onTap: () {
        votePoint = points;
        voteAmount = amount;
        setState(() {});
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
            color: AppColors.kWhiteColor,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 0),
                  color: AppColors.kBlackColor.withOpacity(0.2),
                  blurRadius: 2,
                  spreadRadius: 0)
            ],
            border: Border.all(
                color: voteAmount == amount
                    ? activeColor
                    : AppColors.kTransparentColor,
                width: 3,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidgets.textBold(
                    title: "$amount\$",
                    fontSize: 18,
                    textColor: AppColors.kBlackColor),
                TextWidgets.textBold(
                    title: "$points point(s)",
                    fontSize: 24,
                    textColor: AppColors.kBlackColor),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            TextWidgets.text300(
                title:
                    "Offrez $points point(s) à votre candidate pour lui donner la chance de remporter le concours Miss Malaika",
                fontSize: 14,
                textColor: AppColors.kBlackColor.withOpacity(0.7)),
          ],
        ),
      ),
    );
  }
}
