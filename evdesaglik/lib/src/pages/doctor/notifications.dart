import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/global.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bildirimler',
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
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('notifications')
                      .orderBy('id', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data != null &&
                        snapshot.data!.docs.length != 0)
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: false,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Container(
                          margin: const EdgeInsets.only(
                              bottom: 16, right: 16, left: 16),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              color: AppColors.whiteColor,
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        AppColors.shadowColor.withOpacity(.15),
                                    blurRadius: 12)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(snapshot.data!.docs
                                        .elementAt(index)
                                        .data()['user'])
                                    .snapshots(),
                                builder: (context, user) {
                                  if (user.hasData &&
                                      user.data != null &&
                                      user.data!.data() != null)
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              user.data!.data()!['nameSurname'],
                                              style: TextStyle(
                                                color: AppColors.primaryColor,
                                                fontFamily: 'bold',
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              ' talep oluşturdu.',
                                              style: TextStyle(
                                                color: AppColors.shadowColor,
                                                fontFamily: 'semi',
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  else
                                    return const SizedBox();
                                }),
                          ),
                        ),
                      );
                    else
                      return const SizedBox();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
