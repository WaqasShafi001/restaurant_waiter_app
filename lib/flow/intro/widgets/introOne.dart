// ignore_for_file: file_names, prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/appColors.dart';

class IntroOne extends StatelessWidget {
  const IntroOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Card(
              elevation: 3,
              color: AppColors.mainColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  side: BorderSide(
                    width: 5,
                    color: AppColors.mainColor,
                  )),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Image.asset(
                    'assets/s1.jpg',
                    scale: height / 400,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.05,
          ),
          Text(
            'horizontal_menu',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: height * 0.025,
            ),
          ).tr(),
          Text(
            'view_all_the_updated_menu_of_delicious_food',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: height * 0.02,
            ),
          ).tr(),
        ],
      ),
    );
  }
}
