import 'package:flutter/material.dart';
import 'package:missmalaika/Resources/Components/button.dart';
import 'package:missmalaika/Resources/Components/dialogs.dart';
import 'package:missmalaika/Resources/Components/texts.dart';
import 'package:missmalaika/Resources/Constants/global_variables.dart';
import 'package:missmalaika/Views/Admin/Events/controller/event.provider.dart';
import 'package:missmalaika/Views/Admin/Events/view/add_event.page.dart';
import 'package:missmalaika/Views/Admin/Events/view/event.list.dart';
import 'package:missmalaika/Views/parent.page.dart';
import 'package:provider/provider.dart';

class EventPage extends StatelessWidget {
  const EventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ParentPage(
        listData: Column(
          children: [
            TextWidgets.textBold(
                title: 'Gérer les événements',
                fontSize: 18,
                textColor: AppColors.kBlackColor),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                    size: 180,
                    icon: Icons.add,
                    text: 'Ajouter un événement',
                    backColor: AppColors.kPrimaryColor,
                    textColor: AppColors.kWhiteColor,
                    callback: () {
                      Dialogs.showModal(child: NewEventPage());
                    }),
                IconButton(
                    onPressed: () {
                      context
                          .read<EventProvider>()
                          .getOnline(value: 'all', isRefresh: true);
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
            const Expanded(child: EventListPage())
          ],
        ),
        callback: () {});
  }
}
