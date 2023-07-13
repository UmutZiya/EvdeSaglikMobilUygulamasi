import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../utils/global.dart';
import '../../utils/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Profil Bilgileri',
              style: TextStyle(
                  color: AppColors.whiteColor,
                  fontFamily: 'semi',
                  fontSize: 16)),
          backgroundColor: AppColors.secondaryColor,
          leading: IconButton(
            icon:
                Icon(Icons.arrow_back_ios_rounded, color: AppColors.whiteColor),
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
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data!.data() != null)
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Ad Soyad:',
                                style: TextStyle(
                                  color: AppColors.shadowColor,
                                  fontFamily: 'bold',
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '${snapshot.data!.data()!['nameSurname']}',
                                style: TextStyle(
                                  color: AppColors.shadowColor,
                                  fontFamily: 'medium',
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Kayıt Tarihi:',
                                      style: TextStyle(
                                          color: AppColors.shadowColor,
                                          fontFamily: 'bold',
                                          fontSize: 16)),
                                  Text(
                                      '${DateFormat('dd.MM.yyyy kk:mm').format(DateTime.fromMillisecondsSinceEpoch(snapshot.data!.data()!['created']))}',
                                      style: TextStyle(
                                          color: AppColors.shadowColor,
                                          fontFamily: 'medium',
                                          fontSize: 14))
                                ])),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Phone:',
                                style: TextStyle(
                                  color: AppColors.shadowColor,
                                  fontFamily: 'bold',
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '${snapshot.data!.data()!['phone']}',
                                style: TextStyle(
                                  color: AppColors.shadowColor,
                                  fontFamily: 'medium',
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Uid:',
                                style: TextStyle(
                                  color: AppColors.shadowColor,
                                  fontFamily: 'bold',
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '${snapshot.data!.data()!['uid']}',
                                style: TextStyle(
                                  color: AppColors.shadowColor,
                                  fontFamily: 'medium',
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  else
                    return const SizedBox();
                }),
          ),
        ),
      );
}
