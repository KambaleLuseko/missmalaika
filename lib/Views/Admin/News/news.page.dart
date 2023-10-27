import 'package:flutter/material.dart';
import 'controller/news.provider.dart';
import 'package:provider/provider.dart';
import 'news.list.dart';
import '../../../Resources/Components/button.dart';
import '../../../Resources/Components/dialogs.dart';
import '../../../Resources/Components/texts.dart';
import '../../../Resources/Constants/global_variables.dart';
import 'add_news.page.dart';
import '../../parent.page.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return ParentPage(
        listData: Column(
          children: [
            TextWidgets.textBold(
                title: 'Gérer les articles',
                fontSize: 18,
                textColor: AppColors.kBlackColor),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                    size: 180,
                    icon: Icons.add,
                    text: 'Ajouter un article',
                    backColor: AppColors.kPrimaryColor,
                    textColor: AppColors.kWhiteColor,
                    callback: () {
                      Dialogs.showModal(child: AddNewsPage());
                    }),
                IconButton(
                    onPressed: () {
                      context
                          .read<NewsProvider>()
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
            const Expanded(child: NewsListPage())
          ],
        ),
        callback: () {});
  }
}
