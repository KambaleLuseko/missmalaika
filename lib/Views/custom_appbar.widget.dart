import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Resources/Components/texts.dart';
import '../Resources/Constants/global_variables.dart';
import '../Resources/Providers/menu_provider.dart';

class CustomAppBarWidget extends StatefulWidget {
  bool? hasSearch;
  void callback;
  CustomAppBarWidget({Key? key, this.hasSearch = false, this.callback})
      : super(key: key);

  @override
  State<CustomAppBarWidget> createState() => _CustomAppBarWidgetState();
}

class _CustomAppBarWidgetState extends State<CustomAppBarWidget> {
  bool isMenuVisible = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(
            top: kIsWeb ? 8 : 48, left: 8, right: 8, bottom: 8),
        decoration: BoxDecoration(color: AppColors.kWhiteColor),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                  // context.read<MenuProvider>().changeMenuState();
                },
                icon: Icon(Icons.menu, color: AppColors.kBlackColor)),
            const SizedBox(width: 16),
            TextWidgets.textBold(
                title: context.select<MenuProvider, String>(
                    (provider) => provider.activePage.title),
                fontSize: 22,
                textColor: AppColors.kBlackColor),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [],
              ),
            )
          ],
        ));
  }
}

class IconStateItem extends StatelessWidget {
  bool validState;
  final IconData icon;
  Widget? errorIcon;

  IconStateItem(
      {Key? key, required this.icon, this.errorIcon, this.validState = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: null,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              icon,
              color: AppColors.kBlackColor,
              size: 20,
            ),
          ),
          if (validState == false)
            Positioned(
                top: 0,
                right: 0,
                child: Card(
                  color: AppColors.kRedColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  margin: const EdgeInsets.all(0),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: errorIcon ??
                        Icon(
                          Icons.warning_amber_rounded,
                          color: AppColors.kWhiteColor,
                          size: 8,
                        ),
                  ),
                ))
        ],
      ),
    );
  }
}
