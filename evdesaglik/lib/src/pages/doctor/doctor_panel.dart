import 'package:flutter/material.dart';
import '../../elements/menu.dart';
import 'notifications.dart';
import 'calendar.dart';
import 'patients.dart';
import 'process.dart';

Widget doctorPanel(BuildContext context) => Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    child: Column(children: [
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          menuItem(context,
              page: PatientsScreen(), menuName: 'Hastalar', image: 'friend'),
          menuItem(context,
              menuName: 'Etkinlik Takvimi',
              page: CalendarScreen(),
              image: 'calendar')
        ],
      ),
      const SizedBox(height: 16),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        menuItem(context,
            page: NotificationsScreen(),
            menuName: 'Bildirimler',
            image: 'notification'),
        menuItem(context,
            menuName: 'Hasta İşlemleri', page: ProcessScreen(), image: 'menu')
      ])
    ]));
