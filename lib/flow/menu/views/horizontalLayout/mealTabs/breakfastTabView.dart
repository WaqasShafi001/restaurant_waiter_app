import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/common/appColors.dart';
import 'package:restaurant_app/common/capitilizeExtention.dart';
import 'package:restaurant_app/flow/menu/controllers/menuProductsController.dart';
import 'package:restaurant_app/flow/menu/views/horizontalLayout/listingLayouts.dart';
import 'package:restaurant_app/flow/menu/views/productDetail/ProductDetailScreen.dart';
import 'package:restaurant_app/main.dart';
import 'package:restaurant_app/utils/constants.dart';

class BreakfastTabView extends StatefulWidget {
  final String? menuType;
  const BreakfastTabView({Key? key, this.menuType}) : super(key: key);

  @override
  State<BreakfastTabView> createState() => _BreakfastTabViewState();
}

class _BreakfastTabViewState extends State<BreakfastTabView> {
  var menuProductController = Get.put(MenuProductsController());

  @override
  void initState() {
    menuProductController.getMenuProducts(menuType: widget.menuType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        alignment: Alignment.center,
        children: [
          menuProductController.listOfMenuProducts.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      Text(
                        'no_data',
                      ).tr(),
                    ],
                  ),
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 7 / 6,
                      crossAxisSpacing: 8,
                      // mainAxisExtent: 250,
                      mainAxisSpacing: 8),
                  itemCount: menuProductController.listOfMenuProducts.length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (BuildContext context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(ProductDetailScreen(
                          title: findLanguageController.isEnglish.value
                              ? '${menuProductController.listOfMenuProducts[index].title!.capitalizeFirstofEach}'
                              : findLanguageController.isArabic.value
                                  ? menuProductController
                                              .listOfMenuProducts[index]
                                              .translations!
                                              .length >
                                          0
                                      ? '${menuProductController.listOfMenuProducts[index].translations![0].title!.capitalizeFirstofEach}'
                                      : 'No title'
                                  : findLanguageController.isTurkish.value
                                      ? menuProductController
                                                  .listOfMenuProducts[index]
                                                  .translations!
                                                  .length >
                                              1
                                          ? '${menuProductController.listOfMenuProducts[index].translations![1].title!.capitalizeFirstofEach}'
                                          : 'No title'
                                      : 'No TITLE',
                          description: findLanguageController.isEnglish.value
                              ? '${menuProductController.listOfMenuProducts[index].description!.capitalizeFirstofEach}'
                              : findLanguageController.isArabic.value
                                  ? menuProductController
                                              .listOfMenuProducts[index]
                                              .translations!
                                              .length >
                                          0
                                      ? '${menuProductController.listOfMenuProducts[index].translations![0].description!.capitalizeFirstofEach}'
                                      : 'no desc'
                                  : findLanguageController.isTurkish.value
                                      ? menuProductController
                                                  .listOfMenuProducts[index]
                                                  .translations!
                                                  .length >
                                              1
                                          ? '${menuProductController.listOfMenuProducts[index].translations![1].description!.capitalizeFirstofEach}'
                                          : 'no desc'
                                      : "NO DESC",
                          imagePath: menuProductController
                              .listOfMenuProducts[index].tabImage,
                          price: menuProductController
                              .listOfMenuProducts[index].price,
                          isHalal: menuProductController
                              .listOfMenuProducts[index].halal,
                          isChilli: menuProductController
                              .listOfMenuProducts[index].chilli,
                          isNew: menuProductController
                              .listOfMenuProducts[index].is_new,
                          isPopular: menuProductController
                              .listOfMenuProducts[index].popular,
                          isVegiterian: menuProductController
                              .listOfMenuProducts[index].vegetarian,
                          time: menuProductController
                              .listOfMenuProducts[index].time,
                          extrasFromMealPlanner: menuProductController
                              .listOfMenuProducts[index].extras,
                          isMealPlanner: AppConstants.fromMeal,
                          productId: menuProductController.listOfMenuProducts[index].id,
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        child: CachedNetworkImage(
                                          imageUrl: menuProductController
                                              .listOfMenuProducts[index]
                                              .tabImage!,
                                          fit: BoxFit.fill,
                                          height: constraints.maxHeight,
                                          width: constraints.maxWidth,
                                          placeholder: (context, url) => Center(
                                            child: Image.asset(
                                              'assets/no_image.png',
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Center(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 7,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                findLanguageController
                                                        .isEnglish.value
                                                    ? '${menuProductController.listOfMenuProducts[index].title!.capitalizeFirstofEach}'
                                                    : findLanguageController
                                                            .isArabic.value
                                                        ? menuProductController
                                                                    .listOfMenuProducts[
                                                                        index]
                                                                    .translations!
                                                                    .length >
                                                                0
                                                            ? '${menuProductController.listOfMenuProducts[index].translations![0].title!.capitalizeFirstofEach}'
                                                            : 'No title'
                                                        : findLanguageController
                                                                .isTurkish.value
                                                            ? menuProductController
                                                                        .listOfMenuProducts[
                                                                            index]
                                                                        .translations!
                                                                        .length >
                                                                    1
                                                                ? '${menuProductController.listOfMenuProducts[index].translations![1].title!.capitalizeFirstofEach}'
                                                                : 'No title'
                                                            : 'No TITLE',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: MediaQuery.of(
                                                                  context)
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
                                                '\$${formatter.format(menuProductController.listOfMenuProducts[index].price)}',
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
                ),
          menuProductController.isLoading.value
              ? Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
