import 'package:flutter/material.dart';
import '../elements/app_button.dart';
import '../utils/colors.dart';
import '../utils/global.dart';
import 'phone_verify.dart';

class PhoneAuthScreen extends StatefulWidget {
  final bool isDoctor;

  const PhoneAuthScreen({required this.isDoctor});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final TextEditingController phoneNumberController = TextEditingController();

  checkPhoneNumber() {
    if (phoneNumberController.text.replaceAll(' ', '').length != 10)
      showSnackBar(content: 'Telefon numaranı kontrol et.', context: context);
    else {
      String phone =
          '+90' + phoneNumberController.text.toString().replaceAll(' ', '');
      goPage(
          page: PhoneVerificationScreen(
              isDoctor: widget.isDoctor, phoneNumber: phone),
          context: context);
    }
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
                              width: MediaQuery.of(context).size.width / 2),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(widget.isDoctor ? 'Doktor' : 'Hasta',
                                    style: const TextStyle(
                                        color: AppColors.whiteColor,
                                        fontFamily: 'extra',
                                        letterSpacing: 1,
                                        fontSize: 24)),
                                const SizedBox(height: 2),
                                Text('telefon girişi',
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
                        'assets/img/phone.png'),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.75,
                        width: MediaQuery.of(context).size.width,
                        color: AppColors.backgroundColor,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        height: 42,
                                        width: 64,
                                        decoration: const BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(4)),
                                            color: AppColors.primaryColor),
                                        child: const Center(
                                            child: const Text('+90',
                                                style: const TextStyle(
                                                    color: AppColors.whiteColor,
                                                    fontFamily: 'bold',
                                                    fontSize: 14)))),
                                    const SizedBox(width: 6),
                                    Container(
                                        width: MediaQuery.of(context).size.width -
                                            118,
                                        height: 42,
                                        child: TextField(
                                            cursorColor: AppColors.primaryColor,
                                            keyboardType: TextInputType.number,
                                            controller: phoneNumberController,
                                            style: const TextStyle(
                                                color: AppColors.shadowColor,
                                                fontFamily: 'bold',
                                                fontSize: 15),
                                            decoration: InputDecoration(
                                                hintText: '5554443322',
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
                                                    borderRadius: const BorderRadius.all(Radius.circular(6))))))
                                  ]),
                              const SizedBox(height: 12),
                              button(
                                  backgroundColor: AppColors.primaryColor,
                                  onTap: () => checkPhoneNumber(),
                                  title: 'Kod Gönder')
                            ]))
                  ])))));
}
