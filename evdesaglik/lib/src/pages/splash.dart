import 'package:flutter/material.dart';
import '../functions/functions.dart';
import '../utils/global.dart';
import '../utils/colors.dart';
import '../models/user.dart';
import 'onBoarding.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen();

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  checkAuthenticationData() async {
    await Future.delayed(Duration(milliseconds: 777));
    bool isAuthenticated = await Functions.checkUserAuthentication();
    if (isAuthenticated) {
      UserModel? user = await Functions.getCurrentUser();
      if (user != null)
        goPage(
            page: HomeScreen(homeUser: user),
            removeUntil: true,
            context: context);
      else
        goPage(
            page: const OnBoardingScreen(),
            removeUntil: true,
            context: context);
    } else
      goPage(
          page: const OnBoardingScreen(), removeUntil: true, context: context);
  }

  @override
  void initState() {
    checkAuthenticationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Material(
      child: Container(
          color: AppColors.backgroundColor,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text('Evde Sağlık Mobil Uygulama',
                style: const TextStyle(
                    color: AppColors.shadowColor,
                    fontFamily: 'extra',
                    fontSize: 22)),
            const SizedBox(height: 16),
            Container(
                height: 75.111,
                width: 75.111,
                decoration: const BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15.111)),
                ),
                child: ClipRRect(
                    borderRadius:
                        const BorderRadius.all(Radius.circular(15.111)),
                    child: Image.asset('assets/img/app_logo.png',
                        height: 75.111, width: 75.111))),
            const SizedBox(height: 16),
            const Text('Evde Sağlık Hizmetleri',
                style: const TextStyle(
                    color: AppColors.grayColor,
                    fontFamily: 'medium',
                    fontSize: 15)),
            const SizedBox(height: 2),
            const Text('Mobil Uygulama Platformu',
                style: const TextStyle(
                    color: AppColors.grayColor,
                    fontFamily: 'medium',
                    fontSize: 15))
          ])));
}
