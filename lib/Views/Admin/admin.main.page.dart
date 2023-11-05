import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:missmalaika/Views/Admin/Events/event.page.dart';

import '../../Resources/Components/reusable.dart';
import '../../Resources/Constants/global_variables.dart';
import '../../Resources/Models/Menu/menu.model.dart';
import 'Dashoard/admin.dashboard.dart';
import 'Galery/galery.page.dart';
import 'News/news.page.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({super.key});

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  @override
  void initState() {
    activePage = pages[0];
    super.initState();
  }

  List<String> titles = ["Dashboard", "Articles", "Galerie", "Evénements"];
  List<MenuModel> pages = [
    MenuModel(
      title: 'Dashboard',
      page: const AdminDashboardPage(),
    ),
    MenuModel(
      title: 'Articles',
      page: const NewsPage(),
    ),
    MenuModel(
      title: 'Galerie',
      page: const GaleryPage(),
    ),
    MenuModel(
      title: 'Evénements',
      page: const EventPage(),
    ),
  ];
  handleMenuChange(value) {
    activePage = pages.firstWhereOrNull((element) =>
        element.title.toLowerCase() == value.toString().toLowerCase());
    setState(() {});
  }

  MenuModel? activePage;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabFilterWidget(
              mainSize: MainAxisSize.min,
              flexFit: FlexFit.loose,
              inactiveColor: AppColors.kBlackColor.withOpacity(0.7),
              backColor: AppColors.kTextFormBackColor,
              textColor: AppColors.kWhiteColor,
              callback: handleMenuChange,
              titles: titles),
        ),
        Flexible(child: activePage!.page)
      ],
    );
  }
}
