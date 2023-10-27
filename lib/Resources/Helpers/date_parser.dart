import 'package:date_format/date_format.dart';

String parseDate({required String date}) {
  if (date.isEmpty) return "0000-00-00";
  return formatDate(DateTime.parse(date.toString().trim()),
      [dd, '/', mm, '/', yyyy, ' ', HH, '\\h ', nn, 'min ', ss, '\\s']);
}

numberFormat({required double number}) {
  return number.toStringAsFixed(number.truncateToDouble() == number ? 0 : 2);
}

characterHider({required String data, int? spacer = 4}) {
  if (data.isEmpty) return '';
  String result =
      (('*' * (data.length - 4)) + data.substring(data.length - 4)).toString();
  if (spacer == 0) return result;
  String enteredData = result; // get data enter by used in textField
  StringBuffer buffer = StringBuffer();
  for (int i = 0; i < enteredData.length; i++) {
    // add each character into String buffer
    buffer.write(enteredData[i]);
    int index = i + 1;
    if (index % spacer! == 0 && enteredData.length != index) {
      // add space after 4th digit
      buffer.write(" ");
    }
  }
  return buffer.toString();
}

// amountConversion({required String amount, required String currency}) {
//   if (navKey.currentContext!.read<UserProvider>().defaultCurrency != null) {
//     if (navKey.currentContext!
//             .read<UserProvider>()
//             .defaultCurrency
//             ?.name
//             .toLowerCase() !=
//         'usd') {
//       if (currency.toLowerCase() == 'usd') {
//         return double.parse(amount) *
//             double.parse(navKey.currentContext!
//                 .read<UserProvider>()
//                 .defaultCurrency!
//                 .rateFromUSD);
//       }
//     }
//     if (navKey.currentContext!
//             .read<UserProvider>()
//             .defaultCurrency
//             ?.name
//             .toLowerCase() ==
//         'usd') {
//       if (currency.toLowerCase() != 'usd') {
//         return double.parse(amount) /
//             double.parse(navKey.currentContext!
//                 .read<UserProvider>()
//                 .defaultCurrency!
//                 .rateFromUSD);
//       }
//     }
//     if (navKey.currentContext!
//             .read<UserProvider>()
//             .defaultCurrency
//             ?.name
//             .toLowerCase() ==
//         'usd') {
//       if (currency.toLowerCase() == 'usd') {
//         return double.parse(amount);
//       }
//     }
//   }
//   return double.parse(amount);
// }
