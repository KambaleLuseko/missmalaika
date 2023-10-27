import 'package:flutter/material.dart';

class TextWidgets {
  static textWithLabel(
      {required String title,
      required double fontSize,
      required Color textColor,
      required String value,
      bool? hasPadding = true,
      CrossAxisAlignment? align = CrossAxisAlignment.start}) {
    return Padding(
      padding: hasPadding == true
          ? const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0)
          : EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: align!,
        children: [
          Container(
            // width: double.maxFinite,
            padding: EdgeInsets.zero,
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: fontSize, color: textColor.withOpacity(0.7)),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            // width: double.maxFinite,
            padding: EdgeInsets.zero,
            child: Text(
              value,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: fontSize,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static textHorizontalWithLabel(
      {required String title,
      required double fontSize,
      required Color textColor,
      required String value,
      Alignment? valueAlign,
      int? maxLines = 5}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              // width: double.maxFinite,
              padding: EdgeInsets.zero,
              child: Text(
                title,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: fontSize, color: textColor.withOpacity(0.7)),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: valueAlign,
              // width: double.maxFinite,
              padding: EdgeInsets.zero,
              child: Text(
                value,
                maxLines: maxLines!,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: fontSize,
                  color: textColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static textNormal(
      {required String title,
      required double fontSize,
      required Color textColor,
      int? maxLines = 5,
      TextAlign align = TextAlign.left}) {
    return Container(
      // width: double.maxFinite,
      padding: EdgeInsets.zero,
      child: Text(
        title,
        textAlign: align,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: fontSize, color: textColor),
      ),
    );
  }

  static text300(
      {required String title,
      required double fontSize,
      required Color textColor,
      IconData? icon,
      int? maxLines = 5,
      TextAlign align = TextAlign.left}) {
    return Container(
      padding: EdgeInsets.zero,
      child: Text(
        title,
        textAlign: align,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: fontSize, fontWeight: FontWeight.w300, color: textColor),
      ),
    );
  }

  static text500(
      {required String title,
      required double fontSize,
      required Color textColor,
      int? maxLines = 5,
      TextAlign align = TextAlign.left}) {
    return Container(
      padding: EdgeInsets.zero,
      child: Text(
        title,
        textAlign: align,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: fontSize, fontWeight: FontWeight.w500, color: textColor),
      ),
    );
  }

  static textBold(
      {required String title,
      required double fontSize,
      required Color textColor,
      IconData? icon,
      TextAlign align = TextAlign.left,
      int? maxLines = 5}) {
    return Container(
      padding: EdgeInsets.zero,
      child: Text(
        title,
        textAlign: align,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: fontSize, fontWeight: FontWeight.bold, color: textColor),
      ),
    );
  }
}
