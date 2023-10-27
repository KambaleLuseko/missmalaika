import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Resources/Components/texts.dart';
import '../../Resources/Constants/global_variables.dart';
import '../../Resources/Models/Menu/menu.model.dart';
import '../../Resources/Providers/menu_provider.dart';
import '../admin.login.page.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterWidget extends StatelessWidget {
  FooterWidget({super.key});
  final List sponsors = ['ozzone.jpeg', 'ozzone-prod.png', 'agrorecolt.png'];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 100,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              decoration: BoxDecoration(color: AppColors.kSecondaryColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextWidgets.text500(
                      title: 'Sponsors',
                      fontSize: 24,
                      textColor: AppColors.kWhiteColor)
                ],
              ),
            ),
            Expanded(
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.kSecondaryColor.withOpacity(0.08),
                ),
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ...List.generate(
                            sponsors.length,
                            (index) => Container(
                                  margin: const EdgeInsets.all(8),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: AppColors.kWhiteColor,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(120),
                                      child: Image.asset(
                                          "Assets/Images/sponsors/${sponsors[index]}",
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ))
                      ],
                    )),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            socialItem(
                color: AppColors.kWhiteColor,
                backColor: AppColors.kRedColor,
                icon: FontAwesomeIcons.youtube,
                url: "https://www.youtube.com/@MissMalaikaRdc"),
            socialItem(
                color: AppColors.kWhiteColor,
                backColor: AppColors.kBlueColor,
                icon: FontAwesomeIcons.twitter,
                url: "https://twitter.com/MissMalaikaRDC"),
            socialItem(
                color: AppColors.kWhiteColor,
                backColor: AppColors.kBlueColor,
                icon: FontAwesomeIcons.facebookF,
                url:
                    "https://m.facebook.com/groups/missmalaika/permalink/648908160507603/"),
            socialItem(
                color: AppColors.kBlackColor,
                backColor: AppColors.kWhiteColor,
                icon: FontAwesomeIcons.instagram,
                url:
                    "https://m.facebook.com/groups/missmalaika/permalink/648908160507603/"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                TextWidgets.textNormal(
                    title:
                        "Copyright (c) ${DateTime.now().year}, tous droits résérvés",
                    fontSize: 14,
                    textColor: AppColors.kBlackColor),
                const SizedBox(
                  height: 8,
                ),
                TextWidgets.textNormal(
                    title: "Designed by Ir Providence Kambale Luseko",
                    fontSize: 12,
                    textColor: AppColors.kBlackColor),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    // Navigation.pushNavigate(page: const LoginPage());
                    context.read<MenuProvider>().setActivePage(
                        newPage: MenuModel(
                            title: "Connexion", page: const AdminLoginPage()));
                  },
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      child: TextWidgets.textNormal(
                          title: "Connexion",
                          fontSize: 12,
                          textColor: AppColors.kBlackColor)),
                )
              ],
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  socialItem(
      {required Color color,
      required Color backColor,
      required IconData icon,
      required String url}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          launchUrl(Uri.parse(url));
        },
        child: Card(
          color: backColor,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(64)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(child: Icon(icon, color: color, size: 20)),
          ),
        ),
      ),
    );
  }
}
