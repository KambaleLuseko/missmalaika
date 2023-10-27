// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:missmalaika/Resources/Components/dropdown_button.dart';
import 'package:missmalaika/Resources/Components/text_fields.dart';
import 'package:missmalaika/Resources/Constants/global_variables.dart';
import 'package:missmalaika/Resources/Models/partner.model.dart';

class PersonalClientInfoWidget extends StatefulWidget {
  TextEditingController fullnameCtrller = TextEditingController(),
      addressCtrller = TextEditingController(),
      phoneCtrller = TextEditingController();
  String? city;
  ClientModel? client;
  PersonalClientInfoWidget({Key? key, this.client}) : super(key: key);

  @override
  State<PersonalClientInfoWidget> createState() =>
      _PersonalClientInfoWidgetState();
}

class _PersonalClientInfoWidgetState extends State<PersonalClientInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kTransparentColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(16)),
            TextFormFieldWidget(
                editCtrller: widget.fullnameCtrller,
                inputType: TextInputType.emailAddress,
                hintText: 'Enter your fullname',
                label: "Fullname",
                textColor: AppColors.kBlackColor,
                backColor: AppColors.kTextFormBackColor),
            // TextFormFieldWidget(
            //     editCtrller: widget.addressCtrller,
            //     hintText: 'Enter your full address here',
            //     label: "Addrss",
            //     textColor: AppColors.kBlackColor,
            //     backColor: AppColors.kTextFormBackColor),
            TextFormFieldWidget(
                editCtrller: widget.phoneCtrller,
                hintText: 'Enter your phone number',
                label: "Phone number",
                textColor: AppColors.kBlackColor,
                backColor: AppColors.kTextFormBackColor),
            CustomDropdownButton(
                displayLabel: false,
                textColor: AppColors.kBlackColor,
                backColor: AppColors.kTextFormBackColor,
                dropdownColor: AppColors.kWhiteColor,
                value: widget.city,
                hintText: "Ville",
                callBack: (value) {
                  widget.city = value;
                  setState(() {});
                },
                items: const [
                  "Goma",
                  "Bukavu",
                  "Uvira",
                  "Kindu",
                  "Butembo",
                  "Beni"
                ])
          ],
        ),
      ),
    );
  }
}
