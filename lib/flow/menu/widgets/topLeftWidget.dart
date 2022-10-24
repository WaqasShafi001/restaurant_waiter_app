// ignore_for_file: prefer_const_constructors

import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/main.dart';
import '../../../common/appColors.dart';
import '../../../utils/persistedClass.dart';
import '../../search/SearchScreen.dart';

class TopRightWidget extends StatelessWidget {
  final double? height;
  final double? width;
  const TopRightWidget({
    Key? key,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SharedPreferenceClass prefes = SharedPreferenceClass();

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
            width: width! * 0.23,
            height: height! * 0.046,
            decoration: BoxDecoration(
              color: Colors.grey.shade200.withOpacity(0.5),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      Get.to(SearchScreen());
                    },
                    child: Container(
                      height: height! * 0.032,
                      width: width! * 0.1,
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: Center(
                          child: Image.asset(
                        'assets/search.png',
                        height: height! * 0.02,
                        color: AppColors.pureWhiteColor,
                      )),
                    ),
                  ),
                ),
                FocusedMenuHolder(
                  menuWidth: MediaQuery.of(context).size.width * 0.25,
                  blurSize: .0,
                  menuItemExtent: 45,
                  menuBoxDecoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  duration: Duration(milliseconds: 100),
                  animateMenuItems: true,
                  blurBackgroundColor: Colors.black54,
                  openWithTap:
                      true, // Open Focused-Menu on Tap rather than Long Press
                  menuOffset:
                      10.0, // Offset value to show menuItem from the selected item
                  bottomOffsetHeight: 80.0,
                  menuItems: [
                    FocusedMenuItem(
                      title: Text("English"),
                      trailingIcon: Image.asset('assets/english.png'),
                      onPressed: () {
                        findLanguageController.isEnglish.value = true;
                        findLanguageController.isArabic.value = false;
                        findLanguageController.isTurkish.value = false;

                        context.setLocale(engLocale);
                        prefes.addLocale(en: 'en', dd: 'US');
                        Get.updateLocale(engLocale);
                      },
                    ),
                    FocusedMenuItem(
                      title: Text("العربية"),
                      trailingIcon: Image.asset('assets/arabic.png'),
                      onPressed: () {
                        findLanguageController.isEnglish.value = false;
                        findLanguageController.isArabic.value = true;
                        findLanguageController.isTurkish.value = false;
                        context.setLocale(arabLocale);
                        prefes.addLocale(en: 'ar', dd: 'IQ');
                        Get.updateLocale(arabLocale);
                      },
                    ),
                    FocusedMenuItem(
                      title: Text("Türkçe"),
                      trailingIcon: Image.asset('assets/turkishFlag.png'),
                      onPressed: () {
                        findLanguageController.isEnglish.value = false;
                        findLanguageController.isArabic.value = false;
                        findLanguageController.isTurkish.value = true;
                        context.setLocale(turkishLocale);
                        prefes.addLocale(en: 'tr', dd: 'TR');
                        Get.updateLocale(turkishLocale);
                      },
                    ),
                  ],
                  onPressed: () {},
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: Container(
                      height: height! * 0.032,
                      width: width! * 0.1,
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/globe.png',
                            height: height! * 0.02,
                            color: AppColors.pureWhiteColor,
                          ),
                          Icon(
                            Icons.expand_more,
                            color: AppColors.pureWhiteColor,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
