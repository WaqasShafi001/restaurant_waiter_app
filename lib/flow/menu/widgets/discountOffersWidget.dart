// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/common/capitilizeExtention.dart';
import 'package:restaurant_app/flow/menu/controllers/categoriesProductsApiController.dart';
import 'package:restaurant_app/main.dart';
import 'package:restaurant_app/utils/snackBars.dart';
import '../../../common/appColors.dart';
import '../controllers/offersController.dart';
import '../downloadData/DownloadDataPage.dart';

class DiscountOffersWidget extends StatefulWidget {
  final double? height;
  final double? width;
  final bool? isVisible;
  const DiscountOffersWidget({
    Key? key,
    this.height,
    this.width,
    this.isVisible = true,
  }) : super(key: key);

  @override
  State<DiscountOffersWidget> createState() => _DiscountOffersWidgetState();
}

class _DiscountOffersWidgetState extends State<DiscountOffersWidget> {
  var offersController = Get.put(OffersController());
  var categoriesProductController = Get.put(CategoriesProductsApiController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RefreshIndicator(
        onRefresh: () {
          return Future.delayed(
            Duration(seconds: 1),
            () {
              categoriesProductController.onInit();

              successSnackBar(
                context: context,
                title: 'Success',
                msg: 'The data is updated',
              );
            },
          ).then((value) => setState(() {}));
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: widget.height! * 0.05,
              ),
              GestureDetector(
                onLongPress: () {
                  print('data downloading screen ..');
                  Get.to(DownloadDataPage());
                },
                child: Image.asset(
                  'assets/logo.png',
                  height: widget.height! * 0.05,
                ),
              ),
              SizedBox(
                height: widget.height! * 0.01,
              ),
              Text(
                'Restaurant',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 600
                      ? MediaQuery.of(context).size.height * 0.018
                      : MediaQuery.of(context).size.height * 0.015,
                  color: AppColors.mainColor,
                ),
              ),
              Text(
                'Main Menu',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 600
                      ? MediaQuery.of(context).size.height * 0.0155
                      : MediaQuery.of(context).size.height * 0.014,
                  color: AppColors.pureBlackColor,
                ),
              ),
              SizedBox(
                height: widget.height! * 0.01,
              ),
              widget.isVisible!
                  ? Text(
                      'All your favourite meal available for delivery and pick-up!',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width > 600
                            ? MediaQuery.of(context).size.height * 0.015
                            : MediaQuery.of(context).size.height * 0.014,
                        color: AppColors.pureBlackColor,
                      ),
                    )
                  : SizedBox(),
              SizedBox(
                height: widget.height! * 0.015,
              ),
              offersController.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  :

                  //
                  //offersController.offersList.length != 1
                  //
                  offersController.tempChangeOffer.value
                      ? InkWell(
                          onTap: () {
                            offersController.tempChangeOffer.value =
                                !offersController.tempChangeOffer.value;
                          },
                          child: offersController.offersList.isEmpty
                              ? SizedBox()
                              : AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  height: widget.isVisible!
                                      ? widget.height! * 0.13
                                      : 0,
                                  width: widget.width! * 0.95,
                                  color: AppColors.backgroundColor,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: widget.height! * 0.13,
                                        width: widget.width! * 0.3,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                        ),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Positioned(
                                              bottom: 0,
                                              left: 0,
                                              child: Container(
                                                height: widget.height! * 0.105,
                                                width: widget.width! * 0.3,
                                                decoration: BoxDecoration(
                                                    color: AppColors
                                                        .paleYellowColor,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: widget.width! *
                                                          0.015),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      FittedBox(
                                                        fit: BoxFit.fitWidth,
                                                        child: Text(
                                                          'Lorem Ipsum text',
                                                          style: TextStyle(
                                                              fontSize: 13),
                                                        ),
                                                      ),
                                                      FittedBox(
                                                        fit: BoxFit.fitWidth,
                                                        child: Text(
                                                          'Lorem Ipsum ',
                                                          style: TextStyle(
                                                              fontSize: 13),
                                                        ),
                                                      ),
                                                      FittedBox(
                                                        fit: BoxFit.fitWidth,
                                                        child: Text(
                                                          'Lorem Ipsum',
                                                          style: TextStyle(
                                                              fontSize: 13),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: widget.height! *
                                                            0.005,
                                                      ),
                                                      Text(
                                                        'Weekly Discount',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              right: 10,
                                              top: 0,
                                              child: CircleAvatar(
                                                maxRadius: widget.isVisible!
                                                    ? widget.width! * 0.06
                                                    : 0,
                                                minRadius: widget.isVisible!
                                                    ? widget.width! * 0.06
                                                    : 0,
                                                child: ClipOval(
                                                  child: Image.asset(
                                                    'assets/f1.png',
                                                    fit: BoxFit.fill,
                                                    height: widget.height,
                                                    width: widget.width,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: widget.height! * 0.13,
                                        width: widget.width! * 0.3,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                        ),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Positioned(
                                              bottom: 0,
                                              left: 0,
                                              child: Container(
                                                height: widget.height! * 0.105,
                                                width: widget.width! * 0.3,
                                                decoration: BoxDecoration(
                                                    color: AppColors
                                                        .lightGreenColor,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: widget.width! *
                                                          0.015),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      FittedBox(
                                                        fit: BoxFit.fitWidth,
                                                        child: Text(
                                                          'Lorem Ipsum text',
                                                          style: TextStyle(
                                                              fontSize: 13),
                                                        ),
                                                      ),
                                                      FittedBox(
                                                        fit: BoxFit.fitWidth,
                                                        child: Text(
                                                          'Lorem Ipsum ',
                                                          style: TextStyle(
                                                              fontSize: 13),
                                                        ),
                                                      ),
                                                      FittedBox(
                                                        fit: BoxFit.fitWidth,
                                                        child: Text(
                                                          'Lorem Ipsum',
                                                          style: TextStyle(
                                                              fontSize: 13),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: widget.height! *
                                                            0.005,
                                                      ),
                                                      Text(
                                                        'Weekly Discount',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              right: 10,
                                              top: 0,
                                              child: CircleAvatar(
                                                maxRadius: widget.isVisible!
                                                    ? widget.width! * 0.06
                                                    : 0,
                                                minRadius: widget.isVisible!
                                                    ? widget.width! * 0.06
                                                    : 0,
                                                child: ClipOval(
                                                  child: Image.asset(
                                                    'assets/f1.png',
                                                    fit: BoxFit.fill,
                                                    height: widget.height,
                                                    width: widget.width,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: widget.height! * 0.13,
                                        width: widget.width! * 0.3,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                        ),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Positioned(
                                              bottom: 0,
                                              left: 0,
                                              child: Container(
                                                height: widget.height! * 0.105,
                                                width: widget.width! * 0.3,
                                                decoration: BoxDecoration(
                                                    color: AppColors.skyColor,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: widget.width! *
                                                          0.015),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      FittedBox(
                                                        fit: BoxFit.fitWidth,
                                                        child: Text(
                                                          'Lorem Ipsum text',
                                                          style: TextStyle(
                                                              fontSize: 13),
                                                        ),
                                                      ),
                                                      FittedBox(
                                                        fit: BoxFit.fitWidth,
                                                        child: Text(
                                                          'Lorem Ipsum ',
                                                          style: TextStyle(
                                                              fontSize: 13),
                                                        ),
                                                      ),
                                                      FittedBox(
                                                        fit: BoxFit.fitWidth,
                                                        child: Text(
                                                          'Lorem Ipsum',
                                                          style: TextStyle(
                                                              fontSize: 13),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: widget.height! *
                                                            0.005,
                                                      ),
                                                      Text(
                                                        'Weekly Discount',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              right: 10,
                                              top: 0,
                                              child: CircleAvatar(
                                                maxRadius: widget.isVisible!
                                                    ? widget.width! * 0.06
                                                    : 0,
                                                minRadius: widget.isVisible!
                                                    ? widget.width! * 0.06
                                                    : 0,
                                                child: ClipOval(
                                                  child: Image.asset(
                                                    'assets/f1.png',
                                                    fit: BoxFit.fill,
                                                    height: widget.height,
                                                    width: widget.width,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        )
                      : InkWell(
                          onTap: () {
                            offersController.tempChangeOffer.value =
                                !offersController.tempChangeOffer.value;
                          },
                          child: offersController.offersList.isEmpty
                              ? SizedBox()
                              : AnimatedContainer(
                                  height: widget.isVisible!
                                      ? widget.height! * 0.13
                                      : 0.0,
                                  width: widget.width! * 0.95,
                                  decoration: BoxDecoration(
                                    color: AppColors.mainColor.withOpacity(0.1),
                                    // image: DecorationImage(
                                    //   image: AssetImage(
                                    //     'assets/topAdd1.png',
                                    //   ),
                                    //   fit: BoxFit.cover,
                                    // ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  duration: Duration(milliseconds: 300),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        child: CachedNetworkImage(
                                          imageUrl: offersController
                                              .offersList[0].image!,
                                          fit: BoxFit.fitWidth,
                                          height: widget.height,
                                          width: widget.width,
                                          placeholder: (context, url) => Center(
                                            child: Image.asset(
                                              'assets/no_image.png',
                                              fit: BoxFit.fitWidth,
                                              width: widget.width,
                                              height: widget.height,
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Center(
                                            child: Image.asset(
                                              'assets/no_image.png',
                                              fit: BoxFit.fitWidth,
                                              width: widget.width,
                                              height: widget.height,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: AnimatedContainer(
                                          duration: Duration(milliseconds: 300),
                                          height: widget.isVisible!
                                              ? widget.height! * 0.09
                                              : 0.0,
                                          width: widget.width! * 0.8,
                                          color: AppColors.pureWhiteColor
                                              .withOpacity(0.66),
                                          child: Center(
                                            child: SingleChildScrollView(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  FittedBox(
                                                    fit: BoxFit.fitWidth,
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      findLanguageController
                                                              .isEnglish.value
                                                          ? offersController
                                                              .offersList[0]
                                                              .title!
                                                              .capitalizeFirstofEach
                                                          : findLanguageController
                                                                  .isArabic
                                                                  .value
                                                              ? offersController
                                                                  .offersList[0]
                                                                  .translations![
                                                                      0]
                                                                  .title!
                                                                  .capitalizeFirstofEach
                                                              : findLanguageController
                                                                      .isTurkish
                                                                      .value
                                                                  ? offersController
                                                                              .offersList[
                                                                                  0]
                                                                              .translations!
                                                                              .length >
                                                                          1
                                                                      ? offersController
                                                                          .offersList[
                                                                              0]
                                                                          .translations![
                                                                              1]
                                                                          .title!
                                                                          .capitalizeFirstofEach
                                                                      : 'no title'
                                                                  : 'no title',
                                                      style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width >
                                                                600
                                                            ? MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.018
                                                            : MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.015,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            AppColors.mainColor,
                                                      ),
                                                    ),
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      text: findLanguageController
                                                              .isEnglish.value
                                                          ? offersController
                                                              .offersList[0]
                                                              .description!
                                                              .capitalizeFirstofEach
                                                          : findLanguageController
                                                                  .isArabic
                                                                  .value
                                                              ? offersController
                                                                  .offersList[0]
                                                                  .translations![
                                                                      0]
                                                                  .description!
                                                                  .capitalizeFirstofEach
                                                              : findLanguageController
                                                                      .isTurkish
                                                                      .value
                                                                  ? offersController
                                                                              .offersList[
                                                                                  0]
                                                                              .translations!
                                                                              .length >
                                                                          1
                                                                      ? offersController
                                                                          .offersList[
                                                                              0]
                                                                          .translations![
                                                                              1]
                                                                          .description!
                                                                          .capitalizeFirstofEach
                                                                      : 'no title'
                                                                  : 'no title',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width >
                                                                600
                                                            ? MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.016
                                                            : MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.015,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              ' ${offersController.offersList[0].discount.toString()}% ',
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .pureBlackColor,
                                                            fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width >
                                                                    600
                                                                ? MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.017
                                                                : MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.015,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          recognizer:
                                                              TapGestureRecognizer()
                                                                ..onTap = () =>
                                                                    print(
                                                                        'Tap Here onTap'),
                                                        ),
                                                        TextSpan(
                                                          text: tr('discount'),
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width >
                                                                    600
                                                                ? MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.016
                                                                : MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.015,
                                                          ),
                                                          recognizer:
                                                              TapGestureRecognizer()
                                                                ..onTap = () =>
                                                                    print(
                                                                        'Tap Here onTap'),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
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
  }
}
