import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Resources/Components/button.dart';
import '../../../Resources/Components/dropdown_button.dart';
import '../../../Resources/Components/list_item.dart';
import '../../../Resources/Components/reusable.dart';
import '../../../Resources/Components/text_fields.dart';
import '../../../Resources/Components/texts.dart';
import '../../../Resources/Constants/enums.dart';
import '../../../Resources/Constants/global_variables.dart';
import '../../../Resources/Models/Menu/list_item.model.dart';
import '../../../Resources/Models/payment.model.dart';
import '../../../Resources/Providers/candidates.provider.dart';
import '../../../Resources/Providers/users_provider.dart';
import '../../parent.page.dart';

class CandidatePaymentPage extends StatefulWidget {
  String? action;
  String? amount;
  CandidatePaymentPage({super.key, this.action = 'Inscription', this.amount});

  @override
  State<CandidatePaymentPage> createState() => _CandidatePaymentPageState();
}

class _CandidatePaymentPageState extends State<CandidatePaymentPage> {
  List<PaymentModel> payments = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      total = payments
          .map((e) => double.parse(e.amount ?? '0'))
          .fold(0.0, (prev, next) => prev + next);
      amount = widget.amount != null &&
              widget.amount!.isNotEmpty &&
              widget.action?.toLowerCase() == 'vote'
          ? widget.amount
          : "10";
      setState(() {});
    });
  }

  String? amount;

  String paymentGateway = "Visa card";
  String? currency;

  double total = 0;
  final TextEditingController _numberCtrller = TextEditingController();
  final TextEditingController _expiryDateCtrller = TextEditingController();
  final TextEditingController _cvvCtrller = TextEditingController();
  final TextEditingController _cardNameCtrller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ParentPage(
        listData: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListItem(
                title: context
                        .read<UserProvider>()
                        .candidate
                        ?.fullname
                        ?.toUpperCase() ??
                    '',
                subtitle: context
                        .read<UserProvider>()
                        .candidate
                        ?.address
                        ?.toUpperCase() ??
                    '',
                detailsFields: const [],
                keepMidleFields: true,
                middleFields: ListItemModel(
                  value: context.read<UserProvider>().candidate?.uuid ?? '',
                  title: "Number",
                  displayLabel: true,
                ),
                textColor: AppColors.kBlackColor,
                backColor: AppColors.kTextFormBackColor,
                icon: Icons.person,
              ),
              ListItem(
                title: context
                        .read<UserProvider>()
                        .candidate
                        ?.event
                        ?.first
                        .eventName
                        ?.toUpperCase() ??
                    '',
                subtitle: context
                        .read<UserProvider>()
                        .candidate
                        ?.event
                        ?.first
                        .eventDescription
                        ?.toUpperCase() ??
                    '',
                detailsFields: const [],
                textColor: AppColors.kBlackColor,
                backColor: AppColors.kTextFormBackColor,
                icon: Icons.event_available_rounded,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  child: TextWidgets.textBold(
                      title: 'Mode de paiement',
                      fontSize: 16,
                      textColor: AppColors.kBlackColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TabFilterWidget(
                    backColor: AppColors.kTextFormBackColor,
                    textColor: AppColors.kWhiteColor,
                    inactiveColor: AppColors.kBlackColor.withOpacity(0.7),
                    callback: (value) {
                      paymentGateway = value.toString();
                      setState(() {});
                    },
                    titles: const [
                      "Visa card",
                      "Mastercard",
                      "Mobile money",
                      "IllicoCash"
                    ]),
              ),
              CustomDropdownButton(
                  backColor: AppColors.kTextFormBackColor,
                  textColor: AppColors.kBlackColor,
                  dropdownColor: AppColors.kWhiteColor,
                  displayLabel: false,
                  value: currency,
                  hintText: 'Devise',
                  callBack: (value) {
                    currency = value;
                    setState(() {});
                  },
                  items: const ["USD", "CDF"]),
              if (!paymentGateway.toLowerCase().contains('card'))
                TextFormFieldWidget(
                  hintText: 'Numero *',
                  textColor: AppColors.kBlackColor,
                  backColor: AppColors.kTextFormBackColor,
                  editCtrller: _numberCtrller,
                  inputType: TextInputType.number,
                  maxLines: 1,
                ),
              if (!paymentGateway.toLowerCase().contains('card'))
                TextFormFieldWidget(
                  hintText: 'Nom du proprietaire *',
                  textColor: AppColors.kBlackColor,
                  backColor: AppColors.kTextFormBackColor,
                  editCtrller: _cardNameCtrller,
                  inputType: TextInputType.text,
                  maxLines: 1,
                ),
              CustomButton(
                  canSync: true,
                  size: 300,
                  text:
                      "Je paie ${widget.action?.toLowerCase() == 'vote' ? 'mon vote' : 'mon inscription'}",
                  backColor: AppColors.kPrimaryColor,
                  textColor: AppColors.kWhiteColor,
                  callback: () {
                    if (paymentGateway.toLowerCase().contains('card')) {
                      launchUrl(Uri.parse(
                          "${BaseUrl.cardPayment}?action=${widget.action}&amount=$amount&candidate=${context.read<UserProvider>().candidate!.uuid!.toString()}&event_id=${context.read<UserProvider>().candidate!.event!.first.eventID!.toString()}"));
                      return;
                    }
                    if (currency == null ||
                        _numberCtrller.text.isEmpty ||
                        _cardNameCtrller.text.isEmpty) {
                      ToastNotification.showToast(
                          msg: "Veuillez remplir tous les champs",
                          msgType: MessageType.error,
                          title: "Valeurs incorrectes");
                      return;
                    }
                    if (paymentGateway.toLowerCase() != 'mobile money' &&
                        paymentGateway.toLowerCase() != 'illicocash') {
                      ToastNotification.showToast(
                          msg:
                              "Ce moyen de paiement n'est pas encore disponible.\nNos équipes travaillent dessus sans relâche.",
                          msgType: MessageType.error,
                          title: "Non disponible");
                      return;
                    }
                    PaymentModel data = PaymentModel(
                      action: widget.action,
                      userUUID: context
                          .read<UserProvider>()
                          .candidate!
                          .uuid!
                          .toString(),
                      eventId: context
                          .read<UserProvider>()
                          .candidate!
                          .event!
                          .first
                          .eventID!,
                      currency: currency,
                      type: paymentGateway.trim(),
                      number: _numberCtrller.text.trim(),
                      amount: amount!,
                      expiryDate: paymentGateway.toLowerCase() != 'mobile money'
                          ? _expiryDateCtrller.text.trim()
                          : "",
                      cvv: paymentGateway.toLowerCase() != 'mobile money'
                          ? _cvvCtrller.text.trim()
                          : "",
                    );
                    context.read<CandidateProvider>().savePayment(
                        data: data,
                        callback: () {
                          Navigator.pop(context);
                        });
                    // print(data.toJSON());
                  }),
            ],
          ),
        ),
        callback: () {});
  }
}
