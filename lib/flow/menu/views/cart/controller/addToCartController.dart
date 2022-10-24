import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:restaurant_app/flow/menu/views/cart/model/addToCartModel.dart';
import 'package:restaurant_app/utils/apiUrls.dart';
import 'package:restaurant_app/utils/snackBars.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddToCartController extends GetxController {
  var isLoading = false.obs;
  var selectedExtrasById = [].obs;
  late Map<String, dynamic> body;

  var selectedExtras = <int>[].obs; //use this list

  selectedExtrasByIndex(int index) {
    if (selectedExtras.value.contains(index)) {
      selectedExtras.value.remove(index);
    } else {
      selectedExtras.value.add(index);
    }
  }

  getNewListOfExtrasById(List list) {
    selectedExtrasById.clear();
    for (var entry in list) {
      var val = entry + 1;
      selectedExtrasById.add(val);
    }

    print('${selectedExtrasById.toSet().toList()}');
  }

  addProductToCart({
    BuildContext? context,
    int? productId,
    int? quantity,
    int? price,
  }) async {
    isLoading.value = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    var thisID = pref.getInt('venueID');
    var tableNo = pref.getInt('TableNumber')!;
    if (tableNo == null) tableNo = 1;

    getNewListOfExtrasById(selectedExtras);
    // 'extras[]': newVal.replaceAll('"', '').trim(),
    log('check this   prod id = $productId, quantity = $quantity, price = $price, extras = ${selectedExtrasById.toSet().toList()}');

    String newVal = json.encode(selectedExtrasById
        .toSet()
        .toList()
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .trim());
    print('new val -== $newVal && ${newVal.replaceAll('"', '').trim()}');

    // for (var i in selectedExtrasById) log(i.toString());
    try {
      if (selectedExtrasById.length > 1) {
        // for (int i = 0; i < selectedExtrasById.length; i++) {
        //   body.addAll(
        //     {'extras[]': selectedExtrasById[i].toString()},
        //   );
        // }
        // body.addAll({
        //   'venue_id': '$thisID',
        //   'table_no': '$tableNo',
        //   'product_id': '$productId',
        //   'quantity': '$quantity',
        //   'price': '$price',
        // });
        Map<String, dynamic> mapp;
        for (var i = 0; i < selectedExtrasById.length; i++) {
          mapp = {
            'extras[]': selectedExtrasById[i],
          };
        }
        var response = await http.post(
          Uri.parse('$baseURL$submitCartApiUrl'),
          body: {
            'venue_id': '$thisID',
            'table_no': '$tableNo',
            'product_id': '$productId',
            'quantity': '$quantity',
            'price': '$price',
            for (int i = 0; i < selectedExtrasById.length; i++)
              'extras[]': selectedExtrasById[i].toString(),
          },
        );
        // log(response.body);
        var data = jsonDecode(response.body);

        AddToCartModel model = AddToCartModel.fromJson(data);

        if (response.statusCode == 200) {
          isLoading.value = false;

          log('success ${model.message}');
          // successSnackBar(
          //   context: context,
          //   title: 'Success',
          //   msg: model.message,
          // );
          selectedExtras.clear();
          selectedExtrasById.clear();
          Get.back();
          // Get.back();
        } else {
          log('fail ${response.statusCode}');
          isLoading.value = false;
          errorSnackBar(
            context: context,
            title: 'Error',
            msg: 'Product is not added',
          );
        }
      } else if (selectedExtrasById.isEmpty) {
        var response = await http.post(
          Uri.parse('$baseURL$submitCartApiUrl'),
          body: {
            'venue_id': '$thisID',
            'table_no': '$tableNo',
            'product_id': '$productId',
            'quantity': '$quantity',
            'price': '$price',
            // 'extras[]': newVal.replaceAll('"', '').trim(),
          },
        );
        // log(response.body);
        var data = jsonDecode(response.body);

        AddToCartModel model = AddToCartModel.fromJson(data);

        if (response.statusCode == 200) {
          isLoading.value = false;

          log('success ${model.message}');
          // successSnackBar(
          //   context: context,
          //   title: 'Success',
          //   msg: model.message,
          // );

          selectedExtras.clear();
          selectedExtrasById.clear();
          Get.back();
          // Get.back();
        } else {
          log('fail');
          isLoading.value = false;
          errorSnackBar(
            context: context,
            title: 'Error',
            msg: 'Product is not added',
          );
        }
      } else {
        var response = await http.post(
          Uri.parse('$baseURL$submitCartApiUrl'),
          body: {
            'venue_id': '$thisID',
            'table_no': '$tableNo',
            'product_id': '$productId',
            'quantity': '$quantity',
            'price': '$price',
            'extras[]': newVal.replaceAll('"', '').trim(),
          },
        );
        // log(response.body);
        var data = jsonDecode(response.body);

        AddToCartModel model = AddToCartModel.fromJson(data);

        if (response.statusCode == 200) {
          isLoading.value = false;

          log('success ${model.message}');
          // successSnackBar(
          //   context: context,
          //   title: 'Success',
          //   msg: model.message,
          // );

          selectedExtras.clear();
          selectedExtrasById.clear();
          Get.back();
          // Get.back();
        } else {
          log('fail');
          isLoading.value = false;
          errorSnackBar(
            context: context,
            title: 'Error',
            msg: 'Product is not added',
          );
        }
      }
    } catch (e) {
      isLoading.value = false;
      log('fail from server');
      log(e.toString());
      errorSnackBar(
        context: context,
        title: 'Server Issue',
        msg: 'Product is not added',
      );
    }
  }
}
