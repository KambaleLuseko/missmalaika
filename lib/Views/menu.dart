import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Resources/Components/dialogs.dart';
import '../../Resources/Constants/enums.dart';
import '../../Resources/Constants/global_variables.dart';
import '../../Resources/Models/Menu/menu.model.dart';
import '../../Resources/Providers/menu_provider.dart';

// com.magocorporate.magorevenue

class MenuWidget extends StatefulWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      elevation: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
            decoration: BoxDecoration(
              color: AppColors.kWhiteColor,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Consumer<MenuProvider>(
                builder: (context, menuStateProvider, child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 120,
                    child: Column(children: const []),
                  ),
                  SingleChildScrollView(
                      controller: ScrollController(keepScrollOffset: false),
                      child: Column(children: [
                        ...List.generate(menuStateProvider.menus.length,
                            (index) {
                          return MenuItem(
                              menu: menuStateProvider.menus[index],
                              textColor: AppColors.kBlackColor,
                              hoverColor:
                                  AppColors.kBlackColor.withOpacity(0.2),
                              backColor: AppColors.kTransparentColor);
                        }),
                        const SizedBox(
                          height: 32,
                        ),
                      ])),
                  GestureDetector(
                    onTap: () {
                      Dialogs.showDialogWithAction(
                          title: "Deconnexion",
                          content:
                              "Voulez-vous deconnecter votre compte?\nVous serez obligé de vous reconnecter",
                          callback: () {
                            // context.read<UserProvider>().logOut();
                          },
                          dialogType: MessageType.warning);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      margin: const EdgeInsets.only(left: 8, top: 0, bottom: 0),
                      decoration: BoxDecoration(
                        color: AppColors.kTransparentColor.withOpacity(0),
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            topLeft: Radius.circular(16)),
                      ),
                      // menuStateProvider.currentMenu == widget.title || isButtonHovered
                      //     ? widget.textColor
                      //     : widget.backColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.exit_to_app,
                                        color: AppColors.kSecondaryColor
                                            .withOpacity(0.5),
                                      ),
                                      // const SizedBox(width: 16.0),
                                      // Container(
                                      //     padding: EdgeInsets.zero,
                                      //     child: Text(
                                      //       "Deconnexion",
                                      //       style: TextStyle(
                                      //           color: AppColors.kGreyColor,
                                      //           fontSize: 14,
                                      //           fontWeight: FontWeight.bold),
                                      //     )),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              );
            })),
      ),
    );
  }
}

class MenuItem extends StatefulWidget {
  final MenuModel menu;
  Color textColor;
  Color hoverColor;
  Color backColor;

  MenuItem(
      {Key? key,
      required this.menu,
      required this.backColor,
      required this.hoverColor,
      required this.textColor})
      : super(key: key);

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  bool isButtonHovered = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuProvider>(builder: (context, menuStateProvider, child) {
      return GestureDetector(
        onTap: () {
          // if (!Responsive.isWeb(context)) {
          //   // Navigator.pop(context);
          // }
          if (menuStateProvider.getActivePage()?.title == widget.menu.title) {
            return;
          }
          menuStateProvider.setActivePage(newPage: widget.menu);
          context.read<MenuProvider>().changeMenuState();
          // Navigation.pushNavigate(page: widget.menu.page);
        },
        child: MouseRegion(
          // cursor: MouseCursor.,
          // onHover: (value) => setState(() {
          //   isButtonHovered = true;
          // }),
          // onEnter: (value) => setState(() {
          //   isButtonHovered = true;
          // }),
          // onExit: (value) => setState(() {
          //   isButtonHovered = false;
          // }),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            margin: const EdgeInsets.only(left: 0, top: 0, bottom: 0),
            decoration: BoxDecoration(
              color: menuStateProvider.activePage.title == widget.menu.title
                  ? widget.hoverColor
                  : widget.backColor,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  topLeft: Radius.circular(16)),
            ),
            // menuStateProvider.currentMenu == widget.title || isButtonHovered
            //     ? widget.textColor
            //     : widget.backColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Icon(
                              widget.menu.icon,
                              color: menuStateProvider.activePage.title ==
                                          widget.menu.title ||
                                      isButtonHovered
                                  ? widget.textColor
                                  : widget.textColor,
                            ),
                            const SizedBox(width: 16.0),
                            FittedBox(
                              child: Text(
                                widget.menu.title,
                                style: TextStyle(
                                    color: menuStateProvider.activePage.title ==
                                                widget.menu.title ||
                                            isButtonHovered
                                        ? widget.textColor
                                        : widget.textColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
