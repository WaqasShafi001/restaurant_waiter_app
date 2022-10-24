import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/common/appColors.dart';
import 'package:restaurant_app/flow/menu/views/cart/model/getAllCartModel.dart';
import 'package:restaurant_app/flow/menu/views/cart/model/orderSubmitModel.dart';
import 'package:restaurant_app/flow/menu/views/cart/model/removeCartItemModel.dart';
import 'package:restaurant_app/flow/menu/views/cart/model/updateCartModel.dart';
import 'package:restaurant_app/utils/apiUrls.dart';
import 'package:restaurant_app/utils/snackBars.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetCartController extends GetxController {
  @override
  void onInit() {
    getAllCartItems();
    super.onInit();
  }

  Rx<TextEditingController> addNOteText = TextEditingController().obs;

  var loading = false.obs;
  var cartItems = <CartItems>[].obs;
  var cartId = 00.obs;

  var isCartEmpty = true.obs;

  getAllCartItems() async {
    loading.value = true;
    // isCartEmpty.value = false;
    SharedPreferences pref = await SharedPreferences.getInstance();
    var thisID = pref.getInt('venueID');
    var tableNo = pref.getInt('TableNumber')!;
    try {
      var response = await http.get(
        Uri.parse('$baseURL$getCartUrl/$thisID/$tableNo'),
      );

      var data = jsonDecode(response.body);
      GetAllCartModel model = GetAllCartModel.fromJson(data);

      if (response.statusCode == 200) {
        loading.value = false;
        cartId.value = model.data![0].id!;
        cartItems.value = model.data![0].items!;
        // if (cartItems.isEmpty) {
        //   isCartEmpty.value = true;
        // } else {
        //   isCartEmpty.value = false;
        // }
      } else {
        loading.value = false;
      }
    } catch (e) {
      log(e.toString());
      loading.value = false;
    }
  }

  removeItemFromCart({String? cartItemId, BuildContext? context}) async {
    loading.value = true;
    try {
      var response = await http.post(
        Uri.parse('$baseURL$removeCartItemUrl'),
        body: {
          'cart_item_id': cartItemId,
        },
      );
      var data = jsonDecode(response.body);

      RemoveCartItemModel model = RemoveCartItemModel.fromJson(data);

      if (response.statusCode == 200) {
        loading.value = false;
        successSnackBar(
          context: context,
          title: 'Success',
          msg: 'Item removed',
        );

        cartItems.clear();
        getAllCartItems();
      } else {
        loading.value = false;
        errorSnackBar(
          context: context,
          title: 'Opps!',
          msg: 'Item is not removed',
        );
      }
    } catch (e) {
      log(e.toString());
    }
  }

  updateItemFromCart(
      {BuildContext? context, int? cartItemId, int? quantity}) async {
    loading.value = true;

    try {
      var response = await http.post(
        Uri.parse('$baseURL$updateCartItemUrl'),
        body: {
          'cart_item_id': cartItemId.toString(),
          'quantity': quantity.toString(),
          // 'extras[]': '',
        },
      );

      var data = jsonDecode(response.body);
      UpdateCartModel model = UpdateCartModel.fromJson(data);
      if (response.statusCode == 200) {
        loading.value = false;
        log('message ${model.message}');
        cartItems.clear();
        await getAllCartItems();
        successSnackBar(
          context: context,
          title: 'Success',
          msg: 'Item Updated',
        );
      } else {
        loading.value = false;
        log('message ${model.message}');
      }
    } catch (e) {
      loading.value = false;
      log(e.toString());
    }
  }

  submitCart({BuildContext? context}) async {
    loading.value = true;
    log('this is cart id =-=-=-= ${cartId.value}');
    try {
      var response = await http.post(
        Uri.parse('$baseURL$submitOrderUrl'),
        body: {
          'cart_id': cartId.value.toString(),
        },
      );

      // var data = jsonDecode(response.body);

      // OrderSubmitModel model = OrderSubmitModel.fromJson(data);

      if (response.statusCode == 200) {
        // log(model.message.toString());
        loading.value = false;
        addNOteText.value.clear();
        // successSnackBar(
        //   context: context,
        //   title: 'Success',
        //   msg: 'Order Submitted',
        // );

        Get.generalDialog(
          pageBuilder: (context, animation, secondaryAnimation) => Center(
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child: LayoutBuilder(
                builder: (context, c) => Container(
                  height: c.maxHeight * 0.4,
                  width: c.maxWidth * 0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/orderSubmitted.png',
                        // color: AppColors.mainColor,
                      ),
                      Text(
                        'Your Order was sent successfully',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width > 600
                              ? MediaQuery.of(context).size.height * 0.016
                              : MediaQuery.of(context).size.height * 0.015,
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          Get.back();
                          Get.back();
                        },
                        color: AppColors.mainColor,
                        child: Text(
                          'Okay',
                          style: TextStyle(
                            color: AppColors.pureWhiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          barrierLabel: '',
          barrierDismissible: false,
        );
      } else {
        addNOteText.value.clear();

        loading.value = false;
        log('order not submitted');
        errorSnackBar(
          context: context,
          title: 'Error',
          msg: 'Order not Submitted',
        );
      }
    } catch (e) {
      loading.value = false;
      addNOteText.value.clear();

      log(e.toString());
    }
  }
}
