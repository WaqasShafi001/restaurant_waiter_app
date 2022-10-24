import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/common/appColors.dart';
import 'package:restaurant_app/common/capitilizeExtention.dart';
import 'package:restaurant_app/flow/menu/views/horizontalLayout/listingLayouts.dart';
import 'package:restaurant_app/flow/menu/views/productDetail/ProductDetailScreen.dart';
import 'package:restaurant_app/flow/search/controller/searchController.dart';
import 'package:restaurant_app/utils/constants.dart';

import '../../main.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;
    final focusNode = FocusNode();
    var searchController = Get.put(SearchController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: width * 0.026, right: width * 0.026),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: height * 0.032,
                      width: width * 0.1,
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
                SizedBox(
                  height: height * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: Card(
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      controller: searchController.searchTxtController,
                      cursorColor: AppColors.mainColor,
                      textInputAction: TextInputAction.done,
                      onChanged: (val) {
                        print(val);
                        searchController.searchProducts(
                          title: val,
                        );
                      },
                      // onEditingComplete: () {
                      //   searchController.searchProducts();
                      // },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.lightGrayColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.mainColor, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.lightGrayColor, width: 1.0),
                        ),
                        contentPadding: EdgeInsets.only(left: 10),
                        hintText: 'Example : Burger',
                        hintStyle: TextStyle(
                          color: AppColors.lightGrayColor,
                        ),
                        prefixIcon: Image.asset('assets/search.png'),
                        suffixIcon: InkWell(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            searchController.showFilter.value = true;
                            // focusNode.canRequestFocus = false;
                            searchController.getAllTags();
                          },
                          child: Image.asset(
                            'assets/filterBtn.png',
                          ),
                        ),
                      ),
                      showCursor: true,
                      // controller:
                      textAlignVertical: TextAlignVertical.center,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    child: searchController.allSearchedProducts.isEmpty
                        ?
                        // ListView.builder(
                        //     itemBuilder: (context, index) => Container(
                        //       height: height * 0.05,
                        //       width: width,
                        //       color: Colors.transparent,
                        //       child: Center(
                        //         child: Text(
                        //           'no_data',
                        //         ).tr(),
                        //       ),
                        //     ),
                        //     itemCount: 1,
                        //     shrinkWrap: true,
                        //     physics: NeverScrollableScrollPhysics(),
                        //   )
                        Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount:
                                searchController.allSearchedProducts.length,
                            itemBuilder: (_, index) => Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: InkWell(
                                onTap: () {
                                  Get.to(ProductDetailScreen(
                                    title: findLanguageController
                                            .isEnglish.value
                                        ? '${searchController.allSearchedProducts[index].title!.capitalizeFirstofEach}'
                                        : findLanguageController.isArabic.value
                                            ? searchController
                                                        .allSearchedProducts[
                                                            index]
                                                        .translations!
                                                        .length >
                                                    0
                                                ? '${searchController.allSearchedProducts[index].translations![0].title!.capitalizeFirstofEach}'
                                                : 'No title'
                                            : findLanguageController
                                                    .isTurkish.value
                                                ? searchController
                                                            .allSearchedProducts[
                                                                index]
                                                            .translations!
                                                            .length >
                                                        1
                                                    ? '${searchController.allSearchedProducts[index].translations![1].title!.capitalizeFirstofEach}'
                                                    : 'No title'
                                                : 'No TITLE',
                                    description: findLanguageController
                                            .isEnglish.value
                                        ? '${searchController.allSearchedProducts[index].description!.capitalizeFirstofEach}'
                                        : findLanguageController.isArabic.value
                                            ? searchController
                                                        .allSearchedProducts[
                                                            index]
                                                        .translations!
                                                        .length >
                                                    0
                                                ? '${searchController.allSearchedProducts[index].translations![0].description!.capitalizeFirstofEach}'
                                                : 'no desc'
                                            : findLanguageController
                                                    .isTurkish.value
                                                ? searchController
                                                            .allSearchedProducts[
                                                                index]
                                                            .translations!
                                                            .length >
                                                        1
                                                    ? '${searchController.allSearchedProducts[index].translations![1].description!.capitalizeFirstofEach}'
                                                    : 'no desc'
                                                : "NO DESC",
                                    imagePath: searchController
                                        .allSearchedProducts[index].tabImage,
                                    price: searchController
                                        .allSearchedProducts[index].price,
                                    isMealPlanner: AppConstants.fromSearch,
                                    extrasFromSearch: searchController
                                        .allSearchedProducts[index].extras,
                                    isChilli: searchController
                                        .allSearchedProducts[index].chilli,
                                    isHalal: searchController
                                        .allSearchedProducts[index].halal,
                                    isNew: searchController
                                        .allSearchedProducts[index].isNew,
                                    isPopular: searchController
                                        .allSearchedProducts[index].popular,
                                    isVegiterian: searchController
                                        .allSearchedProducts[index].vegetarian,
                                    time: searchController
                                        .allSearchedProducts[index].time,
                                    productId: searchController
                                        .allSearchedProducts[index].id,
                                  ));
                                },
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  child: Container(
                                    height: height * 0.09,
                                    decoration: BoxDecoration(
                                      color: AppColors.pureWhiteColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      child: Row(
                                        children: [
                                          Flexible(
                                            flex: 2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Container(
                                                color: AppColors.lightGrayColor,
                                                child: CachedNetworkImage(
                                                  imageUrl: searchController
                                                      .allSearchedProducts[
                                                          index]
                                                      .tabImage!,
                                                  fit: BoxFit.fill,
                                                  height: height,
                                                  width: width,
                                                  placeholder: (context, url) =>
                                                      Center(
                                                    child: Image.asset(
                                                      'assets/no_image.png',
                                                    ),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Center(
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    findLanguageController
                                                            .isEnglish.value
                                                        ? '${searchController.allSearchedProducts[index].title!.capitalizeFirstofEach}'
                                                        : findLanguageController
                                                                .isArabic.value
                                                            ? searchController
                                                                        .allSearchedProducts[
                                                                            index]
                                                                        .translations!
                                                                        .length >
                                                                    0
                                                                ? '${searchController.allSearchedProducts[index].translations![0].title!.capitalizeFirstofEach}'
                                                                : 'No title'
                                                            : findLanguageController
                                                                    .isTurkish
                                                                    .value
                                                                ? searchController
                                                                            .allSearchedProducts[index]
                                                                            .translations!
                                                                            .length >
                                                                        1
                                                                    ? '${searchController.allSearchedProducts[index].translations![1].title!.capitalizeFirstofEach}'
                                                                    : 'No title'
                                                                : 'No TITLE',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize:
                                                          MediaQuery.of(
                                                                          _)
                                                                      .size
                                                                      .width >
                                                                  600
                                                              ? MediaQuery.of(_)
                                                                      .size
                                                                      .height *
                                                                  0.0145
                                                              : MediaQuery.of(_)
                                                                      .size
                                                                      .height *
                                                                  0.013,
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
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(6),
                                                        ),
                                                        color: AppColors
                                                            .deepPurpleColor
                                                            .withOpacity(0.7)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              6.0),
                                                      child: Text(
                                                        '\$${formatter.format(searchController.allSearchedProducts[index].price)}',
                                                        style: TextStyle(
                                                            fontSize: MediaQuery
                                                                            .of(
                                                                                _)
                                                                        .size
                                                                        .width >
                                                                    600
                                                                ? MediaQuery.of(
                                                                            _)
                                                                        .size
                                                                        .height *
                                                                    0.014
                                                                : MediaQuery.of(
                                                                            _)
                                                                        .size
                                                                        .height *
                                                                    0.013,
                                                            color: AppColors
                                                                .mainColor),
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
                          ),
                  ),
                ),
              ],
            ),
            searchController.showFilter.value
                ? Container(
                    height: height * 0.5,
                    width: width,
                    color: AppColors.mainColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: height * 0.015,
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            color: AppColors.mainColor,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.02),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Center(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/filterIcon2.png',
                                        ),
                                        SizedBox(
                                          width: width * 0.01,
                                        ),
                                        Text(
                                          'filter',
                                          style: TextStyle(
                                            color: AppColors.pureWhiteColor,
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
                                                    0.014,
                                          ),
                                        ).tr(),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => searchController.resetSearch(),
                                    child: Text(
                                      'reset',
                                      style: TextStyle(
                                        color: AppColors.pureWhiteColor,
                                        fontSize:
                                            MediaQuery.of(context).size.width >
                                                    600
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.017
                                                : MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.014,
                                      ),
                                    ).tr(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 8,
                          child: Container(
                            color: AppColors.pureWhiteColor,
                            child: Column(
                              crossAxisAlignment:
                                  findLanguageController.isEnglish.value ||
                                          findLanguageController.isTurkish.value
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.end,
                              children: [
                                Container(
                                  height: height * 0.035,
                                  child: Align(
                                    alignment: findLanguageController
                                                .isEnglish.value ||
                                            findLanguageController
                                                .isTurkish.value
                                        ? Alignment.centerLeft
                                        : Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: width * 0.01,
                                          right: width * 0.01),
                                      child: Text(
                                        'filter_your_search',
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width >
                                                  600
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.015
                                              : MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.014,
                                        ),
                                      ).tr(),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: width,
                                  height: 1,
                                  color: AppColors.darkGrayColor,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.01,
                                      vertical: height * 0.01),
                                  child: Container(
                                    height: height * 0.04,
                                    width: width,
                                    color: Colors.transparent,
                                    child: searchController.allTags.isEmpty
                                        ? Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              height: height * 0.03,
                                              width: width * 0.1,
                                              decoration: BoxDecoration(
                                                color: AppColors.mainColor,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(8),
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'No tag',
                                                  style: TextStyle(
                                                    color: AppColors
                                                        .pureWhiteColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : ListView.builder(
                                            itemCount:
                                                searchController.allTags.length,
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) =>
                                                Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4, vertical: 4),
                                              child: Center(
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      searchController
                                                          .selectedTagsByIndex(
                                                              index);
                                                    });

                                                    print(
                                                        'this is list of selected tags =---=-=-= ${searchController.selesctedTags}');
                                                  },
                                                  child: Chip(
                                                    backgroundColor:
                                                        searchController
                                                                .selesctedTags
                                                                .value
                                                                .contains(index)
                                                            ? AppColors
                                                                .mainColor
                                                            : AppColors
                                                                .mainColor
                                                                .withOpacity(
                                                                    0.4),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8))),
                                                    label: Center(
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    width *
                                                                        0.01),
                                                        child: Text(
                                                          searchController
                                                              .allTags[index]
                                                              .name!,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .pureWhiteColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    padding: EdgeInsets.zero,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                                RadioListTile<String>(
                                  value: 'All Menu',
                                  groupValue: '',
                                  onChanged: (val) {},
                                  activeColor: AppColors.mainColor,
                                  title: Text(
                                    'All Menu',
                                  ),
                                ),
                                RadioListTile<String>(
                                  value: 'Breakfast',
                                  groupValue: '',
                                  onChanged: (val) {},
                                  activeColor: AppColors.mainColor,
                                  title: Text(
                                    'Breakfast',
                                  ),
                                ),
                                RadioListTile<String>(
                                  value: 'Lunch',
                                  groupValue: '',
                                  onChanged: (val) {},
                                  activeColor: AppColors.mainColor,
                                  title: Text(
                                    'Lunch',
                                  ),
                                ),
                                RadioListTile<String>(
                                  value: 'Dinner',
                                  groupValue: '',
                                  onChanged: (val) {},
                                  activeColor: AppColors.mainColor,
                                  title: Text(
                                    'Dinner',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            color: AppColors.mainColor,
                            child: InkWell(
                              onTap: () {
                                searchController.showFilter.value = false;
                                // searchController.getNewListOfTagsById(searchController.selesctedTags);
                                print(
                                    'this is text controllr txt -=-= ${searchController.searchTxtController.text}');

                                searchController.searchProductsWithTags(
                                  title:
                                      searchController.searchTxtController.text,
                                );
                              },
                              child: Center(
                                child: Text(
                                  'refine_search',
                                  style: TextStyle(
                                    color: AppColors.pureWhiteColor,
                                    fontSize: MediaQuery.of(context)
                                                .size
                                                .width >
                                            600
                                        ? MediaQuery.of(context).size.height *
                                            0.015
                                        : MediaQuery.of(context).size.height *
                                            0.014,
                                  ),
                                ).tr(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
