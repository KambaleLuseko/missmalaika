import 'package:flutter/material.dart';

import '../../Resources/Components/button.dart';
import '../../Resources/Components/texts.dart';
import '../../Resources/Constants/global_variables.dart';
import '../../Resources/Constants/responsive.dart';
import '../../main.dart';

class PageListTitleWidget extends StatelessWidget {
  final Function addCallback, refreshCallback;
  final String title;
  final String description;
  String? buttonText;
  PageListTitleWidget(
      {Key? key,
      required this.addCallback,
      required this.refreshCallback,
      required this.title,
      required this.description,
      buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(8),
      child: Flex(
          mainAxisSize: Responsive.isMobile(navKey.currentContext!)
              ? MainAxisSize.min
              : MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Responsive.isWeb(navKey.currentContext!)
              ? Axis.horizontal
              : Axis.vertical,
          children: [
            Flexible(
                fit: FlexFit.loose,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidgets.textBold(
                          title: title,
                          fontSize: 18,
                          textColor: AppColors.kPrimaryColor),
                      TextWidgets.text300(
                          title: description,
                          fontSize: 12,
                          textColor: AppColors.kPrimaryColor),
                    ])),
            Flexible(
              fit: FlexFit.loose,
              child: Row(
                mainAxisSize: Responsive.isMobile(navKey.currentContext!)
                    ? MainAxisSize.max
                    : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                      text: buttonText ?? "Ajouter",
                      backColor: AppColors.kPrimaryColor,
                      textColor: AppColors.kScaffoldColor,
                      callback: () async {
                        addCallback();
                        // Dialogs.showModal(child: AddStorePage());
                      }),
                  IconButton(
                      onPressed: () {
                        refreshCallback();
                        // context.read<StoresProvider>().get(isRefresh: true);
                      },
                      icon: Icon(Icons.autorenew, color: AppColors.kBlackColor))
                ],
              ),
            )
          ]),
    );
  }
}

filterButton(
    {required String title,
    required bool isActive,
    Color? backColor,
    Color? textColor = Colors.black,
    inactiveColor = Colors.black,
    FlexFit? flexFit = FlexFit.tight,
    required var callback}) {
  backColor ??= AppColors.kScaffoldColor;
  return Flexible(
    fit: flexFit!,
    child: GestureDetector(
      onTap: callback,
      child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          color:
              isActive ? AppColors.kPrimaryColor : AppColors.kTransparentColor,
          elevation: 0,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(8),
          )),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TextWidgets.textNormal(
                align: TextAlign.center,
                title: title,
                fontSize: 14,
                textColor: isActive ? textColor! : inactiveColor),
          )),
    ),
  );
}

class TabFilterWidget extends StatefulWidget {
  Function callback;
  final List<String> titles;
  Color backColor;
  Color? textColor, inactiveColor;
  FlexFit? flexFit;
  MainAxisSize? mainSize;
  TabFilterWidget(
      {Key? key,
      required this.callback,
      required this.titles,
      this.flexFit = FlexFit.tight,
      this.backColor = Colors.white,
      this.mainSize = MainAxisSize.max,
      this.textColor = Colors.white,
      this.inactiveColor = Colors.white})
      : super(key: key);

  @override
  State<TabFilterWidget> createState() => _TabFilterWidgetState();
}

class _TabFilterWidgetState extends State<TabFilterWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      currentFilter = widget.titles[0];
      widget.callback(currentFilter);
      setState(() {});
    });
  }

  String currentFilter = "";
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Card(
        margin: const EdgeInsets.all(0),
        color: widget.backColor,
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(8),
        )),
        child: Row(
            mainAxisSize: widget.mainSize!,
            children: List.generate(widget.titles.length, (index) {
              return filterButton(
                  flexFit: widget.flexFit,
                  backColor: widget.backColor,
                  textColor: widget.textColor,
                  inactiveColor: widget.inactiveColor,
                  title: widget.titles[index],
                  isActive: currentFilter == widget.titles[index],
                  callback: () {
                    setState(() {
                      currentFilter = widget.titles[index];
                      widget.callback(currentFilter);
                      setState(() {});
                    });
                  });
            })),
      ),
    );
  }
}

class FlexWidget extends StatelessWidget {
  final List<Widget> content;
  const FlexWidget({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Responsive.isMobile(navKey.currentContext!)
          ? Axis.vertical
          : Axis.horizontal,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: content,
    );
  }
}

Future<String?> showDatePickerWidget() async {
  Duration startDate = const Duration(days: 365 * 100);
  DateTime? pickedDate = await showDatePicker(
      builder: (context, child) => Theme(
          data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
            primary: AppColors.kPrimaryColor,
            // onPrimary: AppColors.kWhiteColor,
          )),
          child: child!),
      context: navKey.currentContext!,
      initialDate: DateTime.now().subtract(const Duration(days: 30)),
      firstDate: DateTime.now().subtract(startDate),
      lastDate: DateTime.now());
  if (pickedDate == null) {
    return null;
  }
  return pickedDate.toString();
}
