import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/flow/menu/models/menuProductModel.dart';
import 'package:restaurant_app/utils/apiUrls.dart';
import 'package:restaurant_app/utils/navigatorService.dart';
import 'package:restaurant_app/utils/snackBars.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuProductsController extends GetxController {
  var isLoading = false.obs;

  var listOfMenuProducts = <DataOfProduct>[].obs;

  getMenuProducts({String? menuType}) async {
    listOfMenuProducts.clear();
    isLoading.value = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    var thisID = pref.getInt('venueID');
    print('this is ID $thisID');
    try {
      var response = await http.post(
        Uri.parse('$baseURL$menuProductsUrl/$thisID'),
        body: {
          "menu_type": menuType,
        },
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        MenuProductModel model = MenuProductModel.fromJson(result);
        listOfMenuProducts.value = model.data!;
        isLoading.value = false;
      } else {
        isLoading.value = false;

        errorSnackBar(
            context: NavigationService.navigatorKey.currentContext,
            title: 'Error',
            msg: 'Data is not loaded');
      }
    } catch (e) {
      log(e.toString());
      isLoading.value = false;

      errorSnackBar(
          context: NavigationService.navigatorKey.currentContext,
          title: 'Error',
          msg: 'Server Issue');
    }
  }
}
