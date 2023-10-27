import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Resources/Components/dialogs.dart';
import '../../../Resources/Components/texts.dart';
import '../../../Resources/Constants/global_variables.dart';
import '../../../Resources/Constants/responsive.dart';
import 'controller/gallery.provider.dart';
import 'model/galery.model.dart';

class GalleryListPage extends StatefulWidget {
  const GalleryListPage({super.key});

  @override
  State<GalleryListPage> createState() => _GalleryListPageState();
}

class _GalleryListPageState extends State<GalleryListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<GalleryProvider>().getOnline(value: 'none');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Selector<GalleryProvider, List<GalleryModel>>(
        selector: (_, provider) => provider.offlineData,
        builder: (__, offlineData, _) {
          return GridView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: offlineData.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Responsive.isMobile(context) ? 2 : 4),
              itemBuilder: (contxt, index) {
                return GaleryItemWidget(data: offlineData[index]);
              });
        });
  }
}

class GaleryItemWidget extends StatefulWidget {
  final GalleryModel data;
  const GaleryItemWidget({super.key, required this.data});

  @override
  State<GaleryItemWidget> createState() => _GaleryItemWidgetState();
}

class _GaleryItemWidgetState extends State<GaleryItemWidget> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Dialogs.showModal(
            child: Container(
          child: Column(
            children: [
              if (widget.data.image != null)
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
                    "${BaseUrl.ip}${widget.data.image!}",
                  ),
                ),
              if (widget.data.image == null)
                Image.asset(
                  "Assets/Images/logo.png",
                  fit: BoxFit.cover,
                )
            ],
          ),
        ));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(8),
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (widget.data.image != null)
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
                        "${BaseUrl.ip}${widget.data.image!}",
                      ),
                    ),
                  if (widget.data.image == null)
                    Image.asset(
                      "Assets/Images/logo.png",
                      fit: BoxFit.cover,
                    ),
                  AnimatedPositioned(
                    top: isHovered ? 0 : 400,
                    left: 0,
                    right: 0,
                    bottom: isHovered ? 0 : -400,
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeInOutBack,
                    child: Container(
                      decoration: BoxDecoration(
                          // color: AppColors.kPrimaryColor.withOpacity(0.85),
                          gradient: LinearGradient(
                        colors: [
                          AppColors.kPrimaryColor.withOpacity(1),
                          AppColors.kPrimaryColor.withOpacity(0.7),
                          AppColors.kTransparentColor,
                          AppColors.kTransparentColor,
                          AppColors.kTransparentColor,
                          AppColors.kTransparentColor,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      )),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidgets.textBold(
                                title: widget.data.title ?? '',
                                fontSize: 20,
                                textColor: AppColors.kWhiteColor),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
