// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/common/capitilizeExtention.dart';
import 'package:restaurant_app/main.dart';
import 'package:restaurant_app/utils/constants.dart';
import '../../../../common/appColors.dart';
import '../../models/CategoriesProductsApiModel.dart';
import '../productDetail/ProductDetailScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';

var formatter = NumberFormat('#,##,000');

GridView TwoProductsInRowLayout({
  BoxConstraints? constraints,
  List<Products>? products,
}) {
  return products!.isEmpty
      ? GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 8,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8),
          itemCount: 1,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, index) => Center(
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Text(
                  'no_data',
                ).tr(),
              ),
            ),
          ),
        )
      : GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8),
          itemCount: products.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                onTap: () {
                  Get.to(ProductDetailScreen(
                    title: findLanguageController.isEnglish.value
                        ? '${products[index].title!.capitalizeFirstofEach}'
                        : findLanguageController.isArabic.value
                            ? products[index].translationss!.length > 0
                                ? '${products[index].translationss![0].title!.capitalizeFirstofEach}'
                                : 'No title'
                            : findLanguageController.isTurkish.value
                                ? products[index].translationss!.length > 1
                                    ? '${products[index].translationss![1].title!.capitalizeFirstofEach}'
                                    : 'No title'
                                : 'No TITLE',
                    description: findLanguageController.isEnglish.value
                        ? '${products[index].description!.capitalizeFirstofEach}'
                        : findLanguageController.isArabic.value
                            ? products[index].translationss!.length > 0
                                ? '${products[index].translationss![0].description!.capitalizeFirstofEach}'
                                : 'no desc'
                            : findLanguageController.isTurkish.value
                                ? products[index].translationss!.length > 1
                                    ? '${products[index].translationss![1].description!.capitalizeFirstofEach}'
                                    : 'no desc'
                                : "NO DESC",
                    imagePath: products[index].tabImage,
                    price: products[index].price,
                    isMealPlanner: AppConstants.fromListing,
                    extrasFromCategoryProductListing: products[index].extras,
                    isHalal: products[index].halal,
                    isChilli: products[index].chilli,
                    isNew: products[index].isNew,
                    isPopular: products[index].popular,
                    isVegiterian: products[index].vegetarian,
                    time: products[index].time,
                    productId: products[index].id,
                    
                  ));
                },
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        flex: 8,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.lightGrayColor,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            child: CachedNetworkImage(
                              imageUrl: products[index].tabImage!,
                              fit: BoxFit.fill,
                              height: constraints!.maxHeight,
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
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  findLanguageController.isEnglish.value
                                      ? '${products[index].title!.capitalizeFirstofEach}'
                                      : findLanguageController.isArabic.value
                                          ? products[index]
                                                      .translationss!
                                                      .length >
                                                  0
                                              ? '${products[index].translationss![0].title!.capitalizeFirstofEach}'
                                              : 'No title'
                                          : findLanguageController
                                                  .isTurkish.value
                                              ? products[index]
                                                          .translationss!
                                                          .length >
                                                      1
                                                  ? '${products[index].translationss![1].title!.capitalizeFirstofEach}'
                                                  : 'No title'
                                              : 'No TITLE',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: MediaQuery.of(context)
                                                .size
                                                .width >
                                            600
                                        ? MediaQuery.of(context).size.height *
                                            0.013
                                        : MediaQuery.of(context).size.height *
                                            0.0122,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(6),
                                    ),
                                    color: AppColors.deepPurpleColor
                                        .withOpacity(0.7)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      '\$${formatter.format(products[index].price)}',
                                      style: TextStyle(
                                          fontSize:
                                              MediaQuery.of(context)
                                                          .size
                                                          .width >
                                                      600
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.0128
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.0125,
                                          color: AppColors.mainColor),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
}

GridView FiveProductsInRowLayout({
  BoxConstraints? constraints,
  List<Products>? products,
}) {
  return products!.isEmpty
      ? GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 8,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8),
          itemCount: 1,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, index) => Center(
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Text(
                  'no_data',
                ).tr(),
              ),
            ),
          ),
        )
      : GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              childAspectRatio: 14 / 13,
              mainAxisExtent: 230,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8),
          itemCount: products.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, index) {
            return Padding(
              padding: const EdgeInsets.all(6.0),
              child: InkWell(
                onTap: () {
                  Get.to(ProductDetailScreen(
                    title: findLanguageController.isEnglish.value
                        ? '${products[index].title!.capitalizeFirstofEach}'
                        : findLanguageController.isArabic.value
                            ? products[index].translationss!.length > 0
                                ? '${products[index].translationss![0].title!.capitalizeFirstofEach}'
                                : 'No title'
                            : findLanguageController.isTurkish.value
                                ? products[index].translationss!.length > 1
                                    ? '${products[index].translationss![1].title!.capitalizeFirstofEach}'
                                    : 'No title'
                                : 'No TITLE',
                    description: findLanguageController.isEnglish.value
                        ? '${products[index].description!.capitalizeFirstofEach}'
                        : findLanguageController.isArabic.value
                            ? products[index].translationss!.length > 0
                                ? '${products[index].translationss![0].description!.capitalizeFirstofEach}'
                                : 'no desc'
                            : findLanguageController.isTurkish.value
                                ? products[index].translationss!.length > 1
                                    ? '${products[index].translationss![1].description!.capitalizeFirstofEach}'
                                    : 'no desc'
                                : "NO DESC",
                    imagePath: products[index].tabImage,
                    price: products[index].price,
                    isMealPlanner: AppConstants.fromListing,
                    extrasFromCategoryProductListing: products[index].extras,
                    isHalal: products[index].halal,
                    isChilli: products[index].chilli,
                    isNew: products[index].isNew,
                    isPopular: products[index].popular,
                    isVegiterian: products[index].vegetarian,
                    time: products[index].time,
                    productId: products[index].id,
                  ));
                },
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        flex: 7,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: AppColors.lightGrayColor,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            child: CachedNetworkImage(
                              imageUrl: products[index].tabImage!,
                              fit: BoxFit.fill,
                              height: constraints!.maxHeight,
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
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  findLanguageController.isEnglish.value
                                      ? '${products[index].title!.capitalizeFirstofEach}'
                                      : findLanguageController.isArabic.value
                                          ? products[index]
                                                      .translationss!
                                                      .length >
                                                  0
                                              ? '${products[index].translationss![0].title!.capitalizeFirstofEach}'
                                              : 'No title'
                                          : findLanguageController
                                                  .isTurkish.value
                                              ? products[index]
                                                          .translationss!
                                                          .length >
                                                      1
                                                  ? '${products[index].translationss![1].title!.capitalizeFirstofEach}'
                                                  : 'No title'
                                              : 'No TITLE',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(6),
                                    ),
                                    color: AppColors.deepPurpleColor
                                        .withOpacity(0.7)),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    '\$${formatter.format(products[index].price)}',
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: AppColors.mainColor),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
}

ListView SingleProductInRowLayout({
  BoxConstraints? constraints,
  List<Products>? products,
}) {
  return products!.isEmpty
      ? ListView.builder(
          itemBuilder: (context, index) => Container(
            height: constraints!.maxHeight * 0.05,
            width: constraints.maxWidth,
            color: Colors.transparent,
            child: Center(
              child: Text(
                'no_data',
              ).tr(),
            ),
          ),
          itemCount: 1,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
        )
      : ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: products.length,
          itemBuilder: (_, index) => Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              onTap: () {
                Get.to(ProductDetailScreen(
                  title: findLanguageController.isEnglish.value
                      ? '${products[index].title!.capitalizeFirstofEach}'
                      : findLanguageController.isArabic.value
                          ? products[index].translationss!.length > 0
                              ? '${products[index].translationss![0].title!.capitalizeFirstofEach}'
                              : 'No title'
                          : findLanguageController.isTurkish.value
                              ? products[index].translationss!.length > 1
                                  ? '${products[index].translationss![1].title!.capitalizeFirstofEach}'
                                  : 'No title'
                              : 'No TITLE',
                  description: findLanguageController.isEnglish.value
                      ? '${products[index].description!.capitalizeFirstofEach}'
                      : findLanguageController.isArabic.value
                          ? products[index].translationss!.length > 0
                              ? '${products[index].translationss![0].description!.capitalizeFirstofEach}'
                              : 'no desc'
                          : findLanguageController.isTurkish.value
                              ? products[index].translationss!.length > 1
                                  ? '${products[index].translationss![1].description!.capitalizeFirstofEach}'
                                  : 'no desc'
                              : "NO DESC",
                  imagePath: products[index].tabImage,
                  price: products[index].price,
                  isMealPlanner: AppConstants.fromListing,
                  extrasFromCategoryProductListing: products[index].extras,
                  isHalal: products[index].halal,
                  isChilli: products[index].chilli,
                  isNew: products[index].isNew,
                  isPopular: products[index].popular,
                  isVegiterian: products[index].vegetarian,
                  time: products[index].time,
                  productId: products[index].id,
                ));
              },
              child: Card(
                margin: EdgeInsets.zero,
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Container(
                  height: constraints!.maxHeight * 0.09,
                  decoration: BoxDecoration(
                    color: AppColors.pureWhiteColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Container(
                              color: AppColors.lightGrayColor,
                              child: CachedNetworkImage(
                                imageUrl: products[index].tabImage!,
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
                          ),
                        ),
                        Flexible(
                          flex: 8,
                          child: Container(
                            color: AppColors.pureWhiteColor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  findLanguageController.isEnglish.value
                                      ? '${products[index].title!.capitalizeFirstofEach}'
                                      : findLanguageController.isArabic.value
                                          ? products[index]
                                                      .translationss!
                                                      .length >
                                                  0
                                              ? '${products[index].translationss![0].title!.capitalizeFirstofEach}'
                                              : 'No title'
                                          : findLanguageController
                                                  .isTurkish.value
                                              ? products[index]
                                                          .translationss!
                                                          .length >
                                                      1
                                                  ? '${products[index].translationss![1].title!.capitalizeFirstofEach}'
                                                  : 'No title'
                                              : 'No TITLE',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: MediaQuery.of(_).size.width > 600
                                        ? MediaQuery.of(_).size.height * 0.0145
                                        : MediaQuery.of(_).size.height * 0.013,
                                  ),
                                ),
                                // Text(
                                //   '${products[index].description!.capitalizeFirstofEach}',
                                //   style: TextStyle(
                                //     fontWeight: FontWeight.normal,
                                //     fontSize: MediaQuery.of(_).size.width > 600
                                //         ? MediaQuery.of(_).size.height * 0.014
                                //         : MediaQuery.of(_).size.height * 0.013,
                                //   ),
                                //   maxLines: 1,
                                //   overflow: TextOverflow.ellipsis,
                                // ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(6),
                                      ),
                                      color: AppColors.deepPurpleColor
                                          .withOpacity(0.7)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text(
                                      '\$${formatter.format(products[index].price)}',
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(_)
                                                      .size
                                                      .width >
                                                  600
                                              ? MediaQuery.of(_).size.height *
                                                  0.014
                                              : MediaQuery.of(_).size.height *
                                                  0.013,
                                          color: AppColors.mainColor),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
}

GridView ThreeProductsInRowLayout({
  List<Products>? products,
}) {
  return products!.isEmpty
      ? GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 8,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8),
          itemCount: 1,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, index) => Center(
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Text(
                  'no_data',
                ).tr(),
              ),
            ),
          ),
        )
      : GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 7 / 6,
              crossAxisSpacing: 8,
              // mainAxisExtent: 250,
              mainAxisSpacing: 8),
          itemCount: products.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, index) {
            return InkWell(
              onTap: () {
                Get.to(ProductDetailScreen(
                  title: findLanguageController.isEnglish.value
                      ? '${products[index].title!.capitalizeFirstofEach}'
                      : findLanguageController.isArabic.value
                          ? products[index].translationss!.length > 0
                              ? '${products[index].translationss![0].title!.capitalizeFirstofEach}'
                              : 'No title'
                          : findLanguageController.isTurkish.value
                              ? products[index].translationss!.length > 1
                                  ? '${products[index].translationss![1].title!.capitalizeFirstofEach}'
                                  : 'No title'
                              : 'No TITLE',
                  description: findLanguageController.isEnglish.value
                      ? '${products[index].description!.capitalizeFirstofEach}'
                      : findLanguageController.isArabic.value
                          ? products[index].translationss!.length > 0
                              ? '${products[index].translationss![0].description!.capitalizeFirstofEach}'
                              : 'no desc'
                          : findLanguageController.isTurkish.value
                              ? products[index].translationss!.length > 1
                                  ? '${products[index].translationss![1].description!.capitalizeFirstofEach}'
                                  : 'no desc'
                              : "NO DESC",
                  imagePath: products[index].tabImage,
                  price: products[index].price,
                  isMealPlanner: AppConstants.fromListing,
                  extrasFromCategoryProductListing: products[index].extras,
                  isHalal: products[index].halal,
                  isChilli: products[index].chilli,
                  isNew: products[index].isNew,
                  isPopular: products[index].popular,
                  isVegiterian: products[index].vegetarian,
                  time: products[index].time,
                  productId: products[index].id,
                ));
              },
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Flexible(
                        flex: 8,
                        child: LayoutBuilder(
                          builder: (context, constraints) => Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: AppColors.lightGrayColor,
                            ),
                            child: Center(
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                child: CachedNetworkImage(
                                  imageUrl: products[index].tabImage!,
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
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Flexible(
                        flex: 2,
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 7,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        findLanguageController.isEnglish.value
                                            ? '${products[index].title!.capitalizeFirstofEach}'
                                            : findLanguageController
                                                    .isArabic.value
                                                ? products[index]
                                                            .translationss!
                                                            .length >
                                                        0
                                                    ? '${products[index].translationss![0].title!.capitalizeFirstofEach}'
                                                    : 'No title'
                                                : findLanguageController
                                                        .isTurkish.value
                                                    ? products[index]
                                                                .translationss!
                                                                .length >
                                                            1
                                                        ? '${products[index].translationss![1].title!.capitalizeFirstofEach}'
                                                        : 'No title'
                                                    : 'No TITLE',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width >
                                                  600
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.013
                                              : MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.0122,
                                        ),
                                      ),
                                    ),
                                    // FittedBox(
                                    //   fit: BoxFit.fitWidth,
                                    //   child: Text(
                                    //     findLanguageController.isEnglish.value
                                    //         ? '${products[index].description!.capitalizeFirstofEach}'
                                    //         : findLanguageController
                                    //                 .isArabic.value
                                    //             ? products[index]
                                    //                         .translationss!
                                    //                         .length >
                                    //                     0
                                    //                 ? '${products[index].translationss![0].description!.capitalizeFirstofEach}'
                                    //                 : 'no desc'
                                    //             : findLanguageController
                                    //                     .isTurkish.value
                                    //                 ? products[index]
                                    //                             .translationss!
                                    //                             .length >
                                    //                         1
                                    //                     ? '${products[index].translationss![1].description!.capitalizeFirstofEach}'
                                    //                     : 'no desc'
                                    //                 : "NO DESC",
                                    //     maxLines: 1,
                                    //     overflow: TextOverflow.ellipsis,
                                    //     style: TextStyle(
                                    //       fontWeight: FontWeight.normal,
                                    //       color: AppColors.lightGrayColor,
                                    //       fontSize:
                                    //           MediaQuery.of(context)
                                    //                       .size
                                    //                       .width >
                                    //                   600
                                    //               ? MediaQuery.of(context)
                                    //                       .size
                                    //                       .height *
                                    //                   0.0124
                                    //               : MediaQuery.of(context)
                                    //                       .size
                                    //                       .height *
                                    //                   0.012,
                                    //     ),
                                    //   ),
                                    // )
                                  ],
                                ),
                              ),
                              Flexible(
                                flex: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(6),
                                      ),
                                      color: AppColors.deepPurpleColor
                                          .withOpacity(0.7)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        '\$${formatter.format(products[index].price)}',
                                        style: TextStyle(
                                            fontSize:
                                                MediaQuery.of(context)
                                                            .size
                                                            .width >
                                                        600
                                                    ? MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.0128
                                                    : MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.0125,
                                            color: AppColors.mainColor),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
}
