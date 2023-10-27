import 'package:flutter/material.dart';

import '../../Resources/Components/texts.dart';
import '../../Resources/Constants/global_variables.dart';
import '../../Resources/Constants/responsive.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: Responsive.isWeb(context) ? 0 : 40),
        color: AppColors.kPrimaryColor.withOpacity(0.05),
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(8),
                // width: double.maxFinite,
                // height: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextWidgets.textBold(
                        title: "Miss Malaika",
                        fontSize: 24,
                        textColor: AppColors.kBlackColor),
                    Image.asset(
                      "Assets/Images/pictures/onboard.png",
                      fit: BoxFit.fitWidth,
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
