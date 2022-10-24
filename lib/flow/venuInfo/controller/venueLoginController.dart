import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/flow/mainScreen/mainScreen.dart';
import 'package:restaurant_app/flow/venuInfo/model/venueLoginModel.dart';
import 'package:restaurant_app/utils/apiUrls.dart';
import 'package:restaurant_app/utils/snackBars.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VenueLoginController extends GetxController {
  TextEditingController venueIdController = TextEditingController();
  TextEditingController veniPincodeController = TextEditingController();

  var isLoading = false.obs;
  var totalNumberOfTables = 1.obs;

  Future venueLogin(BuildContext context) async {
    try {
      isLoading.value = true;

      var response = await http.post(
        Uri.parse('$baseURL$venuUrl'),
        body: {
          "key": "${venueIdController.text}",
          "password": "${veniPincodeController.text}"
        },
      );
      var data = jsonDecode(response.body);

      VenueLoginModel model = VenueLoginModel.fromJson(data);
      if (model.status == 200) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setInt('venueID', model.venue!.id!);
        var venueID = pref.getInt('venueID');
        print('this is venue id -=-=- $venueID');
        totalNumberOfTables.value = model.venue!.totalTables!;
        pref.setInt('totalTables', totalNumberOfTables.value);

        isLoading.value = false;

        Get.offAll(
          MainScreen(
            totalTables: totalNumberOfTables.value,
          ),
        );
      } else if (model.status == 500) {
        isLoading.value = false;

        errorSnackBar(
          context: context,
          title: tr('error'),
          msg: tr('Invalid_Password'),
        );
      } else {
        isLoading.value = false;

        errorSnackBar(
          context: context,
          title: tr('error'),
          msg: tr("Something_went_wrong"),
        );
      }
    } catch (e) {
      isLoading.value = false;

      errorSnackBar(
        context: context,
        title: 'Opps',
        msg: e.toString(),
      );
    }
  }
}
