import 'package:cloud_firestore/cloud_firestore.dart';
import '../../pages/doctor/new_calendar.dart';
import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../utils/global.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        mini: false,
        child: Icon(Icons.add_rounded),
        onPressed: () => goPage(context: context, page: NewCalendarScreen()),
      ),
      appBar: AppBar(
        title: Text('Etkinlik Takvimi',
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
          child: Column(
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('calendar')
                    .snapshots(),
                builder: (context, snapshot) => Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: snapshot.hasData &&
                          snapshot.data != null &&
                          snapshot.data!.docs.length != 0
                      ? ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          addAutomaticKeepAlives: false,
                          addRepaintBoundaries: false,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(snapshot.data!.docs
                                      .elementAt(index)
                                      .data()['user'])
                                  .snapshots(),
                              builder: (context, patient) {
                                if (patient.hasData &&
                                    patient.data != null &&
                                    patient.data!.data() != null) {
                                  return Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 16, right: 16, left: 16),
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        color: AppColors.whiteColor,
                                        boxShadow: [
                                          BoxShadow(
                                              color: AppColors.shadowColor
                                                  .withOpacity(.15),
                                              blurRadius: 12)
                                        ]),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                patient.data!
                                                    .data()!['nameSurname'],
                                                style: TextStyle(
                                                    color:
                                                        AppColors.primaryColor,
                                                    fontFamily: 'semi',
                                                    fontSize: 16)),
                                            Text(
                                                '${snapshot.data!.docs.elementAt(index).data()['date']}',
                                                style: TextStyle(
                                                    color:
                                                        AppColors.shadowColor,
                                                    fontFamily: 'semi',
                                                    fontSize: 12)),
                                          ],
                                        ),
                                        const SizedBox(height: 12),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              'id: ' +
                                                  snapshot.data!.docs
                                                      .elementAt(index)
                                                      .data()['user'],
                                              style: TextStyle(
                                                  color:
                                                      AppColors.secondaryColor,
                                                  fontFamily: 'medium',
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                        )
                      : Container(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
