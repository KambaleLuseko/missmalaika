// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../Resources/Components/texts.dart';
import '../../Resources/Constants/global_variables.dart';

class TextFormFieldWidget extends StatefulWidget {
  bool? hasMargin;
  String? label;
  final String hintText;
  final Color textColor;
  Color backColor;
  final bool? isEnabled;
  bool? isObsCured;
  final TextEditingController? editCtrller;
  int? maxLines = 1;
  int maxLength = 255;
  TextInputType? inputType;
  TextCapitalization? charType;

  TextFormFieldWidget(
      {Key? key,
      required this.hintText,
      required this.textColor,
      required this.backColor,
      this.editCtrller,
      this.inputType,
      maxLength,
      this.maxLines = 1,
      this.isEnabled,
      this.isObsCured,
      this.hasMargin = true,
      this.label,
      this.charType = TextCapitalization.sentences})
      : super(key: key);

  @override
  _TextFormFieldWidgetState createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  FocusNode? focus;
  late Color backColor;
  @override
  void initState() {
    super.initState();
    backColor = widget.backColor;
    focus = FocusNode();
    focus!.addListener(() {
      if (focus!.hasFocus) {
        backColor = widget.backColor.withOpacity(0.1);
      } else {
        backColor = widget.backColor;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.hasMargin == true
          ? const EdgeInsets.symmetric(horizontal: 10, vertical: 5)
          : const EdgeInsets.all(0),
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
                color: backColor,
                border: Border.all(color: widget.textColor.withOpacity(0.1)),
                borderRadius: BorderRadius.circular(8)),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: TextFormField(
                    textCapitalization:
                        widget.inputType == TextInputType.emailAddress ||
                                widget.isObsCured == true
                            ? TextCapitalization.none
                            : widget.charType ?? TextCapitalization.sentences,
                    focusNode: focus,
                    keyboardType: widget.inputType,
                    enabled:
                        widget.isEnabled != null ? widget.isEnabled! : true,
                    obscureText:
                        widget.isObsCured != null ? widget.isObsCured! : false,
                    maxLines: widget.isObsCured == true ? 1 : widget.maxLines,
                    style: TextStyle(color: widget.textColor),
                    textAlign: TextAlign.left,
                    controller: widget.editCtrller,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 0),
                      hintText: widget.hintText,
                      hintStyle:
                          TextStyle(color: widget.textColor.withOpacity(0.5)),
                      label: TextWidgets.text300(
                          title: widget.label ?? widget.hintText,
                          fontSize: 12,
                          textColor: widget.textColor.withOpacity(1)),
                      enabledBorder: InputBorder.none,
                      // OutlineInputBorder(
                      //     borderSide: BorderSide(
                      //         color: widget.textColor.withOpacity(0.1),
                      //         width: 1,
                      //         style: BorderStyle.solid)),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      //  OutlineInputBorder(
                      //     borderSide: BorderSide(
                      //         color: widget.textColor.withOpacity(1),
                      //         width: 1,
                      //         style: BorderStyle.solid)),
                      // hintText: widget.hintText,
                      // hintStyle:
                      //     TextStyle(color: widget.textColor.withOpacity(0.5))
                    ),
                  ),
                ),
                if (widget.isObsCured != null)
                  Positioned(
                      top: 0,
                      bottom: 0,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          widget.isObsCured = !widget.isObsCured!;
                          setState(() {});
                        },
                        child: Center(
                          child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  color: widget.textColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(
                                      kDefaultPadding / 4)),
                              child: Icon(
                                  widget.isObsCured != null &&
                                          widget.isObsCured == false
                                      ? Icons.vpn_key_rounded
                                      : Icons.remove_red_eye,
                                  color: widget.textColor,
                                  size: 20)),
                        ),
                      ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class TextFormVerification extends StatefulWidget {
//   final String hintText;
//   final Color textColor;
//   final Color backColor;
//   final TextEditingController editCtrller;
//   int maxLines = 1;

//   TextFormVerification(
//       {Key? key,
//       required this.hintText,
//       required this.textColor,
//       required this.backColor,
//       required this.editCtrller,
//       required this.maxLines})
//       : super(key: key);

//   @override
//   _TextFormVerificationState createState() => _TextFormVerificationState();
// }

// class _TextFormVerificationState extends State<TextFormVerification> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       width: double.maxFinite,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: const EdgeInsets.only(top: 8, bottom: 8),
//             decoration: BoxDecoration(
//                 color: widget.backColor,
//                 borderRadius: BorderRadius.circular(kDefaultPadding / 4)),
//             child: TextFormField(
//               textAlignVertical: TextAlignVertical.center,
//               obscureText: false,
//               maxLines: widget.maxLines,
//               style: TextStyle(color: widget.textColor),
//               textAlign: TextAlign.center,
//               decoration: InputDecoration.collapsed(
//                 // contentPadding: const EdgeInsets.symmetric(horizontal: 8),
//                 hintText: widget.hintText,
//                 hintStyle: TextStyle(color: widget.textColor.withOpacity(0.5)),
//                 // border: UnderlineInputBorder(
//                 //     borderSide: BorderSide(color: widget.textColor, width: 1)),
//                 // focusedBorder: UnderlineInputBorder(
//                 //     borderSide: BorderSide(color: widget.textColor, width: 3)),
//                 // hintText: widget.hintText,
//                 // hintStyle:
//                 //     TextStyle(color: widget.textColor.withOpacity(0.5))
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
