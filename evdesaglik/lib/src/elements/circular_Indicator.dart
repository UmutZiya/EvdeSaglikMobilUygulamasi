import 'package:flutter/material.dart';
import '../utils/colors.dart';

Widget circularIndicator({double? width, double? size, Color? color}) =>
    SizedBox(
        height: size ?? 20,
        width: size ?? 20,
        child: CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(color ?? AppColors.whiteColor),
            strokeWidth: width ?? 2.5));
