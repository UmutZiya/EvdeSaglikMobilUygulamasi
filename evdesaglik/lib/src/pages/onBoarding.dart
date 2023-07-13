import 'package:flutter/material.dart';
import '../utils/global.dart';
import '../utils/colors.dart';
import 'phone_auth.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen();

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: kToolbarHeight),
          physics: const BouncingScrollPhysics(),
          child: Column(children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.65,
                width: MediaQuery.of(context).size.width,
                child: Column(children: [
                  const SizedBox(height: kToolbarHeight + 12),
                  const Text('Evde Sağlık Mobil Uygulama',
                      style: const TextStyle(
                          color: AppColors.shadowColor,
                          fontFamily: 'extra',
                          letterSpacing: 1.11,
                          fontSize: 18.75)),
                  const SizedBox(height: 16),
                  Container(
                      height: MediaQuery.of(context).size.width / 1.75,
                      width: MediaQuery.of(context).size.width / 1.75,
                      child: Image.asset('assets/img/logo.png')),
                  Padding(
                      padding: const EdgeInsets.only(left: 48, right: 48),
                      child: const Text(
                          'Evde Sağlık, doktorların hastalarını rahat bir şekilde takip edip hastaları için gereken güncellemeleri online şekilde yapmalarına olanak sağlar.',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: AppColors.grayColor,
                              fontFamily: 'medium',
                              letterSpacing: 0.111,
                              fontSize: 12.75,
                              height: 1.2)))
                ])),
            Container(
                width: MediaQuery.of(context).size.width - 48,
                margin: const EdgeInsets.only(top: 52),
                height: 48,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.shadowColor.withOpacity(.05),
                        blurRadius: 12)
                  ],
                ),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shadowColor: MaterialStateProperty.resolveWith(
                            (states) => AppColors.shadowColor.withOpacity(.05)),
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => AppColors.whiteColor),
                        overlayColor: MaterialStateProperty.resolveWith(
                            (states) =>
                                AppColors.primaryColor.withOpacity(0.1))),
                    onPressed: () => goPage(
                        page: const PhoneAuthScreen(isDoctor: true),
                        context: context),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset('assets/img/medical6.png',
                              color: AppColors.primaryColor.withOpacity(.75),
                              height: 48 * 0.43 * (25 / 31) + 2,
                              width: 48 * 0.43 * (25 / 31) + 2),
                          const Text('Doktor Girişi',
                              style: const TextStyle(
                                  color: AppColors.shadowColor,
                                  fontFamily: 'bold',
                                  fontSize: 15)),
                          const SizedBox(width: 28)
                        ]))),
            Container(
                width: MediaQuery.of(context).size.width - 48,
                margin: const EdgeInsets.only(top: 12),
                height: 48,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.shadowColor.withOpacity(.05),
                        blurRadius: 12)
                  ],
                ),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shadowColor: MaterialStateProperty.resolveWith(
                            (states) => AppColors.shadowColor.withOpacity(.05)),
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => AppColors.whiteColor),
                        overlayColor: MaterialStateProperty.resolveWith(
                            (states) =>
                                AppColors.primaryColor.withOpacity(0.1))),
                    onPressed: () => goPage(
                        page: const PhoneAuthScreen(isDoctor: false),
                        context: context),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset('assets/img/user.png',
                              color: AppColors.primaryColor.withOpacity(.75),
                              height: 48 * 0.43 * (25 / 31) + 2,
                              width: 48 * 0.43 * (25 / 31) + 2),
                          const Text('Hasta Girişi',
                              style: const TextStyle(
                                  color: AppColors.shadowColor,
                                  fontFamily: 'bold',
                                  fontSize: 15)),
                          const SizedBox(width: 28)
                        ]))),
            Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 36, right: 36, top: 36),
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: 'Bu uygulamaya kayıt olarak ',
                        style: TextStyle(
                            color: AppColors.shadowColor.withOpacity(.75),
                            fontFamily: 'medium',
                            fontSize: 11,
                            height: 1.2),
                        children: <TextSpan>[
                          const TextSpan(
                              text: 'kullanım şartları',
                              style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: AppColors.shadowColor,
                                  fontFamily: 'bold',
                                  fontSize: 11)),
                          TextSpan(
                              text: ' ve ',
                              style: TextStyle(
                                  color: AppColors.shadowColor.withOpacity(.75),
                                  fontFamily: 'medium',
                                  fontSize: 11)),
                          const TextSpan(
                              text: 'gizlilik politikasını',
                              style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: AppColors.shadowColor,
                                  fontFamily: 'bold',
                                  fontSize: 11)),
                          TextSpan(
                              text: ' kabul etmiş olursun.',
                              style: TextStyle(
                                  color: AppColors.shadowColor.withOpacity(.75),
                                  fontFamily: 'medium',
                                  fontSize: 11))
                        ])))
          ])));
}
