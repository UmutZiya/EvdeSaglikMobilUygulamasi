import '../pages/doctor/doctor_panel.dart';
import 'package:flutter/material.dart';
import '../functions/functions.dart';
import '../utils/colors.dart';
import '../utils/global.dart';
import '../models/user.dart';
import 'patient/patient_panel.dart';
import 'onBoarding.dart';

class HomeScreen extends StatefulWidget {
  final UserModel homeUser;

  const HomeScreen({required this.homeUser});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  initialize() async =>
      await Functions.initializeNotification(uid: widget.homeUser.uid!);

  signOut() async {
    bool signOut = await Functions.signOut();
    if (signOut)
      goPage(context: context, removeUntil: true, page: OnBoardingScreen());
    else
      showSnackBar(
          content: 'Bir hata oluştu. Daha sonra tekrar dene', context: context);
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
              onPressed: signOut,
              icon: Image.asset(
                  color: AppColors.whiteColor,
                  'assets/img/signout.png',
                  height: 24,
                  width: 24))
        ],
        centerTitle: true,
        title: Text(
            widget.homeUser.doctor == true ? 'Doktor Paneli' : 'Hasta Paneli',
            style: TextStyle(fontFamily: 'bold', fontSize: 15)),
      ),
      body: widget.homeUser.doctor == true
          ? doctorPanel(context)
          : patientPanel(context));
}
