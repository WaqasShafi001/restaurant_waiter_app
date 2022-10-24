// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/common/appColors.dart';
import 'package:restaurant_app/common/capitilizeExtention.dart';
import 'package:restaurant_app/flow/menu/models/CategoriesProductsApiModel.dart';
import 'package:restaurant_app/flow/menu/models/menuProductModel.dart';
import 'package:restaurant_app/flow/menu/views/productDetail/controller/productController.dart';
import 'package:restaurant_app/flow/search/model/basicSearchModel.dart';
import 'package:restaurant_app/main.dart';
import 'package:restaurant_app/utils/constants.dart';
import 'package:restaurant_app/widgets/commonButton.dart';
import '../horizontalLayout/listingLayouts.dart';
import '../cart/controller/addToCartController.dart';

class ProductDetailScreen extends StatefulWidget {
  final int? productId;
  final String? imagePath;
  final String? title;
  final String? description;
  final int? price;
  final int? isHalal;
  final int? isChilli;
  final int? isNew;
  final int? isPopular;
  final int? isVegiterian;
  final int? time;
  final List<ExtrasFromMeal>? extrasFromMealPlanner;
  final List<ExtrasFromListing>? extrasFromCategoryProductListing;
  final List<ExtrasFromSearch>? extrasFromSearch;
  final String? isMealPlanner;
  // final int? quantity;

  const ProductDetailScreen({
    Key? key,
    this.imagePath,
    this.title,
    this.description,
    this.price,
    this.isHalal,
    this.isChilli,
    this.isNew,
    this.isPopular,
    this.isVegiterian,
    this.time,
    this.extrasFromMealPlanner,
    this.extrasFromCategoryProductListing,
    this.extrasFromSearch,
    this.isMealPlanner,
    this.productId,
  }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  var cartController = Get.find<AddToCartController>();
  var productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Obx(
        () => Scaffold(
          backgroundColor: AppColors.backgroundColor,
          resizeToAvoidBottomInset: true,
          body: Container(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  child: Column(
                    //  padding: EdgeInsets.zero,
                    children: [
                      Container(
                        height: constraints.maxHeight * 0.4,
                        color: AppColors.backgroundColor,
                        child: CachedNetworkImage(
                          imageUrl: widget.imagePath!,
                          fit: BoxFit.fill,
                          height: constraints.maxHeight,
                          width: constraints.maxWidth,
                          placeholder: (context, url) => Center(
                            child: Image.asset(
                              'assets/no_image.png',
                            ),
                          ),
                          errorWidget: (context, url, error) => Center(
                            child: Image.asset(
                              'assets/no_image.png',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: constraints.maxHeight * 0.6,
                        width: constraints.maxWidth,
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            SizedBox(
                              height: constraints.maxHeight * 0.01,
                            ),
                            Container(
                              height: constraints.maxHeight * 0.17,
                              width: constraints.maxWidth * 0.9,
                              color: AppColors.backgroundColor,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: Container(
                                      color: Colors.transparent,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                '${widget.title!.capitalizeFirstofEach}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: MediaQuery
                                                                  .of(context)
                                                              .size
                                                              .width >
                                                          600
                                                      ? MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.0175
                                                      : MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.015,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              widget.isNew == 1
                                                  ? Image.asset(
                                                      'assets/new.png',
                                                    )
                                                  : SizedBox(),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              widget.isPopular == 1
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(15),
                                                        ),
                                                        border: Border.all(
                                                          color: AppColors
                                                              .mainColor,
                                                          width: 1,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    constraints
                                                                            .maxWidth *
                                                                        0.015,
                                                                vertical: 2),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Text(
                                                              'Popular',
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .midBlackColor,
                                                              ),
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .local_fire_department_outlined,
                                                              color: AppColors
                                                                  .mainColor,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox()
                                            ],
                                          ),
                                          Text(
                                            '${widget.description!.capitalizeFirstofEach}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: MediaQuery.of(context)
                                                          .size
                                                          .width >
                                                      600
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.016
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.015,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: AppColors.mainColor,
                                                    width: 2,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(6.0),
                                                  child: Image.asset(
                                                    'assets/time.png',
                                                    color: AppColors.mainColor,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    constraints.maxWidth * 0.01,
                                              ),
                                              Text(
                                                '${widget.time} Minute(s)',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width >
                                                          600
                                                      ? MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.016
                                                      : MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.015,
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    constraints.maxWidth * 0.01,
                                              ),
                                              widget.isChilli == 1
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color: AppColors
                                                              .mainColor,
                                                          width: 2,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(6.0),
                                                        child: Image.asset(
                                                          'assets/chilli.png',
                                                          height: constraints
                                                                  .maxHeight *
                                                              0.016,
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox(),
                                              SizedBox(
                                                width:
                                                    constraints.maxWidth * 0.01,
                                              ),
                                              widget.isVegiterian == 1
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color: AppColors
                                                              .mainColor,
                                                          width: 2,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(6.0),
                                                          child: Image.asset(
                                                            'assets/onion.png',
                                                            color: AppColors
                                                                .mainColor,
                                                          )),
                                                    )
                                                  : SizedBox(),
                                              SizedBox(
                                                width:
                                                    constraints.maxWidth * 0.01,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: AppColors.mainColor,
                                                    width: 2,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(6.0),
                                                  child: widget.isHalal == 1
                                                      ? Image.asset(
                                                          'assets/halal.png',
                                                          height: constraints
                                                                  .maxHeight *
                                                              0.017,
                                                          color: AppColors
                                                              .mainColor,
                                                        )
                                                      : SizedBox(),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Container(
                                        height: constraints.maxHeight * 0.03,
                                        width: constraints.maxWidth * 0.1,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(6),
                                            ),
                                            color: AppColors.deepPurpleColor
                                                .withOpacity(0.7)),
                                        child: Center(
                                          child: Text(
                                            '\$${formatter.format(widget.price)}',
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                          .size
                                                          .width >
                                                      600
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.017
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.015,
                                              color: AppColors.mainColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Obx(
                              () => Container(
                                height: constraints.maxHeight * 0.14,
                                width: constraints.maxWidth,
                                color: AppColors.backgroundColor,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: constraints.maxWidth * 0.15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            flex: 7,
                                            child: Container(
                                              height:
                                                  constraints.maxHeight * 0.05,
                                              color: Colors.transparent,
                                              child: RadioListTile<String>(
                                                value: 'Single',
                                                groupValue: productController
                                                    .slectedValue.value,
                                                onChanged: (value) {
                                                  productController.slectedValue
                                                      .value = value!;
                                                },
                                                activeColor:
                                                    AppColors.mainColor,
                                                title: Text(
                                                  'sinlge',
                                                  style: TextStyle(
                                                    fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width >
                                                            600
                                                        ? MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.016
                                                        : MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.015,
                                                  ),
                                                ).tr(),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 3,
                                            child: Container(
                                              height:
                                                  constraints.maxHeight * 0.05,
                                              color: Colors.transparent,
                                              child: Center(
                                                child: Text(
                                                  '\$ ${widget.price}',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 1,
                                        color: AppColors.black2Color,
                                        width: constraints.maxWidth * 0.8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            flex: 7,
                                            child: Container(
                                              height:
                                                  constraints.maxHeight * 0.05,
                                              color: Colors.transparent,
                                              child: RadioListTile<String>(
                                                value: 'Double',
                                                groupValue: productController
                                                    .slectedValue.value,
                                                onChanged: (value) {
                                                  productController.slectedValue
                                                      .value = value!;
                                                },
                                                activeColor:
                                                    AppColors.mainColor,
                                                title: Text(
                                                  'double',
                                                  style: TextStyle(
                                                    fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width >
                                                            600
                                                        ? MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.016
                                                        : MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.015,
                                                  ),
                                                ).tr(),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 3,
                                            child: Container(
                                              height:
                                                  constraints.maxHeight * 0.05,
                                              color: Colors.transparent,
                                              child: Center(
                                                child: Text(
                                                  '\$ ${(widget.price! * 2)}',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            widget.isMealPlanner == AppConstants.fromMeal
                                ? Expanded(
                                    child: Container(
                                      // height: constraints.maxHeight * 0.25,
                                      width: constraints.maxWidth,
                                      color: Colors.transparent,
                                      child: widget
                                              .extrasFromMealPlanner!.isEmpty
                                          ? SizedBox()
                                          : ListView.builder(
                                              itemCount: widget
                                                  .extrasFromMealPlanner!
                                                  .length,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) =>
                                                  Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical:
                                                        constraints.maxHeight *
                                                            0.01),
                                                child: Center(
                                                  child: Container(
                                                    height:
                                                        constraints.maxHeight *
                                                            0.05,
                                                    width:
                                                        constraints.maxWidth *
                                                            0.71,
                                                    decoration: BoxDecoration(
                                                      color: AppColors.mainColor
                                                          .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(15),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: constraints
                                                                  .maxWidth *
                                                              0.025),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              widget
                                                                  .extrasFromMealPlanner![
                                                                      index]
                                                                  .name!,
                                                              style: TextStyle(
                                                                fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .width >
                                                                        600
                                                                    ? MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.016
                                                                    : MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.015,
                                                              ),
                                                            ),
                                                            flex: 7,
                                                          ),
                                                          Flexible(
                                                            child: Text(
                                                              '\$ ${widget.extrasFromMealPlanner![index].price!.toString()}',
                                                              style: TextStyle(
                                                                  fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .width >
                                                                          600
                                                                      ? MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.016
                                                                      : MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.015,
                                                                  color: AppColors
                                                                      .mainColor),
                                                            ),
                                                            flex: 3,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ),
                                  )
                                : widget.isMealPlanner ==
                                        AppConstants.fromListing
                                    ? Expanded(
                                        child: Container(
                                          // height: constraints.maxHeight * 0.3,
                                          width: constraints.maxWidth,
                                          color: Colors.transparent,
                                          child: widget
                                                  .extrasFromCategoryProductListing!
                                                  .isEmpty
                                              ? SizedBox()
                                              : ListView.builder(
                                                  itemCount: widget
                                                      .extrasFromCategoryProductListing!
                                                      .length,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) =>
                                                          Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: constraints
                                                                    .maxHeight *
                                                                0.01),
                                                    child: Center(
                                                      child: InkWell(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(15),
                                                        ),
                                                        onTap: () {
                                                          setState(() {
                                                            cartController
                                                                .selectedExtrasByIndex(
                                                                    index);
                                                          });
                                                          print(
                                                              'selected extra id = ${cartController.selectedExtras.value}');
                                                        },
                                                        child: Container(
                                                          height: constraints
                                                                  .maxHeight *
                                                              0.05,
                                                          width: constraints
                                                                  .maxWidth *
                                                              0.71,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: cartController
                                                                    .selectedExtras
                                                                    .value
                                                                    .contains(
                                                                        index)
                                                                ? AppColors
                                                                    .mainColor
                                                                : AppColors
                                                                    .mainColor
                                                                    .withOpacity(
                                                                        0.2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  15),
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets.symmetric(
                                                                horizontal:
                                                                    constraints
                                                                            .maxWidth *
                                                                        0.025),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Flexible(
                                                                  child: Text(
                                                                    widget
                                                                        .extrasFromCategoryProductListing![
                                                                            index]
                                                                        .name!,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize: MediaQuery.of(context).size.width > 600
                                                                          ? MediaQuery.of(context).size.height *
                                                                              0.016
                                                                          : MediaQuery.of(context).size.height *
                                                                              0.015,
                                                                    ),
                                                                  ),
                                                                  flex: 7,
                                                                ),
                                                                Flexible(
                                                                  child: Text(
                                                                    '\$ ${widget.extrasFromCategoryProductListing![index].price!.toString()}',
                                                                    style: TextStyle(
                                                                        fontSize: MediaQuery.of(context).size.width > 600
                                                                            ? MediaQuery.of(context).size.height *
                                                                                0.016
                                                                            : MediaQuery.of(context).size.height *
                                                                                0.015,
                                                                        color: cartController.selectedExtras.value.contains(index)
                                                                            ? AppColors.deepPurpleColor
                                                                            : AppColors.mainColor),
                                                                  ),
                                                                  flex: 3,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      )
                                    : Expanded(
                                        child: Container(
                                          // height: constraints.maxHeight * 0.25,
                                          width: constraints.maxWidth,
                                          color: Colors.transparent,
                                          child: widget
                                                  .extrasFromSearch!.isEmpty
                                              ? SizedBox()
                                              : ListView.builder(
                                                  itemCount: widget
                                                      .extrasFromSearch!.length,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) =>
                                                          Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: constraints
                                                                    .maxHeight *
                                                                0.01),
                                                    child: Center(
                                                      child: Container(
                                                        height: constraints
                                                                .maxHeight *
                                                            0.05,
                                                        width: constraints
                                                                .maxWidth *
                                                            0.71,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: AppColors
                                                              .mainColor
                                                              .withOpacity(0.2),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(15),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      constraints
                                                                              .maxWidth *
                                                                          0.025),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Flexible(
                                                                child: Text(
                                                                  widget
                                                                      .extrasFromSearch![
                                                                          index]
                                                                      .name!,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize: MediaQuery.of(context).size.width >
                                                                            600
                                                                        ? MediaQuery.of(context).size.height *
                                                                            0.016
                                                                        : MediaQuery.of(context).size.height *
                                                                            0.015,
                                                                  ),
                                                                ),
                                                                flex: 7,
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                  '\$ ${widget.extrasFromSearch![index].price!.toString()}',
                                                                  style: TextStyle(
                                                                      fontSize: MediaQuery.of(context).size.width > 600
                                                                          ? MediaQuery.of(context).size.height *
                                                                              0.016
                                                                          : MediaQuery.of(context).size.height *
                                                                              0.015,
                                                                      color: AppColors
                                                                          .mainColor),
                                                                ),
                                                                flex: 3,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ),
                            SizedBox(
                              height: constraints.maxHeight * 0.07,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: constraints.maxHeight * 0.04,
                  left: constraints.maxWidth * 0.03,
                  right: constraints.maxWidth * 0.03,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Align(
                      alignment: findLanguageController.isEnglish.value ||
                              findLanguageController.isTurkish.value
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
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
                ),
                cartController.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : SizedBox(),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            color: AppColors.backgroundColor,
            height: MediaQuery.of(context).size.height * 0.07,
            child: Row(
              children: [
                Flexible(
                  flex: 5,
                  child: Container(
                    color: AppColors.backgroundColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                productController.decreamentCounter(
                                    productController.quantityCounter.value);
                              },
                              child: Container(
                                // height: MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width * 0.05,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.lightGrayColor,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.remove,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.035,
                              width: MediaQuery.of(context).size.width * 0.07,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.black2Color,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '${productController.quantityCounter.value}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                productController.increamentCounter(
                                    productController.quantityCounter.value);
                              },
                              child: Container(
                                // height: MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width * 0.05,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.mainColor,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.pureWhiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 5,
                  child: Container(
                      color: AppColors.backgroundColor,
                      child: Center(
                        child: CommonButton(
                          color: AppColors.mainColor,
                          onTap: () {
                            // productDetailController.addProductToCart();
                            print('this is product id = ${widget.productId}');

                            /// submit cart call here
                            cartController.addProductToCart(
                              context: context,
                              price: widget.price,
                              productId: widget.productId,
                              quantity: productController.quantityCounter.value,
                            );
                          },
                          isIcon: true,
                          icon: Image.asset(
                            'assets/cartIcon.png',
                          ),
                          text: tr('add_to_cart'),
                          textColor: AppColors.pureWhiteColor,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.045,
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
