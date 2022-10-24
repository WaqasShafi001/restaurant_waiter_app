import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/common/appColors.dart';
import 'package:restaurant_app/flow/mainScreen/feedback/feedbackModel.dart';
import 'package:restaurant_app/utils/apiUrls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedbackController extends GetxController {
  List listofBoolServiceEfficency = [
    false,
    false,
    false,
  ].obs;

  var serviceEfficencyRating = 0.obs;
  var cleanlinessRating = 0.0.obs;
  var overallImpressionRating = 0.0.obs;

  var visitAgain = 0.obs;
  var yesButtonClicked = false.obs;
  var noButtonClicked = false.obs;

  TextEditingController commentController = TextEditingController(text: '');
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');

  var showFullPageDialog = false.obs;

  updateListofBoolTasteOfFood(int index) {
    for (var i = 0; i < listofBoolServiceEfficency.length; i++) {
      listofBoolServiceEfficency[i] = false;
    }
    listofBoolServiceEfficency[index] = true;
  }

  resetValues() {
    listofBoolServiceEfficency = [false, false, false].obs;
    commentController.text = '';
    nameController.text = '';
    emailController.text = '';
    serviceEfficencyRating.value = 0;
    cleanlinessRating.value = 0;
    overallImpressionRating.value = 0;
  }

  Future submitFeedback() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var thisID = pref.getInt('venueID');
    try {
      var response = await http.post(
        Uri.parse('$baseURL$feedbackUrl/$thisID'),
        body: {
          "name": "${nameController.text}",
          "email": "${emailController.text}",
          "comment": "${commentController.text}",
          "visit_again": "${visitAgain.value}",
          "service_efficiency": "${serviceEfficencyRating.value}",
          "cleanliness": "${cleanlinessRating.value}",
          "overall_impression": "${overallImpressionRating.value}",
        },
      );

      var data = jsonDecode(response.body);
      FeedbackModel model = FeedbackModel.fromJson(data);
      log(' data is -=- $data  and model is -=- $model');

      if (model.status == 200) {
        resetValues();
        Get.snackbar(
          'Success',
          '${model.message}',
          backgroundColor: AppColors.mainColor.withOpacity(0.5),
          colorText: AppColors.pureWhiteColor,
        );
      } else {
        Get.snackbar(
          'Failure',
          'Feedback not submitted',
          backgroundColor: AppColors.mainColor.withOpacity(0.5),
          colorText: AppColors.pureWhiteColor,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error!',
        e.toString(),
        backgroundColor: AppColors.mainColor.withOpacity(0.5),
        colorText: AppColors.pureWhiteColor,
      );
    }
  }


}
