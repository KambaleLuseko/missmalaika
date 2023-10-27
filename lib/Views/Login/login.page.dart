import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Resources/Components/applogo.dart';
import '../../Resources/Components/button.dart';
import '../../Resources/Components/text_fields.dart';
import '../../Resources/Components/texts.dart';
import '../../Resources/Constants/enums.dart';
import '../../Resources/Constants/global_variables.dart';
import '../../Resources/Constants/responsive.dart';
import '../../Resources/Models/Menu/menu.model.dart';
import '../../Resources/Providers/menu_provider.dart';
import '../../Resources/Providers/users_provider.dart';
import '../Admin/Dashoard/candidate.dashboard.dart';
import 'onboard.widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameCtrller = TextEditingController(),
      _pwdCtrller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          if (!Responsive.isMobile(context))
            const Expanded(child: OnboardingPage()),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: Responsive.isWeb(context) ? 0 : 40),
              // color: AppColors.kAccentColor,
              width: double.maxFinite,
              height: double.maxFinite,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width:
                            Responsive.isWeb(context) ? 400 : double.maxFinite,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const AppLogo(size: Size(150, 150)),
                            const SizedBox(
                              height: 24,
                            ),
                            Container(
                              margin: const EdgeInsets.all(16),
                              child: TextWidgets.textBold(
                                  title: 'Miss Malaika',
                                  fontSize: 40,
                                  textColor: AppColors.kPrimaryColor),
                            ),
                            Container(
                              margin: const EdgeInsets.all(8),
                              child: TextWidgets.text300(
                                  title: 'Connectez-vous pour continuer',
                                  fontSize: 16,
                                  textColor: AppColors.kBlackColor),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 0),
                              child: TextFormFieldWidget(
                                  // hasMargin: false,
                                  maxLines: 1,
                                  editCtrller: _usernameCtrller,
                                  inputType: TextInputType.emailAddress,
                                  charType: TextCapitalization.none,
                                  hintText: "Username",
                                  textColor: AppColors.kBlackColor,
                                  backColor: AppColors.kTextFormBackColor),
                            ),
                            Container(
                                margin: const EdgeInsets.only(left: 0, top: 0),
                                child: TextFormFieldWidget(
                                  // hasMargin: false,
                                  editCtrller: _pwdCtrller,
                                  charType: TextCapitalization.none,
                                  hintText: "Mot de passe",
                                  textColor: AppColors.kBlackColor,
                                  backColor: AppColors.kTextFormBackColor,
                                  isObsCured: true,
                                  maxLines: 1,
                                )),
                            // InkWell(
                            //   onTap: () {
                            //     Navigation.pushNavigate(
                            //         page: const ForgotPasswordPage());
                            //   },
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(8.0),
                            //     child: Align(
                            //       alignment: Alignment.centerRight,
                            //       child: RichText(
                            //           textAlign: TextAlign.right,
                            //           text: TextSpan(children: [
                            //             TextSpan(
                            //                 text:
                            //                     "Réinitialiser le mot de passe",
                            //                 style: TextStyle(
                            //                     color: AppColors.kBlackColor
                            //                         .withOpacity(0.6),
                            //                     fontSize: 13,
                            //                     decoration:
                            //                         TextDecoration.underline,
                            //                     fontWeight: FontWeight.w300)),
                            //           ])),
                            //     ),
                            //   ),
                            // ),
                            const SizedBox(
                              height: 48,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: CustomButton(
                                  canSync: true,
                                  // size: 160,
                                  text: 'Je me connecte',
                                  backColor: AppColors.kPrimaryColor,
                                  // secondBackColor:
                                  //     AppColors.kAccentColor.withOpacity(0.7),
                                  textColor: AppColors.kWhiteColor,
                                  callback: () {
                                    if (_usernameCtrller.text.isEmpty ||
                                        _pwdCtrller.text.isEmpty) {
                                      return ToastNotification.showToast(
                                          msg:
                                              'Veuillez renseigner un username et un mot de passe',
                                          msgType: MessageType.error,
                                          title: 'Erreur');
                                    }

                                    context.read<UserProvider>().fetchCandidate(
                                        data: {
                                          "username":
                                              _usernameCtrller.text.trim(),
                                          'password': _pwdCtrller.text.trim()
                                        },
                                        callback: () {
                                          context
                                              .read<MenuProvider>()
                                              .initMenu();
                                          context
                                              .read<MenuProvider>()
                                              .setActivePage(
                                                  newPage: MenuModel(
                                                      title: 'Dashboard',
                                                      page:
                                                          const CandidateDashboardPage()));
                                          // Navigation.pushRemove(
                                          //     page: const MainPage());
                                        });
                                  }),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            // InkWell(
                            //   onTap: () {
                            //     // Navigation.pushNavigate(
                            //     //     page: const RegisterPage());
                            //   },
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(8.0),
                            //     child: RichText(
                            //         textAlign: TextAlign.left,
                            //         text: TextSpan(children: [
                            //           TextSpan(
                            //               text: "Pas de compte?",
                            //               style: TextStyle(
                            //                   color: AppColors.kBlackColor
                            //                       .withOpacity(0.6),
                            //                   fontSize: 16,
                            //                   fontWeight: FontWeight.w300)),
                            //           TextSpan(
                            //               text: " Créez-en un",
                            //               style: TextStyle(
                            //                   color: AppColors.kPrimaryColor,
                            //                   fontSize: 16,
                            //                   fontWeight: FontWeight.w500)),
                            //         ])),
                            //   ),
                            // ),
                            const SizedBox(
                              height: 64,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Positioned(
                  //   top: MediaQuery.of(context).size.height - 60,
                  //   bottom: 20,
                  //   left: 0,
                  //   right: 0,
                  //   child: Center(
                  //     child: TextWidgets.text300(
                  //         title: 'by DailyPay Corporate',
                  //         fontSize: 14,
                  //         textColor: AppColors.kWhiteColor.withOpacity(0.6)),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
