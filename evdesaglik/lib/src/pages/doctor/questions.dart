import 'package:cloud_firestore/cloud_firestore.dart';
import '../../elements/app_button.dart';
import '../../functions/functions.dart';
import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../utils/global.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final TextEditingController answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sorular',
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
                  .collection('questions')
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
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 72,
                                    child: Text(
                                      'Soru: ${snapshot.data!.docs.elementAt(index).data()['question']}',
                                      maxLines: null,
                                      style: TextStyle(
                                        color: AppColors.whiteColor,
                                        fontFamily: 'semi',
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              snapshot.data!.docs
                                          .elementAt(index)
                                          .data()['answer'] !=
                                      ''
                                  ? Container(
                                      width: MediaQuery.of(context).size.width -
                                          72,
                                      child: Text(
                                        'Cevap: ${snapshot.data!.docs.elementAt(index).data()['answer']}',
                                        maxLines: null,
                                        style: TextStyle(
                                          color: AppColors.whiteColor,
                                          fontFamily: 'semi',
                                          fontSize: 15,
                                        ),
                                      ),
                                    )
                                  : button(
                                      backgroundColor: AppColors.primaryColor,
                                      title: 'Cevapla',
                                      onTap: () => showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16),
                                                      child: TextField(
                                                        cursorColor: AppColors
                                                            .primaryColor,
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .primaryColor,
                                                            fontFamily: 'bold',
                                                            fontSize: 15),
                                                        controller:
                                                            answerController,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText: 'Cevap',
                                                          hintStyle: TextStyle(
                                                            color: AppColors
                                                                .grayColor,
                                                            fontFamily:
                                                                'medium',
                                                            fontSize: 15,
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: AppColors
                                                                  .primaryColor,
                                                            ),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: AppColors
                                                                  .secondaryColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 12),
                                                    button(
                                                      onTap: () async {
                                                        await Functions.addAnswer(
                                                            snapshot.data!.docs
                                                                    .elementAt(
                                                                        index)[
                                                                'user'],
                                                            answerController
                                                                .text);
                                                        answerController
                                                            .clear();
                                                        setState(() {});
                                                        Navigator.pop(context);
                                                      },
                                                      title: 'Cevapla',
                                                    ),
                                                  ],
                                                ),
                                              )),
                                    ),
                              const SizedBox(height: 12),
                              button(
                                backgroundColor: AppColors.grayColor,
                                title: 'Sil',
                                onTap: () async {
                                  await Functions.deleteQuestion(snapshot
                                      .data!.docs
                                      .elementAt(index)['user']);
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
