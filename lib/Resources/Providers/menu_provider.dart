import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:missmalaika/Views/Admin/admin.main.page.dart';
import 'package:provider/provider.dart';

import '../../Resources/Models/Menu/menu.model.dart';
import '../../Views/Admin/Dashoard/candidate.dashboard.dart';
import '../../Views/Admin/Galery/gallery.list.dart';
import '../../Views/Admin/News/client_news.page.dart';
import '../../Views/Candidates/view/candidate.page.dart';
import '../../Views/Home/home.page.dart';
import '../../Views/Login/login.page.dart';
import '../../Views/about.page.dart';
import '../../Views/contact.page.dart';
import '../../main.dart';
import 'users_provider.dart';

class MenuProvider extends ChangeNotifier {
  List<MenuModel> menus = [
    // MenuModel(
    //     title: "Réalisations",
    //     page: const AchievementsPage(),
    //     icon: Icons.local_play_rounded),
    // MenuModel(
    //     title: "Medias",
    //     page: const MediaListPage(),
    //     icon: Icons.play_circle_fill_rounded),
    // MenuModel(
    //     title: "Qui sommes-nous?", page: const AboutPage(), icon: Icons.help),

    // MenuModel(
    //     title: "Transaction",
    //     page: const PaymentPage(),
    //     icon: FontAwesomeIcons.handHoldingUsd),
    // MenuModel(
    //     title: "Factures",
    //     page: const BillsPage(),
    //     icon: FontAwesomeIcons.moneyBill),
    // MenuModel(
    //     title: "Transactions",
    //     page: const TransactionPage(),
    //     icon: FontAwesomeIcons.handHoldingUsd),
    // MenuModel(
    //     title: "Cards",
    //     page: const PaymentMethodePage(),
    //     icon: FontAwesomeIcons.wallet),
    // MenuModel(
    //     title: "Profil",
    //     page: const ProfilePage(),
    //     icon: FontAwesomeIcons.user),
    // MenuModel(
    //     title: "Developer",
    //     page: const HomePage(),
    //     icon: Icons.developer_mode_rounded),
  ];

  initMenu({bool? isAdmin = false}) {
    if (isAdmin == true) {
      menus.add(
        MenuModel(
            title: "Admin",
            page: const AdminMainPage(),
            icon: FontAwesomeIcons.home),
      );
      return;
    }
    menus.clear();
    menus.addAll([
      MenuModel(
          title: "Accueil",
          page: const HomePage(),
          icon: FontAwesomeIcons.home),
      MenuModel(
          title: "Candidates", page: const CandidatePage(), icon: Icons.person),
      MenuModel(
          title: "News", page: const ClientNewsListPage(), icon: Icons.person),
      MenuModel(
          title: "Medias", page: const GalleryListPage(), icon: Icons.person),
      MenuModel(title: "Connexion", page: const LoginPage(), icon: Icons.login),
    ]);
    if (prefs.getString('candidate') != null) {
      menus
          .removeWhere((element) => element.title.toLowerCase() == 'connexion');
      menus.add(
          MenuModel(title: 'Dashboard', page: const CandidateDashboardPage()));
    }
    menus.addAll([
      MenuModel(
          title: "Nous contacter",
          page: const ContactPage(),
          icon: Icons.support_agent_rounded),
      MenuModel(
          title: "A propos", page: const AboutPage(), icon: Icons.info_rounded),
    ]);
    notifyListeners();
  }

  MenuModel activePage = MenuModel(
      title: "Accueil", page: const HomePage(), icon: FontAwesomeIcons.home);
  reset() {
    activePage = MenuModel(
        title: "Accueil", page: const HomePage(), icon: FontAwesomeIcons.home);
    initMenu();
  }

  getActivePage() => activePage;

  setActivePage({required MenuModel newPage}) {
    activePage = newPage;
    if (navKey.currentContext!.read<UserProvider>().connectedUser != null) {
      menus
          .removeWhere((element) => element.title.toLowerCase() == 'connexion');
    }
    notifyListeners();
  }

  bool isMenuVisible = false;
  changeMenuState() {
    isMenuVisible = !isMenuVisible;
    notifyListeners();
  }
}
