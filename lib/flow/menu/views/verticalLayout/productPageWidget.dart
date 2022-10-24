// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/common/capitilizeExtention.dart';
import 'package:restaurant_app/main.dart';
import 'package:restaurant_app/utils/constants.dart';
import '../../../../common/appColors.dart';
import '../../controllers/categoriesProductsApiController.dart';
import '../productDetail/ProductDetailScreen.dart';

class ProductsPageForPageView extends StatefulWidget {
  final CategoriesProductsApiController? categoriesController;
  final String? categoryTitle;
  final int? indexForCategory;

  ProductsPageForPageView({
    // this.allCategoryController,
    this.indexForCategory,
    this.categoryTitle,
    this.categoriesController,
  });

  @override
  State<ProductsPageForPageView> createState() =>
      _ProductsPageForPageViewState();
}

class _ProductsPageForPageViewState extends State<ProductsPageForPageView> {
  var _scrollController = ScrollController();
  List<String?>? thumbnails;
  bool stopScroll = false;

  @override
  void initState() {
    thumbnails = widget.categoriesController!
        .categoriesList[widget.indexForCategory!].products!
        .map((e) => e.tabImage)
        .toList();

    super.initState();
  }

  var formatter = NumberFormat('#,##,000');

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double ratio =
    //     MediaQuery.of(context).size.width / MediaQuery.of(context).size.height;
    var height = Get.height;

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Perform your task
        setState(() {
          stopScroll = true;
        });
      } else if (_scrollController.position.pixels ==
          _scrollController.position.minScrollExtent) {
        setState(() {
          stopScroll = true;
        });
      } else {
        setState(() {
          stopScroll = false;
        });
      }
    });

    return Obx(
      () => Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.005),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 0),
                      child: Text(
                        '${widget.categoryTitle!.capitalizeFirstofEach}',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width > 600
                              ? MediaQuery.of(context).size.height * 0.015
                              : MediaQuery.of(context).size.height * 0.0122,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              widget
                      .categoriesController!
                      .categoriesList[widget.indexForCategory!]
                      .products!
                      .isEmpty
                  ? Expanded(
                      child: Container(
                        color: AppColors.backgroundColor,
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                          child: Text(
                            'no_data',
                          ).tr(),
                        ),
                      ),
                    )
                  : Expanded(
                      child: Container(
                        color: AppColors.backgroundColor,
                        height: MediaQuery.of(context).size.height,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.01),
                          child: GridView.builder(
                            physics: stopScroll
                                ? NeverScrollableScrollPhysics()
                                : ScrollPhysics(),
                            shrinkWrap: false,
                            controller: _scrollController,
                            itemCount: widget
                                .categoriesController!
                                .categoriesList[widget.indexForCategory!]
                                .products!
                                .length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1,
                                    crossAxisSpacing:
                                        MediaQuery.of(context).size.width > 600
                                            ? 6
                                            : 0.0,
                                    mainAxisSpacing: 5),
                            itemBuilder: (context, index) {
                              if (thumbnails != null) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(ProductDetailScreen(
                                      title: findLanguageController
                                              .isEnglish.value
                                          ? widget
                                              .categoriesController!
                                              .categoriesList[
                                                  widget.indexForCategory!]
                                              .products![index]
                                              .title!
                                              .capitalizeFirstofEach
                                          : findLanguageController
                                                  .isArabic.value
                                              ? widget
                                                          .categoriesController!
                                                          .categoriesList[widget
                                                              .indexForCategory!]
                                                          .products![index]
                                                          .translationss!
                                                          .length >
                                                      0
                                                  ? widget
                                                      .categoriesController!
                                                      .categoriesList[widget
                                                          .indexForCategory!]
                                                      .products![index]
                                                      .translationss![0]
                                                      .title!
                                                      .capitalizeFirstofEach
                                                  : 'NO ar title'
                                              : findLanguageController
                                                      .isTurkish.value
                                                  ? widget
                                                              .categoriesController!
                                                              .categoriesList[widget
                                                                  .indexForCategory!]
                                                              .products![index]
                                                              .translationss!
                                                              .length >
                                                          1
                                                      ? widget
                                                          .categoriesController!
                                                          .categoriesList[widget
                                                              .indexForCategory!]
                                                          .products![index]
                                                          .translationss![1]
                                                          .title!
                                                          .capitalizeFirstofEach
                                                      : 'No tr title'
                                                  : 'No title',
                                      description: findLanguageController
                                              .isEnglish.value
                                          ? widget
                                              .categoriesController!
                                              .categoriesList[
                                                  widget.indexForCategory!]
                                              .products![index]
                                              .description!
                                              .capitalizeFirstofEach
                                          : findLanguageController
                                                  .isArabic.value
                                              ? widget
                                                          .categoriesController!
                                                          .categoriesList[widget
                                                              .indexForCategory!]
                                                          .products![index]
                                                          .translationss!
                                                          .length >
                                                      0
                                                  ? widget
                                                      .categoriesController!
                                                      .categoriesList[widget
                                                          .indexForCategory!]
                                                      .products![index]
                                                      .translationss![0]
                                                      .description!
                                                      .capitalizeFirstofEach
                                                  : 'NO ar title'
                                              : findLanguageController
                                                      .isTurkish.value
                                                  ? widget
                                                              .categoriesController!
                                                              .categoriesList[widget
                                                                  .indexForCategory!]
                                                              .products![index]
                                                              .translationss!
                                                              .length >
                                                          1
                                                      ? widget
                                                          .categoriesController!
                                                          .categoriesList[widget
                                                              .indexForCategory!]
                                                          .products![index]
                                                          .translationss![1]
                                                          .description!
                                                          .capitalizeFirstofEach
                                                      : 'No tr title'
                                                  : 'No title',
                                      imagePath: widget
                                          .categoriesController!
                                          .categoriesList[
                                              widget.indexForCategory!]
                                          .products![index]
                                          .tabImage,
                                      price: widget
                                          .categoriesController!
                                          .categoriesList[
                                              widget.indexForCategory!]
                                          .products![index]
                                          .price,
                                      isMealPlanner: AppConstants.fromListing,
                                      extrasFromCategoryProductListing: widget
                                          .categoriesController!
                                          .categoriesList[
                                              widget.indexForCategory!]
                                          .products![index]
                                          .extras,
                                      isChilli: widget
                                          .categoriesController!
                                          .categoriesList[
                                              widget.indexForCategory!]
                                          .products![index]
                                          .chilli,
                                      isHalal: widget
                                          .categoriesController!
                                          .categoriesList[
                                              widget.indexForCategory!]
                                          .products![index]
                                          .halal,
                                      isNew: widget
                                          .categoriesController!
                                          .categoriesList[
                                              widget.indexForCategory!]
                                          .products![index]
                                          .isNew,
                                      isPopular: widget
                                          .categoriesController!
                                          .categoriesList[
                                              widget.indexForCategory!]
                                          .products![index]
                                          .popular,
                                      isVegiterian: widget
                                          .categoriesController!
                                          .categoriesList[
                                              widget.indexForCategory!]
                                          .products![index]
                                          .vegetarian,
                                      time: widget
                                          .categoriesController!
                                          .categoriesList[
                                              widget.indexForCategory!]
                                          .products![index]
                                          .time,
                                      productId: widget
                                          .categoriesController!
                                          .categoriesList[
                                              widget.indexForCategory!]
                                          .products![index]
                                          .id,
                                    ));
                                  },
                                  child: Card(
                                    elevation: 0,
                                    color: Colors.transparent,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: thumbnails![index]!
                                              .replaceAll(' ', '%20')
                                              .trim(),
                                          placeholder: (context, url) => Center(
                                            child: Image.asset(
                                              'assets/no_image.png',
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                            'assets/no_image.png',
                                          ),
                                          fit: BoxFit.fill,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                      .size
                                                      .width >
                                                  600
                                              ? height * 0.135
                                              : height * 0.105,
                                        ),
                                        // Text('product $index'),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.005,
                                        ),
                                        Text(
                                          findLanguageController.isEnglish.value
                                              ? widget
                                                  .categoriesController!
                                                  .categoriesList[
                                                      widget.indexForCategory!]
                                                  .products![index]
                                                  .title!
                                                  .capitalizeFirstofEach
                                              : findLanguageController
                                                      .isArabic.value
                                                  ? widget
                                                              .categoriesController!
                                                              .categoriesList[widget
                                                                  .indexForCategory!]
                                                              .products![index]
                                                              .translationss!
                                                              .length >
                                                          0
                                                      ? widget
                                                          .categoriesController!
                                                          .categoriesList[widget
                                                              .indexForCategory!]
                                                          .products![index]
                                                          .translationss![0]
                                                          .title!
                                                          .capitalizeFirstofEach
                                                      : 'NO ar title'
                                                  : findLanguageController
                                                          .isTurkish.value
                                                      ? widget
                                                                  .categoriesController!
                                                                  .categoriesList[
                                                                      widget
                                                                          .indexForCategory!]
                                                                  .products![
                                                                      index]
                                                                  .translationss!
                                                                  .length >
                                                              1
                                                          ? widget
                                                              .categoriesController!
                                                              .categoriesList[widget
                                                                  .indexForCategory!]
                                                              .products![index]
                                                              .translationss![1]
                                                              .title!
                                                              .capitalizeFirstofEach
                                                          : 'No tr title'
                                                      : 'No title',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
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
                                              fontWeight: FontWeight.w400),
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
                                            child: Text(
                                              '\$${formatter.format(widget.categoriesController!.categoriesList[widget.indexForCategory!].products![index].price)} ',
                                              style: TextStyle(
                                                  fontSize: MediaQuery
                                                                  .of(context)
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
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return SizedBox();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
            ],
          )),
    );
  }
}
