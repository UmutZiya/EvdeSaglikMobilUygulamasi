import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/global.dart';

class PrescriptionsScreen extends StatefulWidget {
  const PrescriptionsScreen({super.key});

  @override
  State<PrescriptionsScreen> createState() => _PrescriptionsScreenState();
}

class _PrescriptionsScreenState extends State<PrescriptionsScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Reçeteler',
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
                    .collection('prescriptions')
                    .where('user',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data!.docs.length != 0)
                    return Column(
                      children: [
                        ListView.builder(
                          padding: const EdgeInsets.only(bottom: 156, top: 32),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          addAutomaticKeepAlives: false,
                          addRepaintBoundaries: false,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Container(
                            margin: const EdgeInsets.only(right: 16, left: 16),
                            width: MediaQuery.of(context).size.width - 32,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                color: AppColors.secondaryColor),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'No: ${snapshot.data!.docs.elementAt(index).data()['id'] + 1}',
                                      style: TextStyle(
                                        color: AppColors.whiteColor,
                                        fontFamily: 'semi',
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      'Seviye: ${snapshot.data!.docs.elementAt(index).data()['care']}',
                                      style: TextStyle(
                                        color: AppColors.whiteColor,
                                        fontFamily: 'semi',
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'İlaç: ${snapshot.data!.docs.elementAt(index).data()['medical']}',
                                      style: TextStyle(
                                        color: AppColors.whiteColor,
                                        fontFamily: 'semi',
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      'Sıklık: ${snapshot.data!.docs.elementAt(index).data()['time']}',
                                      style: TextStyle(
                                        color: AppColors.whiteColor,
                                        fontFamily: 'semi',
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
