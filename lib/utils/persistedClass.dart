// ignore_for_file: file_names, unnecessary_string_interpolations

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceClass {
  Future addLocale({String? en, String? dd}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('en', '${en ?? 'en'}');
    prefs.setString('dd', '${dd ?? ' US'}');
  }


  
}
