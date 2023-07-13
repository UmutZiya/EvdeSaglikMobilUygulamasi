import 'package:flutter/material.dart';
import '../utils/global.dart';
import '../utils/colors.dart';

Widget menuItem(BuildContext context,
        {required String menuName,
        required String image,
        required Widget page}) =>
    InkWell(
        onTap: () => goPage(context: context, page: page),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Container(
            width: (MediaQuery.of(context).size.width - 48) / 2,
            height: (MediaQuery.of(context).size.width - 48) / 2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: AppColors.primaryColor),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                  color: AppColors.whiteColor,
                  'assets/img/$image.png',
                  height: 32,
                  width: 32),
              const SizedBox(height: 12),
              Text(menuName,
                  style: TextStyle(
                      color: AppColors.whiteColor,
                      fontFamily: 'semi',
                      fontSize: 16))
            ])));
