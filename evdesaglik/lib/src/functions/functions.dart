import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/global.dart';
import '../models/user.dart';

class Functions {
  static Future deleteQuestion(String id) async {
    await FirebaseFirestore.instance.collection('questions').doc(id).delete();
  }

  static Future addAnswer(String id, String answer) async {
    await FirebaseFirestore.instance
        .collection('questions')
        .doc(id)
        .update({'answer': answer});
  }

  static Future addPrescription(
      {required String medical,
      required String user,
      required String care,
      required String time}) async {
    await FirebaseFirestore.instance
        .collection('prescriptions')
        .orderBy('id', descending: true)
        .get()
        .then((value) async {
      await FirebaseFirestore.instance
          .collection('prescriptions')
          .doc(
              value.docs.isEmpty ? '0' : '${value.docs.first.data()['id'] + 1}')
          .set({
        'id': value.docs.isEmpty ? 0 : value.docs.first.data()['id'] + 1,
        'medical': medical,
        'care': care,
        'time': time,
        'user': user,
      });
    });
  }

  static Future addCalendar(
      {required String date, required String user}) async {
    await FirebaseFirestore.instance
        .collection('calendar')
        .orderBy('id', descending: true)
        .get()
        .then((value) async {
      await FirebaseFirestore.instance
          .collection('calendar')
          .doc(
              value.docs.isEmpty ? '0' : '${value.docs.first.data()['id'] + 1}')
          .set({
        'id': value.docs.isEmpty ? 0 : value.docs.first.data()['id'] + 1,
        'date': date,
        'user': user,
      });
    });
  }

  static Future deletePrescriptions(String id) async {
    await FirebaseFirestore.instance
        .collection('prescriptions')
        .doc(id)
        .delete();
  }

  static Future closeQuestion() async {
    await FirebaseFirestore.instance
        .collection('questions')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .delete();
  }

  static Future updateData(String age, String height, String weight,
      String fire, String pressure, String sugar) async {
    await FirebaseFirestore.instance
        .collection('patient_data')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'pressure': pressure,
      'height': height,
      'weight': weight,
      'sugar': sugar,
      'fire': fire,
      'age': age
    });
  }

  static Future updatePatientData(String uid, String age, String height,
      String weight, String fire, String pressure, String sugar) async {
    await FirebaseFirestore.instance.collection('patient_data').doc(uid).set({
      'pressure': pressure,
      'height': height,
      'weight': weight,
      'sugar': sugar,
      'fire': fire,
      'age': age
    });
  }

  static Future sendQuestion(String question) async {
    await FirebaseFirestore.instance
        .collection('questions')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'user': FirebaseAuth.instance.currentUser!.uid,
      'time': DateTime.now().millisecondsSinceEpoch,
      'question': question,
      'answer': '',
    });

    await FirebaseFirestore.instance
        .collection('notifications')
        .orderBy('id', descending: true)
        .get()
        .then((value) async {
      await FirebaseFirestore.instance
          .collection('notifications')
          .doc(
              value.docs.isEmpty ? '0' : '${value.docs.first.data()['id'] + 1}')
          .set({
        'id': value.docs.isEmpty ? 0 : value.docs.first.data()['id'] + 1,
        'user': FirebaseAuth.instance.currentUser!.uid,
        'type': 'Talep'
      });
    });
  }

  static Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future initializeNotification({required String uid}) async {
    FirebaseMessaging.instance.subscribeToTopic('all');
    FlutterLocalNotificationsPlugin notificationPlugin =
        FlutterLocalNotificationsPlugin();
    var initSettings = InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings());
    notificationPlugin.initialize(initSettings);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    await FirebaseMessaging.instance.requestPermission(
        criticalAlert: false,
        announcement: false,
        provisional: false,
        carPlay: false,
        alert: true,
        badge: true,
        sound: true);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      notificationPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                  icon: '@mipmap/ic_launcher',
                  importance: Importance.max,
                  priority: Priority.high,
                  'evdesaglik',
                  'evdesaglik'),
              iOS: DarwinNotificationDetails()));
    });
  }

  static Future<UserModel?> phoneAuthentication(
      {required String actualCode,
      required String nameSurname,
      required String smsCode,
      required bool isDoctor}) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: phoneAuthActualCode, smsCode: smsCode);
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final DocumentSnapshot userProfile = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .get();
      if (userProfile.exists) {
        UserModel? returnUser = await getCurrentUser();
        return returnUser;
      } else {
        Map<String, dynamic> userMap = {
          'phone': userCredential.user?.phoneNumber.toString(),
          'created': DateTime.now().millisecondsSinceEpoch,
          'uid': userCredential.user?.uid,
          'nameSurname': nameSurname,
          'doctor': isDoctor,
        };
        DocumentReference reference = FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user?.uid);
        await FirebaseFirestore.instance.runTransaction((transaction) async {
          transaction.set(reference, userMap);
        });
        return UserModel.fromMap(userMap);
      }
    } catch (e) {
      print('//////////////////////////////////////////////////');
      print(e);
      return null;
    }
  }

  static Future phoneAuthenticationCodeCheck(
      {required String phoneNumber}) async {
    try {
      final PhoneCodeSent codeSent =
          (String verificationId, [int? forceResendingToken]) async {
        phoneAuthActualCode = verificationId;
      };
      final PhoneVerificationCompleted verificationCompleted =
          (AuthCredential auth) async {};
      FirebaseAuth.instance.verifyPhoneNumber(
          verificationFailed: (FirebaseAuthException exception) {},
          verificationCompleted: verificationCompleted,
          codeAutoRetrievalTimeout: (String value) {},
          timeout: const Duration(seconds: 60),
          phoneNumber: phoneNumber,
          codeSent: codeSent);
    } catch (e) {
      print('//////////////////////////////////////////////////');
      print(e);
    }
  }

  static Future<bool> checkUserAuthentication() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      return currentUser != null;
    } catch (e) {
      return false;
    }
  }

  static Future<UserModel?> getCurrentUser() async {
    try {
      DocumentSnapshot currentUser = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      UserModel user =
          UserModel.fromMap(currentUser.data() as Map<dynamic, dynamic>);
      return user;
    } catch (e) {
      return null;
    }
  }
}
