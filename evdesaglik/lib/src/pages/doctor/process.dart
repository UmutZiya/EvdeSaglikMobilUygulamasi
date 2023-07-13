import 'package:cloud_firestore/cloud_firestore.dart';
import '../../elements/app_button.dart';
import '../../functions/functions.dart';
import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../utils/global.dart';
import 'add_prescription.dart';
import 'questions.dart';

class ProcessScreen extends StatefulWidget {
  const ProcessScreen({super.key});

  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            goPage(context: context, page: AddPrescriptionScreen()),
        backgroundColor: AppColors.primaryColor,
        mini: false,
        child: Icon(
          Icons.add_rounded,
          color: AppColors.whiteColor,
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => goPage(context: context, page: QuestionScreen()),
              icon:
                  Icon(color: AppColors.whiteColor, Icons.help_center_rounded))
        ],
        title: Text('Reçete Oluştur',
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
                  .collection('prescriptions')
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
                          margin: const EdgeInsets.only(
                              bottom: 16, right: 16, left: 16),
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
                              const SizedBox(height: 32),
                              button(
                                backgroundColor: AppColors.grayColor,
                                title: 'Sil',
                                onTap: () async {
                                  await Functions.deletePrescriptions(snapshot
                                      .data!.docs
                                      .elementAt(index)['id']
                                      .toString());
                                },
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
}
