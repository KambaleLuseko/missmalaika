import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:provider/provider.dart';

import '../../../Resources/Components/button.dart';
import '../../../Resources/Components/text_fields.dart';
import '../../../Resources/Components/texts.dart';
import '../../../Resources/Constants/enums.dart';
import '../../../Resources/Constants/global_variables.dart';
import '../../../Resources/Models/news.model.dart';
import '../../parent.page.dart';
import 'controller/news.provider.dart';

class AddNewsPage extends StatefulWidget {
  NewsModel? data;
  bool? updatingData;
  AddNewsPage({super.key, this.data, this.updatingData = false});

  @override
  State<AddNewsPage> createState() => _AddNewsPageState();
}

class _AddNewsPageState extends State<AddNewsPage> {
  final HtmlEditorController _contentCtrller = HtmlEditorController();
  final TextEditingController _titleCtrller = TextEditingController();
  final TextEditingController _summaryCtrller = TextEditingController();

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
      } catch (err) {
        print(err);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.updatingData == true && widget.data != null) {
        // print(widget.data?.content);
        // _contentCtrller.setText(widget.data?.content ?? '');
        _titleCtrller.text = widget.data?.title?.toString() ?? '';
        _summaryCtrller.text = widget.data?.summary?.toString() ?? '';
        setState(() {});
        Future.delayed(const Duration(seconds: 1), () {
          _contentCtrller.setText(widget.data?.content ?? '');
        });
      }
    });
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
                    title:
                        '${widget.updatingData == true ? "Modifier" : "Ajouter"} un article',
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
                Flexible(
                  child: TextFormFieldWidget(
                    charType: TextCapitalization.sentences,
                    editCtrller: _summaryCtrller,
                    hintText: 'Ecrivez le résumé ici',
                    textColor: AppColors.kBlackColor,
                    backColor: AppColors.kTextFormBackColor,
                    label: 'Résumé (*)',
                    maxLines: 5,
                  ),
                ),
              ]),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
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
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height / 3,
                    minHeight: 200),
                decoration: BoxDecoration(color: AppColors.kTextFormBackColor),
                // height: MediaQuery.of(context).size.height / 3,
                child: HtmlEditor(
                  controller: _contentCtrller,
                  htmlEditorOptions: const HtmlEditorOptions(
                      hint: 'Ecrivez le contenu ici (*)'),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              CustomButton(
                  canSync: true,
                  text:
                      widget.updatingData == true ? "Modifier" : "Enregistrer",
                  backColor: AppColors.kPrimaryColor,
                  textColor: AppColors.kWhiteColor,
                  callback: () async {
                    String content = await _contentCtrller.getText();
                    if (_titleCtrller.text.trim().isEmpty ||
                        _summaryCtrller.text.trim().isEmpty ||
                        content.trim().isEmpty) {
                      ToastNotification.showToast(
                          msg: "Veuillez remplir tous les champs requis",
                          msgType: MessageType.error,
                          title: 'Valeurs invalides');
                      return;
                    }
                    NewsModel data = NewsModel()
                      ..id = widget.data?.id
                      ..uuid = widget.data?.uuid
                      ..title = _titleCtrller.text.trim()
                      ..summary = _summaryCtrller.text.trim()
                      ..content = content
                      ..imageBytes =
                          logoBase64 != null ? base64Encode(logoBase64!) : '';
                    context.read<NewsProvider>().save(
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
