import 'package:flutter/material.dart';
import '../elements/app_button.dart';
import '../functions/functions.dart';
import '../models/user.dart';
import '../utils/colors.dart';
import '../utils/global.dart';
import 'dart:async';
import 'home.dart';

class PhoneVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final bool isDoctor;

  const PhoneVerificationScreen(
      {required this.phoneNumber, required this.isDoctor});

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final TextEditingController verificationNumberController =
      TextEditingController();
  final TextEditingController nameSurnameController = TextEditingController();
  bool loading = false;
  int time = 60;

  sendCode(String phone) async {
    try {
      await Functions.phoneAuthenticationCodeCheck(phoneNumber: phone);
    } catch (e) {
      print('//////////////////////////////////////////////////////');
      print(e);
    }
  }

  verification() async {
    try {
      UserModel? user = await Functions.phoneAuthentication(
          smsCode: verificationNumberController.text,
          nameSurname: nameSurnameController.text,
          actualCode: phoneAuthActualCode,
          isDoctor: widget.isDoctor);
      if (user != null)
        goPage(context: context, page: HomeScreen(homeUser: user));
      else
        showSnackBar(
            content: 'Bir hata oluştu. Lütfen tekrar dene.', context: context);
    } catch (e) {
      print('//////////////////////////////////////////////////////');
      print(e);
    }
  }

  @override
  void initState() {
    sendCode(widget.phoneNumber);
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        if (time - 1 < 0)
          time = -1;
        else
          time = time - 1;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: AppColors.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: AppColors.backgroundColor,
          child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(children: [
                    Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width,
                        color: AppColors.primaryColor,
                        child: Row(children: [
                          const SizedBox(width: 12),
                          Material(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              clipBehavior: Clip.hardEdge,
                              color: Colors.transparent,
                              child: IconButton(
                                  splashColor:
                                      AppColors.whiteColor.withOpacity(.25),
                                  highlightColor:
                                      AppColors.whiteColor.withOpacity(.25),
                                  onPressed: () =>
                                      goPage(context: context, back: true),
                                  icon:
                                      const Icon(Icons.arrow_back_ios_rounded),
                                  color: AppColors.whiteColor,
                                  iconSize: 24)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 2.25),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text('Doğrulama',
                                    style: const TextStyle(
                                        color: AppColors.whiteColor,
                                        fontFamily: 'extra',
                                        letterSpacing: 1,
                                        fontSize: 24)),
                                const SizedBox(height: 2),
                                Text('kodunu gir',
                                    style: TextStyle(
                                        color: AppColors.whiteColor
                                            .withOpacity(.75),
                                        fontFamily: 'medium',
                                        letterSpacing: 1,
                                        fontSize: 15))
                              ])
                        ])),
                    const SizedBox(height: 12),
                    Image.asset(
                        height: MediaQuery.of(context).size.width / 2,
                        width: MediaQuery.of(context).size.width / 2,
                        'assets/img/done.png'),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.75,
                        width: MediaQuery.of(context).size.width,
                        color: AppColors.backgroundColor,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: MediaQuery.of(context).size.width - 48,
                                  height: 42,
                                  child: TextField(
                                      cursorColor: AppColors.primaryColor,
                                      controller: nameSurnameController,
                                      style: const TextStyle(
                                          color: AppColors.shadowColor,
                                          fontFamily: 'bold',
                                          fontSize: 15),
                                      decoration: InputDecoration(
                                          hintText: 'Ad Soyad',
                                          hintStyle: TextStyle(
                                              color: AppColors.grayColor
                                                  .withOpacity(.75),
                                              fontFamily: 'medium',
                                              height: 3.175,
                                              fontSize: 15),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColors.shadowColor
                                                      .withOpacity(.5),
                                                  width: 1),
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(6))),
                                          focusedBorder: const OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: AppColors.primaryColor,
                                                  width: 1),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(6)))))),
                              const SizedBox(height: 12),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width - 48,
                                  height: 42,
                                  child: TextField(
                                      controller: verificationNumberController,
                                      cursorColor: AppColors.primaryColor,
                                      keyboardType: TextInputType.number,
                                      obscureText: true,
                                      style: const TextStyle(
                                          color: AppColors.shadowColor,
                                          fontFamily: 'bold',
                                          fontSize: 15),
                                      decoration: InputDecoration(
                                          hintText: '* * * * * *',
                                          hintStyle: TextStyle(
                                              color: AppColors.grayColor
                                                  .withOpacity(.75),
                                              fontFamily: 'medium',
                                              height: 3.175,
                                              fontSize: 15),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColors.shadowColor
                                                      .withOpacity(.5),
                                                  width: 1),
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(6))),
                                          focusedBorder: const OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: AppColors.primaryColor,
                                                  width: 1),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(6)))))),
                              const SizedBox(height: 12),
                              button(
                                  backgroundColor: AppColors.primaryColor,
                                  onTap: verification,
                                  title: 'Doğrula',
                                  loading: loading),
                              const SizedBox(height: 32),
                              time == -1
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                          const Text('Kod gelmedi mi? ',
                                              style: const TextStyle(
                                                  color: AppColors.shadowColor,
                                                  fontFamily: 'medium',
                                                  fontSize: 12)),
                                          InkWell(
                                              highlightColor:
                                                  Colors.transparent,
                                              splashColor: Colors.transparent,
                                              onTap: () {
                                                sendCode(widget.phoneNumber);
                                                time = 60;
                                                setState(() {});
                                              },
                                              child: const Text(
                                                  'Tekrar Gönder.',
                                                  style: const TextStyle(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontFamily: 'semi',
                                                      fontSize: 12))),
                                        ])
                                  : const SizedBox(),
                              const SizedBox(height: 16),
                              Text(
                                  time == -1
                                      ? 'Geçerlilik süresi bitti.'
                                      : '$time saniye',
                                  style: const TextStyle(
                                      color: AppColors.shadowColor,
                                      fontFamily: 'semi',
                                      fontSize: 15))
                            ]))
                  ])))));
}
