// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:missmalaika/Resources/Components/text_fields.dart';
import 'package:missmalaika/Resources/Components/texts.dart';
import 'package:missmalaika/Resources/Constants/global_variables.dart';
import 'package:missmalaika/Resources/Models/partner.model.dart';

class ChooseClientWidget extends StatelessWidget {
  TextEditingController emailCtrller = TextEditingController(),
      usernameCtrller = TextEditingController(),
      passwordCtrller = TextEditingController(),
      confirmPwdCtrller = TextEditingController();
  ClientModel? client;
  ChooseClientWidget({Key? key, this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kTransparentColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextWidgets.text300(
                  title:
                      "Veuillez renseigner les informations que vous allez utiliser pour vous connecter.\nUne fois que votre inscription sera terminee, vous allez utiliser ces informations pour suivre les votes.",
                  fontSize: 16,
                  textColor: AppColors.kBlackColor),
            ),
            TextFormFieldWidget(
                editCtrller: emailCtrller,
                inputType: TextInputType.emailAddress,
                hintText: 'Enter email',
                label: "Email",
                textColor: AppColors.kBlackColor,
                backColor: AppColors.kTextFormBackColor),
            TextFormFieldWidget(
                editCtrller: usernameCtrller,
                hintText: 'Enter username',
                label: "Username",
                textColor: AppColors.kBlackColor,
                backColor: AppColors.kTextFormBackColor),
            TextFormFieldWidget(
                editCtrller: passwordCtrller,
                isObsCured: true,
                hintText: 'Enter password',
                label: "Password",
                textColor: AppColors.kBlackColor,
                backColor: AppColors.kTextFormBackColor),
            TextFormFieldWidget(
                editCtrller: confirmPwdCtrller,
                isObsCured: true,
                hintText: 'Confirm password',
                label: "Confirm password",
                textColor: AppColors.kBlackColor,
                backColor: AppColors.kTextFormBackColor),
          ],
        ),
      ),
    );
  }
}
