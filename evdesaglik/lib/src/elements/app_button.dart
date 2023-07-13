import 'package:flutter/material.dart';
import 'circular_Indicator.dart';
import '../utils/colors.dart';

Widget button(
        {required Function onTap,
        Color? backgroundColor,
        required String title,
        bool? loading}) =>
    Container(
        height: 48,
        margin: const EdgeInsets.only(
          right: 24,
          left: 24,
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: AppColors.shadowColor.withOpacity(.05), blurRadius: 12),
          ],
        ),
        child: ElevatedButton(
            onPressed: () => onTap(),
            style: ButtonStyle(
              shadowColor: MaterialStateProperty.resolveWith(
                  (states) => AppColors.shadowColor.withOpacity(.05)),
              backgroundColor: MaterialStateProperty.resolveWith(
                  (states) => backgroundColor ?? AppColors.secondaryColor),
              overlayColor: MaterialStateProperty.resolveWith(
                  (states) => AppColors.whiteColor.withOpacity(.25)),
            ),
            child: loading == true
                ? Center(child: circularIndicator())
                : Center(
                    child: Text(title,
                        style: const TextStyle(
                          color: AppColors.whiteColor,
                          fontFamily: 'bold',
                          fontSize: 15,
                        )))));
