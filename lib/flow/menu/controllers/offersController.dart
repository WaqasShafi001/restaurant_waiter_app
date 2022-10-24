import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/utils/apiUrls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/offersModel.dart';

class OffersController extends GetxController {
  var offersList = <Offers>[].obs;
  var isLoading = true.obs;

  var tempChangeOffer= false.obs;

  @override
  void onInit() {
    getOffers();
    super.onInit();
  }

  Future getOffers() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var thisID = pref.getInt('venueID');
    print('this is ID $thisID');
    try {
      var response = await http.get(
        Uri.parse('$baseURL$offersUrl/$thisID'),
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        OffersModel model = OffersModel.fromJson(result);
        // if (model.success == 'true') {
        offersList.value = model.data!;
        print('offers length =-=-=-=- ${model.data!.length}');
        // model.data![0].image
        ;
        isLoading.value = false;
        // } else {
        //   Get.snackbar('Error', 'Opps! try again later');
        //   isLoading.value = false;
        // }

        log('${offersList}');
      } else {
        Get.snackbar('Error', 'Opps! Something went wrong');
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString());
    }
  }
}
