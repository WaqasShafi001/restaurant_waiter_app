// ignore_for_file: file_names, prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/appColors.dart';

class IntroThree extends StatefulWidget {
  const IntroThree({Key? key}) : super(key: key);

  @override
  State<IntroThree> createState() => _IntroThreeState();
}

class _IntroThreeState extends State<IntroThree> {
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
                    'assets/s3.jpg',
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
            'feedback',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: height * 0.025,
            ),
          ).tr(),
          Text(
            'give_your_valuable_feedback_to_us',
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
