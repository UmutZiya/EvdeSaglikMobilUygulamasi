import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../utils/colors.dart';
import '../../utils/global.dart';
import 'patient_detail.dart';

class PatientsScreen extends StatefulWidget {
  const PatientsScreen({super.key});

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('Hastalar',
            style: TextStyle(
                color: AppColors.whiteColor, fontFamily: 'semi', fontSize: 16)),
        backgroundColor: AppColors.primaryColor,
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
                      .collection('users')
                      .where('doctor', isEqualTo: false)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data != null &&
                        snapshot.data!.docs.length != 0)
                      return Column(children: [
                        ListView.builder(
                          padding: const EdgeInsets.only(bottom: 156, top: 32),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          addAutomaticKeepAlives: false,
                          addRepaintBoundaries: false,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () => goPage(
                                context: context,
                                page: PatientDetailScreen(
                                    patientData: snapshot.data!.docs
                                        .elementAt(index)
                                        .data())),
                            child: Container(
                              margin: const EdgeInsets.only(
                                  bottom: 16, right: 16, left: 16),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  color: AppColors.whiteColor,
                                  boxShadow: [
                                    BoxShadow(
                                        color: AppColors.shadowColor
                                            .withOpacity(.15),
                                        blurRadius: 12)
                                  ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          snapshot.data!.docs
                                              .elementAt(index)
                                              .data()['nameSurname'],
                                          style: TextStyle(
                                              color: AppColors.primaryColor,
                                              fontFamily: 'semi',
                                              fontSize: 16)),
                                      Text(
                                          '${DateFormat('dd.MM.yyyy kk:ss').format(DateTime.fromMillisecondsSinceEpoch(snapshot.data!.docs.elementAt(index).data()['created']))}',
                                          style: TextStyle(
                                              color: AppColors.shadowColor,
                                              fontFamily: 'semi',
                                              fontSize: 12)),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        snapshot.data!.docs
                                            .elementAt(index)
                                            .data()['phone'],
                                        style: TextStyle(
                                            color: AppColors.secondaryColor,
                                            fontFamily: 'medium',
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]);
                    else
                      return const SizedBox();
                  }))));
}
