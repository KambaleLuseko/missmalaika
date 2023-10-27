import 'Admin/News/controller/news.provider.dart';

import '../Resources/Components/applogo.dart';

import '../Resources/Components/texts.dart';
import '../Resources/Constants/responsive.dart';
import '../Resources/Models/Menu/menu.model.dart';
import '../Resources/Providers/users_provider.dart';
import 'menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Resources/Constants/global_variables.dart';
import '../../Resources/Providers/menu_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    _scrollCtrller = ScrollController();
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _scrollCtrller.addListener(() {
        if (_scrollCtrller.offset >= 10) {
          startedScroll = true;
        } else {
          startedScroll = false;
        }
        setState(() {});
      });
      context.read<MenuProvider>().initMenu();
      context.read<UserProvider>().getUserData();
      context.read<NewsProvider>().getOnline(value: 'latest', isRefresh: true);
      // context.read<AchievementProvider>().getOnline();
      // context.read<AchievementProvider>().getOnlineMedia();
    });
  }

  bool startedScroll = false;
  late ScrollController _scrollCtrller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: AppColors.kWhiteColor,
        //   title: Text(
        //     context.watch<MenuProvider>().activePage.title,
        //     style: TextStyle(color: AppColors.kBlackColor),
        //   ),
        //   leading: IconButton(
        //       onPressed: () {
        //         isMenuVisible = !isMenuVisible;
        //         setState(() {});
        //       },
        //       icon: Icon(isMenuVisible == false ? Icons.menu : Icons.close,
        //           color: AppColors.kBlackColor)),
        // ),
        drawer: !Responsive.isWeb(context)
            ? const Drawer(
                child: MenuWidget(),
              )
            : null,
        backgroundColor: AppColors.kScaffoldColor,
        // bottomNavigationBar:
        //     !Responsive.isWeb(context) ? const BottomNavBar() : null,
        body: Stack(
          children: [
            Column(
              // controller: _scrollCtrller,
              // physics: const BouncingScrollPhysics(),
              // shrinkWrap: true,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Expanded(
                    child: context.select<MenuProvider, Widget>(
                        (provider) => provider.activePage.page)),
              ],
            ),
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!Responsive.isMobile(context))
                      Container(
                        height: 100,
                        padding: const EdgeInsets.all(32),
                        decoration:
                            BoxDecoration(color: AppColors.kTransparentColor),
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const AppLogo(size: Size(64, 64)),
                              TextWidgets.textBold(
                                  title: 'MISS MALAIKA',
                                  fontSize: 32,
                                  textColor: AppColors.kBlackColor)
                            ]),
                      ),
                    Flexible(
                      child: AnimatedContainer(
                        height: 100,
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeInOut,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                            color: startedScroll == true
                                ? AppColors.kSecondaryColor
                                : AppColors.kTransparentColor),
                        child: Container(
                          height: 80,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: AppColors.kSecondaryColor.withOpacity(0)),
                          child: SingleChildScrollView(
                            controller: ScrollController(),
                            scrollDirection: Axis.horizontal,
                            child: Selector<MenuProvider, List<MenuModel>>(
                                builder: (_, menus, __) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ...List.generate(
                                          menus.length,
                                          (index) => GestureDetector(
                                                onTap: () {
                                                  context
                                                      .read<MenuProvider>()
                                                      .setActivePage(
                                                          newPage:
                                                              menus[index]);
                                                  startedScroll = false;
                                                  setState(() {});
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 16,
                                                      vertical: 5),
                                                  child: TextWidgets.textNormal(
                                                      title: menus[index].title,
                                                      fontSize: 16,
                                                      textColor: menus[index]
                                                                  .title ==
                                                              context
                                                                  .watch<
                                                                      MenuProvider>()
                                                                  .activePage
                                                                  .title
                                                          ? AppColors
                                                              .kPrimaryColor
                                                          : AppColors
                                                              .kBlackColor),
                                                ),
                                              )),
                                      if (context
                                              .watch<UserProvider>()
                                              .connectedUser !=
                                          null)
                                        GestureDetector(
                                          onTap: () {
                                            context
                                                .read<UserProvider>()
                                                .logOut();
                                            startedScroll = false;
                                            setState(() {});
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 5),
                                            child: TextWidgets.textNormal(
                                                title: "Deconnexion",
                                                fontSize: 16,
                                                textColor:
                                                    AppColors.kBlackColor),
                                          ),
                                        )
                                    ],
                                  );
                                },
                                selector: (_, provider) => provider.menus),
                          ),
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ));
  }
}
