import 'package:flutter/material.dart';
import '../../../Resources/Components/button.dart';
import '../../../Resources/Components/dialogs.dart';
import '../../../Resources/Components/texts.dart';
import '../../../Resources/Constants/global_variables.dart';
import 'add_galery.page.dart';
import 'controller/gallery.provider.dart';
import 'gallery.list.dart';
import '../../parent.page.dart';
import 'package:provider/provider.dart';

class GaleryPage extends StatelessWidget {
  const GaleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ParentPage(
        listData: Column(
          children: [
            TextWidgets.textBold(
                title: 'Gérer la galerie',
                fontSize: 18,
                textColor: AppColors.kBlackColor),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                    size: 180,
                    icon: Icons.add,
                    text: 'Ajouter une image',
                    backColor: AppColors.kPrimaryColor,
                    textColor: AppColors.kWhiteColor,
                    callback: () {
                      Dialogs.showModal(child: const AddImageGaleryPage());
                    }),
                IconButton(
                    onPressed: () {
                      context
                          .read<GalleryProvider>()
                          .getOnline(value: 'none', isRefresh: true);
                    },
                    icon: Icon(
                      Icons.autorenew,
                      color: AppColors.kBlackColor,
                    ))
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            const GalleryListPage()
          ],
        ),
        callback: () {});
  }
}
