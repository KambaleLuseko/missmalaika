import 'package:missmalaika/Resources/Constants/responsive.dart';

import 'Admin/admin.main.page.dart';

import '../Resources/Components/applogo.dart';
import '../Resources/Components/button.dart';
import '../Resources/Components/text_fields.dart';
import '../Resources/Components/texts.dart';
import '../Resources/Constants/global_variables.dart';
import '../Resources/Models/Menu/menu.model.dart';
import '../Resources/Providers/menu_provider.dart';
import '../Resources/Providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final TextEditingController _usernameCtrller = TextEditingController();
  final TextEditingController _pwdCtrller = TextEditingController();
  bool stayConnected = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
        child: Center(
          child: Container(
            width: Responsive.isMobile(context)
                ? MediaQuery.of(context).size.width - 48
                : MediaQuery.of(context).size.width / 3,
            decoration: BoxDecoration(
                color: AppColors.kWhiteColor.withOpacity(0.7),
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const Spacer(),
                const AppLogo(
                  size: Size(120, 120),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextWidgets.text300(
                    textColor: AppColors.kBlackColor,
                    fontSize: 14,
                    title: "Login now to continue"),
                const SizedBox(
                  height: 20,
                ),
                TextFormFieldWidget(
                    hintText: "Username",
                    textColor: AppColors.kBlackColor,
                    backColor: AppColors.kTextFormBackColor,
                    // icon: Icons.person,
                    inputType: TextInputType.text,
                    isEnabled: true,
                    editCtrller: _usernameCtrller),
                TextFormFieldWidget(
                    maxLines: 1,
                    hintText: "Password",
                    textColor: AppColors.kBlackColor,
                    backColor: AppColors.kTextFormBackColor,
                    inputType: TextInputType.text,
                    isObsCured: true,
                    isEnabled: true,
                    editCtrller: _pwdCtrller),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                    canSync: true,
                    backColor: AppColors.kBlackColor,
                    textColor: AppColors.kWhiteColor,
                    text: 'Login',
                    callback: () {
                      context.read<UserProvider>().login(
                          data: {
                            "username": _usernameCtrller.text.toString().trim(),
                            "password": _pwdCtrller.text.toString().trim(),
                          },
                          callback: () {
                            context
                                .read<MenuProvider>()
                                .initMenu(isAdmin: true);
                            // Navigator.pop(context);
                            context.read<MenuProvider>().setActivePage(
                                newPage: MenuModel(
                                    title: 'Dashboard',
                                    page: const AdminMainPage()));
                            // Navigation.pushNavigate(page: const MatchPage());
                          });
                    }),
                // const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
