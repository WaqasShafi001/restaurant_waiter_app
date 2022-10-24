import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/flow/menu/models/socialLinksModel.dart';
import 'package:restaurant_app/utils/apiUrls.dart';
import 'package:restaurant_app/utils/navigatorService.dart';
import 'package:restaurant_app/utils/snackBars.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SocialLinksController extends GetxController {
  @override
  void onInit() {
    getSocialLinks();
    super.onInit();
  }

  var dropdownvalue = 1.obs;

  var isLoading = true.obs;

  var socialList = <SocialData>[].obs;

  Future getSocialLinks() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var thisID = pref.getInt('venueID');
    print('this is ID $thisID');

    try {
      var response = await http.get(
        Uri.parse('$baseURL$socialURL/$thisID'),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        SocialLinksModel model = SocialLinksModel.fromJson(result);
        isLoading.value = false;
        socialList.value = model.data!;
        print('this is social links length =-=-=-=- ${model.data!.length}');
      } else {
        isLoading.value = false;

        errorSnackBar(
          context: NavigationService.navigatorKey.currentContext,
          title: 'Error',
          msg: 'Server is not responding',
        );
      }
    } catch (e) {
      isLoading.value = false;

      errorSnackBar(
        context: NavigationService.navigatorKey.currentContext,
        title: 'Error',
        msg: e.toString(),
      );
    }
  }
}
