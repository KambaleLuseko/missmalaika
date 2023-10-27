import 'package:flutter/material.dart';

import '../../Resources/Constants/global_variables.dart';
import '../../main.dart';

showDatePicketCustom({required Function callback}) async {
  await showDatePicker(
    context: navKey.currentContext!,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(const Duration(days: 365)),
    builder: (BuildContext context, child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: AppColors.kSecondaryColor,
          buttonTheme:
              const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          colorScheme: ColorScheme.light(primary: AppColors.kSecondaryColor)
              .copyWith(secondary: AppColors.kSecondaryColor),
        ),
        child: child!,
      );
    },
  ).then((value) => callback(value)).catchError((error) {});
}

showTimePickerCustom({required Function callback}) async {
  await showTimePicker(
    context: navKey.currentContext!,
    initialTime: TimeOfDay.now(),
    builder: (BuildContext context, child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: AppColors.kSecondaryColor,
          buttonTheme:
              const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          colorScheme: ColorScheme.light(primary: AppColors.kSecondaryColor)
              .copyWith(secondary: AppColors.kSecondaryColor),
        ),
        child: child!,
      );
    },
  ).then((value) => callback(value)).catchError((error) {});
}
