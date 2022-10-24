import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/common/appColors.dart';
import 'package:restaurant_app/flow/menu/views/cart/controller/getCartController.dart';
import 'package:restaurant_app/flow/menu/views/cart/widgets/singleCartItemWidget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartController = Get.put(GetCartController());
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: Obx(
            () => Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: constraints.maxHeight * 0.05,
                    ),
                    Text(
                      'Cart',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.04,
                    ),
                    Expanded(
                      child: getCartController.cartItems.isEmpty
                          ? Center(
                              child: Text(
                                'No Item',
                              ),
                            )
                          : ListView.builder(
                              itemCount: getCartController.cartItems.length,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) =>
                                  CartSingleItemWidget(
                                imagePath: getCartController
                                    .cartItems[index].product![0].tabImage,
                                itemTitle: getCartController
                                    .cartItems[index].product![0].title,
                                itemDescription: getCartController
                                    .cartItems[index].product![0].description,
                                itemPrice: getCartController
                                    .cartItems[index].product![0].price,
                                itemQuantity:
                                    getCartController.cartItems[index].quantity,
                                removeItemCall: () {
                                  getCartController.removeItemFromCart(
                                    context: context,
                                    cartItemId: getCartController
                                        .cartItems[index].id
                                        .toString(),
                                  );
                                },
                                updateItemCall: (val) {
                                  getCartController.updateItemFromCart(
                                    cartItemId:
                                        getCartController.cartItems[0].id,
                                    quantity: val,
                                    context: context,
                                  );
                                },
                                extras:
                                    getCartController.cartItems[index].extras,
                                constraints: constraints,
                              ),
                            ),
                    ),
                    getCartController.cartItems.isEmpty
                        ? SizedBox()
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: constraints.maxHeight * 0.01,
                              ),
                              Text(
                                'Add a note about your order',
                                style: TextStyle(
                                    fontSize: constraints.maxHeight * 0.015),
                              ),
                              SizedBox(
                                height: constraints.maxHeight * 0.018,
                              ),
                              Container(
                                height: constraints.maxHeight * 0.18,
                                width: constraints.maxWidth * 0.88,
                                color:
                                    AppColors.lightGrayColor.withOpacity(0.4),
                                child: TextFormField(
                                  controller:
                                      getCartController.addNOteText.value,
                                  style: TextStyle(
                                    fontSize: constraints.maxHeight * 0.018,
                                    color: AppColors.mainColor,
                                  ),
                                  cursorColor: AppColors.mainColor,
                                  textAlign: TextAlign.start,
                                  textInputAction: TextInputAction.done,
                                  maxLines: 8,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    hintText: 'Add a note',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.mainColor,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(1),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      // width: 0.0 produces a thin "hairline" border
                                      borderSide: BorderSide(
                                        color: AppColors.mainColor,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(1),
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(1),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                  ],
                ),
                Positioned(
                  top: constraints.maxHeight * 0.04,
                  left: constraints.maxWidth * 0.03,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: constraints.maxHeight * 0.032,
                      width: constraints.maxWidth * 0.1,
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.pureWhiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
                getCartController.loading.value
                    ? Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Obx(
          () => Container(
            color: AppColors.backgroundColor,
            height: MediaQuery.of(context).size.height * 0.07,
            child: getCartController.cartItems.isEmpty
                ? SizedBox()
                : Center(
                    child: MaterialButton(
                      elevation: 0,
                      onPressed: () {
                        getCartController.submitCart(
                          context: context,
                          // cartId: getCartController.cartId.value,
                        );
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: AppColors.pureWhiteColor,
                          fontSize: 16,
                        ),
                      ),
                      color: AppColors.mainColor,
                      minWidth: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.05,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
