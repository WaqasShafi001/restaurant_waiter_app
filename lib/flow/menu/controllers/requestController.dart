import 'dart:convert';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/flow/menu/models/requestServiceModel.dart';
import 'package:restaurant_app/utils/apiUrls.dart';
import 'package:restaurant_app/utils/navigatorService.dart';
import 'package:restaurant_app/utils/snackBars.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestController extends GetxController {
  var isLoading = false.obs;

  List listofBoolRequests = [
    false,
    false,
    false,
  ].obs;

  var requestMessage = ''.obs;
  var tableNumber = 1.obs;
  var venueId = 1.obs;

  updateListofBoolRequests(int index) {
    for (var i = 0; i < listofBoolRequests.length; i++) {
      listofBoolRequests[i] = false;
    }
    listofBoolRequests[index] = true;
  }

  resetValues() {
    listofBoolRequests = [false, false, false].obs;
  }

  requestServiceApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tableNumber.value = prefs.getInt('TableNumber')!;
    if (tableNumber.value == null) tableNumber.value = 1;
    print('this is table nmbr -=- = ${tableNumber.value}');
    venueId.value = prefs.getInt('venueID')!;
    print('this is vanue ID -=- = ${venueId.value}');
    print('this is service that is requested -=-=-=- ${requestMessage.value}');

    try {
      isLoading.value = true;
      var response = await http.post(
        Uri.parse('$baseURL$requestServiceUrl'),
        body: {
          "venue_id": "${venueId.value}",
          "request_type": "${requestMessage.value}",
          "table_no": "${tableNumber.value}"
        },
      );
      var data = jsonDecode(response.body);

      RequestServiceModel model = RequestServiceModel.fromJson(data);

      if (response.statusCode == 200) {
        isLoading.value = false;
        successSnackBar(
          context: NavigationService.navigatorKey.currentContext,
          title: 'Success',
          msg: 'Request has been sent',
        );
        resetValues();
        print(model.messasge);
      } else if (response.statusCode == 500) {
        errorSnackBar(
          context: NavigationService.navigatorKey.currentContext,
          title: 'Error',
          msg: 'Request has not been sent',
        );
        resetValues();
      } else {
        errorSnackBar(
          context: NavigationService.navigatorKey.currentContext,
          title: 'Error',
          msg: 'Something went wrong',
        );
      }
    } catch (e) {
      errorSnackBar(
        context: NavigationService.navigatorKey.currentContext,
        title: 'Error',
        msg: e.toString(),
      );
      resetValues();
    }
  }
}
