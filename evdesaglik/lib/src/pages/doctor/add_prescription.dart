import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evdesaglik/src/elements/app_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../functions/functions.dart';
import '../../utils/colors.dart';
import '../../utils/global.dart';

class AddPrescriptionScreen extends StatefulWidget {
  const AddPrescriptionScreen({super.key});

  @override
  State<AddPrescriptionScreen> createState() => _AddPrescriptionScreenState();
}

class _AddPrescriptionScreenState extends State<AddPrescriptionScreen> {
  final TextEditingController medicalController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController careController = TextEditingController();
  String selectedPatientName = '';
  String selectedPatientUid = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yeni Reçete',
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
          padding: const EdgeInsets.only(bottom: 156, top: 32),
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  cursorColor: AppColors.primaryColor,
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontFamily: 'bold',
                      fontSize: 15),
                  controller: medicalController,
                  decoration: InputDecoration(
                    hintText: 'İlaç',
                    hintStyle: TextStyle(
                      color: AppColors.grayColor,
                      fontFamily: 'medium',
                      fontSize: 15,
                    ),
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
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  cursorColor: AppColors.primaryColor,
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontFamily: 'bold',
                      fontSize: 15),
                  controller: timeController,
                  decoration: InputDecoration(
                    hintText: 'Sıklık',
                    hintStyle: TextStyle(
                      color: AppColors.grayColor,
                      fontFamily: 'medium',
                      fontSize: 15,
                    ),
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
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  cursorColor: AppColors.primaryColor,
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontFamily: 'bold',
                      fontSize: 15),
                  controller: careController,
                  decoration: InputDecoration(
                    hintText: 'Önem',
                    hintStyle: TextStyle(
                      color: AppColors.grayColor,
                      fontFamily: 'medium',
                      fontSize: 15,
                    ),
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
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () => showModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                          color: AppColors.whiteColor,
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .where('doctor', isEqualTo: false)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData &&
                                    snapshot.data != null &&
                                    snapshot.data!.docs.length != 0) {
                                  return SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    child: Column(children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ListView.builder(
                                          padding: const EdgeInsets.only(
                                              bottom: 156, top: 32),
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: snapshot.data!.docs.length,
                                          addAutomaticKeepAlives: false,
                                          addRepaintBoundaries: false,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) =>
                                              InkWell(
                                            highlightColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            onTap: () {
                                              selectedPatientName = snapshot
                                                  .data!.docs
                                                  .elementAt(index)
                                                  .data()['nameSurname'];
                                              selectedPatientUid = snapshot
                                                  .data!.docs
                                                  .elementAt(index)
                                                  .data()['uid'];
                                              setState(() {});
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 16,
                                                  right: 16,
                                                  left: 16),
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(12)),
                                                  color: AppColors.whiteColor,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: AppColors
                                                            .shadowColor
                                                            .withOpacity(.15),
                                                        blurRadius: 12)
                                                  ]),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          snapshot.data!.docs
                                                                  .elementAt(index)
                                                                  .data()[
                                                              'nameSurname'],
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .primaryColor,
                                                              fontFamily:
                                                                  'semi',
                                                              fontSize: 16)),
                                                      Text(
                                                          '${DateFormat('dd.MM.yyyy kk:ss').format(DateTime.fromMillisecondsSinceEpoch(snapshot.data!.docs.elementAt(index).data()['created']))}',
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .shadowColor,
                                                              fontFamily:
                                                                  'semi',
                                                              fontSize: 12)),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 12),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        snapshot.data!.docs
                                                            .elementAt(index)
                                                            .data()['phone'],
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .secondaryColor,
                                                            fontFamily:
                                                                'medium',
                                                            fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  );
                                } else
                                  return const SizedBox();
                              }),
                        )),
                child: Container(
                  width: MediaQuery.of(context).size.width - 32,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: AppColors.primaryColor,
                  ),
                  child: Center(
                    child: Text(
                      selectedPatientName == ''
                          ? 'Hasta Seç'
                          : selectedPatientName,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontFamily: 'bold',
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 48),
              button(
                onTap: () async {
                  await Functions.addPrescription(
                      medical: medicalController.text,
                      user: selectedPatientUid,
                      care: careController.text,
                      time: timeController.text);
                  goPage(context: context, back: true);
                },
                title: 'Oluştur',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
