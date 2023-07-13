import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../elements/app_button.dart';
import '../../functions/functions.dart';
import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../utils/global.dart';

class HealthScreen extends StatefulWidget {
  const HealthScreen({super.key});

  @override
  State<HealthScreen> createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  final TextEditingController pressureController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController sugarController = TextEditingController();
  final TextEditingController fireController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  bool loading = false;

  getData() async {
    await FirebaseFirestore.instance
        .collection('patient_data')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.exists && value.data() != null) {
        ageController.text = value.data()!['age'];
        heightController.text = value.data()!['height'];
        weightController.text = value.data()!['weight'];
        fireController.text = value.data()!['fire'];
        pressureController.text = value.data()!['pressure'];
        sugarController.text = value.data()!['sugar'];
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('Sağlık Durumum',
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Yaş
                    // Boy
                    // Kilo
                    // Ateş Derecesi
                    // Tansiyon
                    // Şeker Derecesi
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Yaş',
                                  style: TextStyle(
                                      color: AppColors.shadowColor,
                                      fontFamily: 'bold',
                                      fontSize: 16)),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Container(
                                  height: 48,
                                  child: TextField(
                                    cursorColor: AppColors.primaryColor,
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontFamily: 'bold',
                                        fontSize: 15),
                                    controller: ageController,
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
                              ),
                            ])),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Boy',
                                  style: TextStyle(
                                      color: AppColors.shadowColor,
                                      fontFamily: 'bold',
                                      fontSize: 16)),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Container(
                                  height: 48,
                                  child: TextField(
                                    cursorColor: AppColors.primaryColor,
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontFamily: 'bold',
                                        fontSize: 15),
                                    controller: heightController,
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
                              ),
                            ])),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Kilo',
                                  style: TextStyle(
                                      color: AppColors.shadowColor,
                                      fontFamily: 'bold',
                                      fontSize: 16)),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Container(
                                  height: 48,
                                  child: TextField(
                                    cursorColor: AppColors.primaryColor,
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontFamily: 'bold',
                                        fontSize: 15),
                                    controller: weightController,
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
                              ),
                            ])),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Ateş',
                                  style: TextStyle(
                                      color: AppColors.shadowColor,
                                      fontFamily: 'bold',
                                      fontSize: 16)),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Container(
                                  height: 48,
                                  child: TextField(
                                    cursorColor: AppColors.primaryColor,
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontFamily: 'bold',
                                        fontSize: 15),
                                    controller: fireController,
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
                              ),
                            ])),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tansiyon',
                                  style: TextStyle(
                                      color: AppColors.shadowColor,
                                      fontFamily: 'bold',
                                      fontSize: 16)),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Container(
                                  height: 48,
                                  child: TextField(
                                    cursorColor: AppColors.primaryColor,
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontFamily: 'bold',
                                        fontSize: 15),
                                    controller: pressureController,
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
                              ),
                            ])),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Şeker',
                                  style: TextStyle(
                                      color: AppColors.shadowColor,
                                      fontFamily: 'bold',
                                      fontSize: 16)),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Container(
                                  height: 48,
                                  child: TextField(
                                    cursorColor: AppColors.primaryColor,
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontFamily: 'bold',
                                        fontSize: 15),
                                    controller: sugarController,
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
                              ),
                            ])),
                    const SizedBox(height: 32),
                    button(
                      loading: loading,
                      title: 'Güncelle',
                      onTap: () async {
                        loading = true;
                        setState(() {});
                        await Functions.updateData(
                            ageController.text,
                            heightController.text,
                            weightController.text,
                            fireController.text,
                            pressureController.text,
                            sugarController.text);
                        loading = false;
                        setState(() {});
                      },
                    ),
                  ]))));
}
