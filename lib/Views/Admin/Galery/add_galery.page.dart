import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../Resources/Components/button.dart';
import '../../../Resources/Components/text_fields.dart';
import '../../../Resources/Components/texts.dart';
import '../../../Resources/Constants/enums.dart';
import '../../../Resources/Constants/global_variables.dart';
import 'controller/gallery.provider.dart';
import 'model/galery.model.dart';
import '../../parent.page.dart';
import 'package:provider/provider.dart';

class AddImageGaleryPage extends StatefulWidget {
  const AddImageGaleryPage({super.key});

  @override
  State<AddImageGaleryPage> createState() => _AddImageGaleryPageState();
}

class _AddImageGaleryPageState extends State<AddImageGaleryPage> {
  final TextEditingController _titleCtrller = TextEditingController();

  FilePickerResult? pickedFile;

  Uint8List? logoBase64;

  void chooseImage() async {
    pickedFile = await FilePicker.platform.pickFiles(
      withData: true,
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ["png", "jpeg", "jpg", "bmp"],
    );
    if (pickedFile != null) {
      try {
        setState(() {
          logoBase64 = pickedFile!.files.first.bytes;
        });
      } catch (err) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return ParentPage(
        listData: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(mainAxisSize: MainAxisSize.min, children: [
                TextWidgets.textBold(
                    title: 'Ajouter une image dans la galerie',
                    fontSize: 20,
                    textColor: AppColors.kBlackColor),
                const SizedBox(
                  height: 16,
                ),
                TextWidgets.text300(
                    title: 'Tous les champs marqués (*) sont obligatoires',
                    fontSize: 14,
                    textColor: AppColors.kRedColor),
                const SizedBox(
                  height: 16,
                ),
                Flexible(
                  child: TextFormFieldWidget(
                    charType: TextCapitalization.sentences,
                    editCtrller: _titleCtrller,
                    hintText: 'Ecrivez le titre ici',
                    textColor: AppColors.kBlackColor,
                    backColor: AppColors.kTextFormBackColor,
                    label: 'Titre (*)',
                  ),
                ),
              ]),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidgets.text300(
                      title: 'Image',
                      fontSize: 14,
                      textColor: AppColors.kBlackColor),
                  const SizedBox(
                    width: 24,
                  ),
                  if (logoBase64 == null)
                    GestureDetector(
                        onTap: () {
                          chooseImage();
                        },
                        child: Icon(
                          Icons.cloud_upload_rounded,
                          size: 48,
                          color: AppColors.kBlackColor,
                        )),
                  if (logoBase64 != null)
                    Flexible(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: GestureDetector(
                        onTap: chooseImage,
                        child: Image.memory(
                          logoBase64!,
                          width: 124,
                          height: 124,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ))
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              CustomButton(
                  text: 'Enregistrer',
                  backColor: AppColors.kPrimaryColor,
                  textColor: AppColors.kWhiteColor,
                  callback: () {
                    if (_titleCtrller.text.trim().isEmpty ||
                        logoBase64 == null) {
                      ToastNotification.showToast(
                          msg: "Veuillez remplir tous les champs requis",
                          msgType: MessageType.error,
                          title: 'Valeurs invalides');
                      return;
                    }
                    GalleryModel data = GalleryModel()
                      ..title = _titleCtrller.text.trim()
                      ..imageBytes =
                          logoBase64 != null ? base64Encode(logoBase64!) : '';
                    context.read<GalleryProvider>().save(
                        data: data,
                        callback: () {
                          (Navigator.pop(context));
                        });
                  })
            ],
          ),
        ),
        callback: () {});
  }
}
