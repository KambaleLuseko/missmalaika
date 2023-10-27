import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Resources/Constants/global_variables.dart';
import '../../Resources/Providers/app_state_provider.dart';

class CustomButton extends StatefulWidget {
  CustomButton(
      {Key? key,
      required this.text,
      required this.backColor,
      this.secondBackColor,
      required this.textColor,
      required this.callback,
      this.size,
      this.fontSize = 18,
      this.icon,
      this.canSync = false,
      this.isBordered = false})
      : super(key: key);

  final String text;
  final Color backColor;
  final Color? secondBackColor;
  final Color textColor;
  Function callback;
  double? size, fontSize;
  IconData? icon;
  bool? canSync = false, isBordered = false;

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isButtonHovered = false;

  // double width = 250;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(builder: (context, appStateProvider, _) {
      // if (appStateProvider.isAsync == true && widget.canSync == true) {
      //   width = 40;
      //   setState(() {});
      // }
      return InkWell(
        onTap: () {
          if (context.read<AppStateProvider>().isAsync == false &&
              widget.canSync == true) {
            // if (widget.canSync == true &&
            //     context.read<AppStateProvider>().needToWorkOffline == false) {
            //   // await AppProviders.appProvider.checkApiConnectivity();
            // }
            widget.callback();
            return;
          } else if (widget.canSync == false) {
            widget.callback();
          }
          // widget.callback();
        },
        child: MouseRegion(
          // onHover: (value) => setState(() {
          //   isButtonHovered = true;
          // }),
          // onEnter: (value) => setState(() {
          //   isButtonHovered = true;
          // }),
          // onExit: (value) => setState(() {
          //   isButtonHovered = false;
          // }),
          child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
              constraints: const BoxConstraints(
                  maxWidth: double.maxFinite, minWidth: 40),
              width: appStateProvider.isAsync == true && widget.canSync == true
                  ? 40
                  : widget.size ?? double.maxFinite,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding / 2, vertical: 5),
              padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding / 2, vertical: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      widget.isBordered == true
                          ? AppColors.kTransparentColor
                          : widget.backColor,
                      widget.isBordered == true
                          ? AppColors.kTransparentColor
                          : widget.secondBackColor ?? widget.backColor
                    ]),
                // color: widget.isBordered == true && isButtonHovered == false
                //     ? Colors.transparent
                //     : isButtonHovered
                //         ? widget.backColor.withOpacity(0.9)
                //         : widget.backColor,
                border: widget.isBordered == true
                    ? Border.all(color: widget.backColor, width: 2)
                    : null,
                borderRadius: BorderRadius.circular(
                    appStateProvider.isAsync == true && widget.canSync == true
                        ? 100
                        : 100),
              ),
              child: widget.canSync == null || widget.canSync == false
                  ? FittedBox(
                      child: Text(
                        widget.text,
                        style: TextStyle(
                          fontSize: widget.fontSize,
                          color: widget.isBordered == true
                              ? widget.backColor
                              : widget.textColor,
                        ),
                      ),
                    )
                  : appStateProvider.isAsync == false &&
                          (widget.canSync != null && widget.canSync == true)
                      ? FittedBox(
                          child: Text(
                            widget.text,
                            style: TextStyle(
                              fontSize: widget.fontSize,
                              color: widget.isBordered == true
                                  ? widget.backColor
                                  : widget.textColor,
                            ),
                          ),
                        )
                      : SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              widget.isBordered == true
                                  ? widget.backColor
                                  : widget.textColor,
                            ),
                          ),
                        )),
        ),
      );
    });
  }
}

class IconButtonWidget extends StatefulWidget {
  IconButtonWidget(
      {Key? key,
      required this.backColor,
      this.secondBackColor,
      required this.textColor,
      required this.callback,
      this.size,
      required this.icon,
      this.isBordered = false})
      : super(key: key);

  final Color backColor;
  final Color? secondBackColor;
  final Color textColor;
  Function callback;
  double? size;
  IconData icon;
  bool? isBordered = false;

  @override
  State<IconButtonWidget> createState() => _IconButtonWidgetState();
}

class _IconButtonWidgetState extends State<IconButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.callback();
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                widget.isBordered == true
                    ? AppColors.kTransparentColor
                    : widget.backColor,
                widget.isBordered == true
                    ? AppColors.kTransparentColor
                    : widget.secondBackColor ?? widget.backColor
              ]),
          // color: widget.isBordered == true && isButtonHovered == false
          //     ? Colors.transparent
          //     : isButtonHovered
          //         ? widget.backColor.withOpacity(0.9)
          //         : widget.backColor,
          border: widget.isBordered == true
              ? Border.all(color: widget.backColor, width: 2)
              : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          widget.icon,
          size: widget.size ?? 30,
          color:
              widget.isBordered == true ? widget.backColor : widget.textColor,
        ),
      ),
    );
  }
}
