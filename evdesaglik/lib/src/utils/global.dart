import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'colors.dart';
import 'dart:io';

String phoneAuthActualCode = '';

// Page navigation.
goPage({
  required BuildContext context,
  bool? openFullScreen,
  bool? removeUntil,
  Widget? page,
  bool? back,
}) async {
  await Future.delayed(Duration(milliseconds: 199));
  if (back == null || back == false) if (removeUntil == false ||
      removeUntil == null)
    Navigator.of(
      context,
      rootNavigator: openFullScreen ?? false,
    ).push(
      Platform.isIOS
          ? CupertinoPageRoute(builder: (context) => page!)
          : FadeRoute(page: page!),
    );
  else
    Navigator.of(
      context,
      rootNavigator: openFullScreen ?? false,
    ).pushAndRemoveUntil(
        Platform.isIOS
            ? CupertinoPageRoute(builder: (context) => page!)
            : FadeRoute(page: page!),
        (route) => false);
  else
    Navigator.pop(context);
}

// Show warnings in all app.
showSnackBar({required String content, required BuildContext context}) =>
    Flushbar(
        padding:
            const EdgeInsets.only(left: 12, right: 12, top: 20, bottom: 20),
        animationDuration: const Duration(milliseconds: 555),
        duration: const Duration(milliseconds: 1311),
        flushbarPosition: FlushbarPosition.TOP,
        borderRadius: BorderRadius.circular(6),
        backgroundColor: AppColors.shadowColor,
        margin: const EdgeInsets.all(16),
        messageText: Text(content,
            style: const TextStyle(
                color: AppColors.whiteColor,
                letterSpacing: 0.25,
                fontFamily: 'semi',
                height: 1.25,
                fontSize: 15)))
      ..show(context);

// Page navigation fade animation.
class FadeRoute extends PageRouteBuilder {
  final Widget page;

  FadeRoute({required this.page})
      : super(
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) =>
                page,
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) =>
                FadeTransition(opacity: animation, child: child));
}
