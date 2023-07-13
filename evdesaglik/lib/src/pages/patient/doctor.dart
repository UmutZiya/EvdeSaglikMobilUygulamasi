import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evdesaglik/src/elements/app_button.dart';
import 'package:evdesaglik/src/functions/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../utils/global.dart';

class PatientDoctorScreen extends StatefulWidget {
  const PatientDoctorScreen({super.key});

  @override
  State<PatientDoctorScreen> createState() => _PatientDoctorScreenState();
}

class _PatientDoctorScreenState extends State<PatientDoctorScreen> {
  final TextEditingController questionController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('Doktora Ulaş',
            style: TextStyle(
                color: AppColors.whiteColor, fontFamily: 'semi', fontSize: 16)),
        backgroundColor: AppColors.secondaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: AppColors.whiteColor),
          onPressed: () => goPage(context: context, back: true),
        ),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 156, top: 16),
              physics: const BouncingScrollPhysics(),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('questions')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data != null &&
                        snapshot.data!.data() != null)
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Soru',
                                style: TextStyle(
                                  color: AppColors.shadowColor,
                                  fontFamily: 'bold',
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                snapshot.data!.data()!['question'],
                                style: TextStyle(
                                  color: AppColors.shadowColor,
                                  fontFamily: 'medium',
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                'Cevap',
                                style: TextStyle(
                                  color: AppColors.shadowColor,
                                  fontFamily: 'bold',
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                snapshot.data!.data()!['answer'] == ''
                                    ? 'Cevap Bekleniyor..'
                                    : snapshot.data!.data()!['answer'],
                                style: TextStyle(
                                  color: AppColors.shadowColor,
                                  fontFamily: 'medium',
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 24),
                              button(
                                  onTap: () async =>
                                      await Functions.closeQuestion(),
                                  title: 'Kapat',
                                  backgroundColor: AppColors.grayColor),
                              const SizedBox(height: 12),
                              button(
                                  onTap: () async =>
                                      await Functions.closeQuestion(),
                                  title: 'Yeni Bilet'),
                            ]),
                      );
                    else
                      return Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: TextField(
                            cursorColor: AppColors.primaryColor,
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontFamily: 'bold',
                                fontSize: 15),
                            controller: questionController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.secondaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        button(
                          title: 'Gönder',
                          loading: loading,
                          onTap: () async {
                            loading = true;
                            setState(() {});
                            await Functions.sendQuestion(
                                questionController.text);
                            loading = false;
                            setState(() {});
                          },
                        ),
                      ]);
                  }))));
}
