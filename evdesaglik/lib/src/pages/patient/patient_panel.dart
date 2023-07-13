import 'package:flutter/material.dart';
import '../../elements/menu.dart';
import 'prescriptions.dart';
import 'profile.dart';
import 'doctor.dart';
import 'health.dart';

Widget importSettings()=> Container();

Widget patientPanel(BuildContext context) => Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    child: Column(children: [
      const SizedBox(height: 16),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        menuItem(context,
            menuName: 'Kişisel Bilgiler', page: ProfileScreen(), image: 'user'),
        menuItem(context,
            page: PrescriptionsScreen(),
            menuName: 'Reçeteler',
            image: 'medical7')
      ]),
      const SizedBox(height: 16),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        menuItem(context,
            menuName: 'Sağlık Durumum',
            page: HealthScreen(),
            image: 'medical1'),
        menuItem(context,
            page: PatientDoctorScreen(),
            menuName: 'Doktora Ulaş',
            image: 'medical6')
      ])
    ]));
