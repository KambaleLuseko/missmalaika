import 'package:flutter/material.dart';

class DecoratedContainer extends StatelessWidget {
  Color? backColor;
  final Widget child;
  double? radius;
  DecoratedContainer(
      {Key? key,
      this.backColor = Colors.transparent,
      required this.child,
      this.radius = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius!),
        color: backColor,
      ),
      child: child,
    );
  }
}
