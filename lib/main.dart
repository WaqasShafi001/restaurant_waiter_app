// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/utils/NetworkBinding.dart';
import 'package:restaurant_app/utils/languageController.dart';
import 'package:restaurant_app/utils/navigatorService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/appColors.dart';
import 'flow/intro/IntroScreen.dart';

var engLocale = Locale('en', 'US');
var arabLocale = Locale('ar', 'IQ');
var turkishLocale = Locale('tr', 'TR');

var findLanguageController = Get.find<LangugeController>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: AppColors.mainColor,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: Colors.transparent,
  ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  SharedPreferences preferences = await SharedPreferences.getInstance();
  var putLanguageController = Get.put(LangugeController());
  var firstTimeLocale = preferences.getString('en');

  if (firstTimeLocale != null) {
    String? en = preferences.getString('en');
    String? dd = preferences.getString('dd');

    if (en == 'en' && dd == 'US') {
      putLanguageController.isEnglish.value = true;
      putLanguageController.isArabic.value = false;
      putLanguageController.isTurkish.value = false;
      log('is working engLocale? = = = ${putLanguageController.isEnglish.value}');
    } else if (en == 'ar' && dd == 'IQ') {
      putLanguageController.isEnglish.value = false;
      putLanguageController.isArabic.value = true;
      putLanguageController.isTurkish.value = false;
    } else {
      putLanguageController.isEnglish.value = false;
      putLanguageController.isArabic.value = false;
      putLanguageController.isTurkish.value = true;
      log('is working arabLocale? = = = ${putLanguageController.isTurkish.value}');
    }

    runApp(
      EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ar', 'IQ'),
          Locale('tr', 'TR')
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        child: MyApp(
          en: en,
          dd: dd,
        ),
      ),
    );
  } else {
    runApp(
      EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ar', 'IQ'),
          Locale('tr', 'TR')
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        child: MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  final String? en;
  final String? dd;
  const MyApp({Key? key, this.en = 'en', this.dd = 'US'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Restaurant App',
        debugShowCheckedModeBanner: false,
        initialBinding: NetworkBinding(),
        navigatorKey: NavigationService.navigatorKey,
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('ar', 'IQ'),
          const Locale('tr', 'TR')
        ],
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.yellowAccent,
        ),
        home: IntroScreen());
  }
}
