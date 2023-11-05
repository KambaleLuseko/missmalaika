import 'package:flutter/material.dart';
import 'package:missmalaika/Resources/Components/button.dart';
import 'package:missmalaika/Resources/Components/dropdown_button.dart';
import 'package:missmalaika/Resources/Components/radio_button.dart';
import 'package:missmalaika/Resources/Components/reusable.dart';
import 'package:missmalaika/Resources/Components/text_fields.dart';
import 'package:missmalaika/Resources/Components/texts.dart';
import 'package:missmalaika/Resources/Constants/enums.dart';
import 'package:missmalaika/Resources/Constants/global_variables.dart';
import 'package:missmalaika/Resources/Constants/responsive.dart';
import 'package:missmalaika/Views/Admin/Events/controller/event.provider.dart';
import 'package:missmalaika/Views/Admin/Events/model/event.model.dart';
import 'package:missmalaika/Views/parent.page.dart';
import 'package:provider/provider.dart';

class NewEventPage extends StatefulWidget {
  bool? updatingData;
  EventModel? data;
  NewEventPage({super.key, this.updatingData = false, this.data});

  @override
  State<NewEventPage> createState() => _NewEventPageState();
}

class _NewEventPageState extends State<NewEventPage> {
  final TextEditingController _titleCtrller = TextEditingController();
  final TextEditingController _summaryCtrller = TextEditingController();
  final TextEditingController _eventDateCtrller = TextEditingController();
  final TextEditingController _priceCtrller = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.updatingData == true && widget.data != null) {
        _titleCtrller.text = widget.data?.eventName ?? '';
        _summaryCtrller.text = widget.data?.eventDescription ?? '';
        _eventDateCtrller.text = widget.data?.eventDate ?? '';
        _priceCtrller.text = widget.data?.price ?? '';
        status = widget.data?.state ?? '';
        isActive = int.tryParse(widget.data?.isActive ?? '') ?? 0;
        setState(() {});
      }
    });
  }

  String? status;
  int isActive = 0;
  @override
  Widget build(BuildContext context) {
    return ParentPage(
        listData: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(mainAxisSize: MainAxisSize.min, children: [
                TextWidgets.textBold(
                    title:
                        '${widget.updatingData == true ? "Modifier" : "Ajouter"} un évenement',
                    fontSize: 20,
                    textColor: AppColors.kBlackColor),
                const SizedBox(
                  height: 16,
                ),
                TextWidgets.text300(
                    title: 'Tous les champs marqués (*) sont obligatoires',
                    fontSize: 14,
                    textColor: AppColors.kRedColor),
                const SizedBox(
                  height: 16,
                ),
                Flexible(
                  child: TextFormFieldWidget(
                    charType: TextCapitalization.sentences,
                    editCtrller: _titleCtrller,
                    hintText: 'Ecrivez le titre ici',
                    textColor: AppColors.kBlackColor,
                    backColor: AppColors.kTextFormBackColor,
                    label: 'Titre (*)',
                  ),
                ),
                Flexible(
                  child: TextFormFieldWidget(
                    charType: TextCapitalization.sentences,
                    editCtrller: _summaryCtrller,
                    hintText: 'Ecrivez la description ici',
                    textColor: AppColors.kBlackColor,
                    backColor: AppColors.kTextFormBackColor,
                    label: 'Description',
                    maxLines: 5,
                  ),
                ),
                Flex(
                  direction: !Responsive.isMobile(context)
                      ? Axis.horizontal
                      : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: TextFormFieldWidget(
                        charType: TextCapitalization.sentences,
                        editCtrller: _priceCtrller,
                        hintText: 'Saisissez le prix ici',
                        textColor: AppColors.kBlackColor,
                        backColor: AppColors.kTextFormBackColor,
                        inputType: TextInputType.number,
                        label: 'Prix en USD (*)',
                      ),
                    ),
                    Flexible(
                      child: GestureDetector(
                        onTap: () async {
                          String? date = await showDatePickerWidget();
                          if (date == null) return;
                          _eventDateCtrller.text =
                              date.toString().substring(0, 10);
                          setState(() {});
                        },
                        child: TextFormFieldWidget(
                          isEnabled: false,
                          charType: TextCapitalization.sentences,
                          editCtrller: _eventDateCtrller,
                          hintText: 'Saisissez la date ici',
                          textColor: AppColors.kBlackColor,
                          backColor: AppColors.kTextFormBackColor,
                          label: 'Date (*)',
                        ),
                      ),
                    ),
                  ],
                )
              ]),
              const SizedBox(
                height: 16,
              ),
              if (widget.updatingData == true)
                CustomDropdownButton(
                    backColor: AppColors.kTextFormBackColor,
                    textColor: AppColors.kBlackColor,
                    dropdownColor: AppColors.kWhiteColor,
                    displayLabel: false,
                    value: status,
                    hintText: "Statut",
                    callBack: (value) {
                      setState(() {
                        status = value.toString();
                      });
                    },
                    items: const [
                      'Pending',
                      'Ongoing',
                      'Completed',
                      'Canceled'
                    ]),
              const SizedBox(
                height: 16,
              ),
              if (widget.updatingData == true)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextWidgets.text300(
                          title: 'Est-il l\'activité en cours?',
                          fontSize: 16,
                          textColor: AppColors.kBlackColor),
                      const SizedBox(
                        width: 8,
                      ),
                      CustomRadioButton(
                          value: isActive == 1,
                          label: "Oui",
                          textColor: AppColors.kRedColor,
                          callBack: () {
                            isActive = 1;
                            setState(() {});
                          }),
                      const SizedBox(
                        width: 24,
                      ),
                      CustomRadioButton(
                          value: isActive == 0,
                          label: "Non",
                          textColor: AppColors.kGreenColor,
                          callBack: () {
                            isActive = 0;
                            setState(() {});
                          }),
                    ],
                  ),
                ),
              CustomButton(
                  canSync: true,
                  text:
                      widget.updatingData == true ? "Modifier" : "Enregistrer",
                  backColor: AppColors.kPrimaryColor,
                  textColor: AppColors.kWhiteColor,
                  callback: () async {
                    if (double.tryParse(_priceCtrller.text.trim()) == null) {
                      ToastNotification.showToast(
                          msg: "Veuillez saisir un montant valide",
                          msgType: MessageType.error,
                          title: 'Montant invalide');
                      return;
                    }
                    if (_titleCtrller.text.trim().isEmpty ||
                        _summaryCtrller.text.trim().isEmpty ||
                        _eventDateCtrller.text.trim().isEmpty) {
                      ToastNotification.showToast(
                          msg: "Veuillez remplir tous les champs requis",
                          msgType: MessageType.error,
                          title: 'Valeurs invalides');
                      return;
                    }
                    EventModel data = EventModel()
                      ..id = widget.data?.id
                      ..eventName = _titleCtrller.text.trim()
                      ..eventDescription = _summaryCtrller.text.trim()
                      ..eventCategorie = "Concours"
                      ..price = double.parse(_priceCtrller.text.trim())
                          .toStringAsFixed(2)
                      ..eventDate = _eventDateCtrller.text.trim()
                      ..isActive = isActive.toString()
                      ..state = status ?? 'Pending';
                    // print(data.toJson());
                    // return;
                    context.read<EventProvider>().save(
                        action: EnumActions.UPDATE,
                        data: data,
                        callback: () {
                          (Navigator.pop(context));
                        });
                  })
            ],
          ),
        ),
        callback: () {});
  }
}
