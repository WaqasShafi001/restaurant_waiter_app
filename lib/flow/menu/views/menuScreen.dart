// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/common/appColors.dart';
import 'package:restaurant_app/flow/mainScreen/mainScreen.dart';
import 'package:restaurant_app/utils/GetXNetworkManager.dart';
import 'package:restaurant_app/widgets/verticleText.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/categoriesProductsApiController.dart';
import '../controllers/layoutChangeController.dart';
import '../controllers/requestController.dart';
import '../widgets/topLeftWidget.dart';
import '../widgets/topRightWidget.dart';
import 'cart/view/CartScreen.dart';
import 'cart/controller/addToCartController.dart';
import 'verticalLayout/VerticalLayout.dart';
import 'horizontalLayout/HorizontalLayout.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  bool isVisible = false;
  var layoutChangeController = Get.put(LayoutChangeController());
  var requestController = Get.put(RequestController());
  var categoriesController = Get.put(CategoriesProductsApiController());
  GetXNetworkManager networkManager = Get.put(GetXNetworkManager());
  var cartController = Get.put(AddToCartController());

  @override
  Widget build(BuildContext context) {
    categoriesController.getTableNumber();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (context, constraints) => Obx(
          () => Stack(
            alignment: Alignment.center,
            children: [
              layoutChangeController.verticalLayout.value
                  ? VerticalLayout(
                      categoriesController: categoriesController,
                    )
                  : HorizontalLayout(
                      constraints: constraints,
                      categoriesController: categoriesController,
                    ),
              Positioned(
                top: constraints.maxHeight * 0.035,
                left: constraints.maxWidth * 0.06,
                child: TopRightWidget(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                ),
              ),
              Positioned(
                top: constraints.maxHeight * 0.035,
                right: constraints.maxWidth * 0.06,
                child: TopLeftWidget(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  controller: layoutChangeController,
                ),
              ),
              categoriesController.isLoading.value
                  ? Container(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      color: AppColors.lightGrayColor.withOpacity(0.1),
                      child: Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    )
                  : SizedBox(),
              Positioned(
                left: 0,
                top: constraints.maxHeight * 0.08,
                child: InkWell(
                  onTap: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    var totalTables = pref.getInt('totalTables');

                    Get.to(MainScreen(
                      totalTables: totalTables,
                    ));
                  },
                  child: Container(
                    height: constraints.maxHeight * 0.09,
                    width: constraints.maxWidth * 0.06,
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          VerticalText('TABLE'),
                          Text(
                            categoriesController.tableNumber.value.toString(),
                            style: TextStyle(
                              color: AppColors.pureWhiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: constraints.maxHeight * 0.08,
                child: InkWell(
                  onTap: () => categoriesController.logOut(),
                  child: Container(
                    height: constraints.maxHeight * 0.1,
                    width: constraints.maxWidth * 0.06,
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.power_settings_new_rounded,
                          color: AppColors.pureWhiteColor,
                          size: constraints.maxHeight * 0.025,
                        ),
                        VerticalText('LOGOUT'),
                      ],
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(CartScreen());
        },
        label: Text(
          'cart',
          style: TextStyle(
            fontSize: 20,
            color: AppColors.pureWhiteColor,
          ),
        ).tr(),
        backgroundColor: AppColors.mainColor,
        enableFeedback: true,
        icon: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container(
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     color: AppColors.deepPurpleColor,
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.all(5.0),
            //     child: Text(
            //       '${cartController.selectedCartProducts.length}',
            //       style: TextStyle(
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   width: 5,
            // ),
            Image.asset(
              'assets/cartIcon.png',
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Container(
      //   height: MediaQuery.of(context).size.height * 0.075,
      //   color: AppColors.backgroundColor,
      //   alignment: Alignment.center,
      //   child: CommonButton(
      //     color: AppColors.darkGrayColor,
      //     onTap: () {
      //       Get.to(CartScreen());
      //     },
      //     isIcon: true,
      //     icon: Image.asset(
      //       'assets/cartIcon.png',
      //     ),
      //     text: tr('cart'),
      //     textColor: AppColors.pureWhiteColor,
      //     width: MediaQuery.of(context).size.width,
      //     height: MediaQuery.of(context).size.height * 0.04,
      //   ),
      // ),
    );
  }
}
