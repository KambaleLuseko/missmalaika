import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Resources/Components/button.dart';
import '../../../Resources/Components/dialogs.dart';
import '../../../Resources/Components/shimmer_placeholder.dart';
import '../../../Resources/Components/texts.dart';
import '../../../Resources/Constants/global_variables.dart';
import '../../../Resources/Constants/responsive.dart';
import '../../../Resources/Models/partner.model.dart';
import '../../../Resources/Providers/app_state_provider.dart';
import '../../../Resources/Providers/candidates.provider.dart';
import '../../../Resources/Providers/users_provider.dart';
import '../widgets/candidate_vote.widget.dart';

class CandidateListWidget extends StatelessWidget {
  const CandidateListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<CandidateProvider, List<CandidateModel>>(
        selector: (_, provider) => provider.offlineData,
        builder: (__, offlineData, _) {
          return offlineData.isEmpty &&
                  context.watch<AppStateProvider>().isAsync == true
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListItemPlaceholder();
                  })
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: Responsive.isMobile(context) ? 2 : 4,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: offlineData.length,
                  itemBuilder: (context, index) {
                    return CandidateItemList(
                      data: offlineData[index],
                    );
                  });
        });
  }
}

class CandidateItemList extends StatefulWidget {
  final CandidateModel data;
  const CandidateItemList({super.key, required this.data});

  @override
  State<CandidateItemList> createState() => _CandidateItemListState();
}

class _CandidateItemListState extends State<CandidateItemList> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(8),
      child: MouseRegion(
        onExit: (event) {
          setState(() {
            isHovered = false;
          });
        },
        onEnter: (event) {
          setState(() {
            isHovered = true;
          });
        },
        onHover: (event) {
          setState(() {
            isHovered = true;
          });
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            // widget.data.imageUrl != null
            //     ? FadeInImage(
            //         fit: BoxFit.cover,
            //         fadeInCurve: Curves.easeInOut,
            //         fadeOutCurve: Curves.easeOutCubic,
            //         fadeInDuration: const Duration(milliseconds: 500),
            //         fadeOutDuration: const Duration(milliseconds: 500),
            //         alignment: Alignment.center,
            //         placeholder: const AssetImage(
            //           "Assets/Images/logo.png",
            //         ),
            //         image:
            //             NetworkImage("${BaseUrl.ip}${widget.data.imageUrl!}"),
            //       )
            //     : Image.asset(
            //         "Assets/Images/logo.png",
            //         fit: BoxFit.cover,
            //       ),
            if (widget.data.imageUrl != null)
              FadeInImage(
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "Assets/Images/logo.png",
                    fit: BoxFit.cover,
                  );
                },
                fit: BoxFit.cover,
                placeholder: const AssetImage(
                  "Assets/Images/logo.png",
                ),
                image: NetworkImage(
                  "${BaseUrl.ip}${widget.data.imageUrl!}",
                ),
              ),

            if (widget.data.imageUrl == null)
              Image.asset(
                "Assets/Images/logo.png",
                fit: BoxFit.cover,
              ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOutCubic,
                opacity: isHovered == true ? 1 : 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  // width: double.maxFinite,
                  // height: double.maxFinite,
                  decoration: BoxDecoration(
                      color: isHovered == true
                          ? AppColors.kPrimaryColor.withOpacity(0.85)
                          : AppColors.kTransparentColor),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidgets.textBold(
                          title: widget.data.fullname ?? '',
                          fontSize: 20,
                          textColor: AppColors.kWhiteColor),
                      const SizedBox(
                        height: 8,
                      ),
                      TextWidgets.textBold(
                          title: widget.data.uuid ?? '',
                          fontSize: 24,
                          textColor: AppColors.kWhiteColor),
                      const SizedBox(
                        height: 16,
                      ),
                      TextWidgets.text300(
                          title: widget.data.event?.first.eventName ?? '',
                          fontSize: 14,
                          textColor: AppColors.kWhiteColor),
                      TextWidgets.textBold(
                          title: widget.data.address ?? '',
                          fontSize: 14,
                          textColor: AppColors.kWhiteColor),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomButton(
                          size: 120,
                          text: 'Je vote',
                          backColor: AppColors.kWhiteColor,
                          textColor: AppColors.kPrimaryColor,
                          callback: () {
                            context.read<UserProvider>().candidate =
                                widget.data;
                            Dialogs.showDialogWithActionCustomContent(
                                title: "Voter la candidate",
                                content:
                                    VoteCandidateWidget(data: widget.data));
                          })
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
