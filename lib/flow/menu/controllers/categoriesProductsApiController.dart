import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/flow/venuInfo/venuInfoScreen.dart';
import 'package:restaurant_app/utils/apiUrls.dart';
import 'package:restaurant_app/utils/navigatorService.dart';
import 'package:restaurant_app/utils/snackBars.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/CategoriesProductsApiModel.dart';

class CategoriesProductsApiController extends GetxController {
  var categoriesList = <Categories>[].obs;
  var isLoading = true.obs;

  var tableNumber = 1.obs;

  @override
  void onInit() {
    getAllCategories();
    // getTableNumber();
    super.onInit();
  }

  getTableNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tableNumber.value = prefs.getInt('TableNumber')??1;
    if (tableNumber.value == null) tableNumber.value = 1;
    print('this is table nmbr -=- = ${tableNumber.value}');
  }

  logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Get.offAll(VenuInfoScreen());
  }

  Future getAllCategories() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var thisID = pref.getInt('venueID');
    print('this is ID $thisID');
    try {
      var response = await http.get(
        Uri.parse('$baseURL$categoriesProductsUrl/$thisID'),
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        CategoriesProductsApiModel model =
            CategoriesProductsApiModel.fromJson(result);
        // if (model.success == 'true') {
        categoriesList.value = model.data!;
        print('this is length =-=-=-=- ${model.data!.length}');
        ;
        isLoading.value = false;
        // } else {
        //   Get.snackbar('Error', 'Opps! try again later');
        //   isLoading.value = false;
        // }

        log('${categoriesList}');
      } else {
        // Get.snackbar('Error', 'Opps! Something went wrong');
        errorSnackBar(
          context: NavigationService.navigatorKey.currentContext,
          title: 'Error',
          msg: 'Opps! Something went wrong',
        );
      }
    } catch (e) {
      isLoading.value = false;
      errorSnackBar(
        context: NavigationService.navigatorKey.currentContext,
        title: 'Error',
        msg: e.toString(),
      );
      // Get.snackbar('Error', e.toString());

      Future.delayed(
        Duration(seconds: 10),
      ).then((value) {
        isLoading.value = true;
        getAllCategories();
      });
    }
  }
}
