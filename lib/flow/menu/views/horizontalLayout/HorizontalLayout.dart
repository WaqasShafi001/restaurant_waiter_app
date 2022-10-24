import 'package:flutter/material.dart';
import 'package:restaurant_app/common/capitilizeExtention.dart';
import 'package:restaurant_app/flow/menu/views/horizontalLayout/scrollableListTabView/model/listTab.dart';
import 'package:restaurant_app/flow/menu/views/horizontalLayout/scrollableListTabView/model/scrollable_list_tab.dart';
import 'package:restaurant_app/flow/menu/views/horizontalLayout/scrollableListTabView/scrollable_list_tabView.dart';
import 'package:restaurant_app/main.dart';
import '../../../../common/appColors.dart';
import '../../controllers/categoriesProductsApiController.dart';
import 'listingLayouts.dart';

class HorizontalLayout extends StatelessWidget {
  final BoxConstraints? constraints;
  final CategoriesProductsApiController? categoriesController;
  const HorizontalLayout({
    Key? key,
    this.constraints,
    this.categoriesController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();

    return CustomScrollView(
      controller: scrollController,
      shrinkWrap: true,
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Container(
            height: constraints!.maxHeight,
            width: constraints!.maxWidth,
            color: AppColors.backgroundColor,
            child: ScrollableListTabView(
              bodyAnimationCurve: Curves.easeOut,
              totalLentgh: categoriesController!.categoriesList.length,
              bodyAnimationDuration: const Duration(milliseconds: 500),
              tabAnimationCurve: Curves.easeOut,
              labelBottomLineColor: AppColors.mainColor,
              tabAnimationDuration: const Duration(milliseconds: 500),
              tabBackgroundColor: AppColors.backgroundColor,
              tabHeight: constraints!.maxHeight * 0.17,
              selectedtabHeight: constraints!.maxHeight * 0.12,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width > 600
                    ? MediaQuery.of(context).size.height * 0.0135
                    : MediaQuery.of(context).size.height * 0.013,
              ),
              unselectedTabHeight: constraints!.maxHeight * 0.09,
              selectedTabWidth: constraints!.maxWidth * 0.24,
              unSelectedTabWidth: constraints!.maxWidth * 0.24,
              categoryDescription: 'description',
              categoryLabel: 'label',
              tabs: List.generate(
                categoriesController!.categoriesList.length,
                (index) => ScrollableListTab(
                  tab: ListTab(
                    imagePath:
                        categoriesController!.categoriesList[index].tabImage,
                    label: findLanguageController.isEnglish.value
                        ? categoriesController!
                            .categoriesList[index].title!.capitalizeFirstofEach
                        : findLanguageController.isArabic.value
                            ? categoriesController!.categoriesList[index]
                                .translations![0].title!.capitalizeFirstofEach
                            : findLanguageController.isTurkish.value
                                ? categoriesController!.categoriesList[index]
                                            .translations!.length >
                                        1
                                    ? categoriesController!
                                        .categoriesList[index]
                                        .translations![1]
                                        .title!
                                        .capitalizeFirstofEach
                                    : 'no title'
                                : 'no title',
                    slogan: findLanguageController.isEnglish.value
                        ? categoriesController!
                            .categoriesList[index].slogan!.capitalizeFirstofEach
                        : findLanguageController.isArabic.value
                            ? categoriesController!.categoriesList[index]
                                .translations![0].slogan!.capitalizeFirstofEach
                            : findLanguageController.isTurkish.value
                                ? categoriesController!.categoriesList[index]
                                            .translations!.length >
                                        1
                                    ? categoriesController!
                                        .categoriesList[index]
                                        .translations![1]
                                        .slogan!
                                        .capitalizeFirstofEach
                                    : 'No title'
                                : 'no slogan',
                  ),
                  body: categoriesController!
                              .categoriesList[index].listingLayout ==
                          1
                      ? TwoProductsInRowLayout(
                          constraints: constraints,
                          products: categoriesController!
                              .categoriesList[index].products,
                          // quantityOfItems: quantity,
                        )
                      : categoriesController!
                                  .categoriesList[index].listingLayout ==
                              2
                          ? SingleProductInRowLayout(
                              constraints: constraints,
                              products: categoriesController!
                                  .categoriesList[index].products,
                            )
                          : categoriesController!
                                      .categoriesList[index].listingLayout ==
                                  3
                              ? FiveProductsInRowLayout(
                                  constraints: constraints,
                                  products: categoriesController!
                                      .categoriesList[index].products,
                                )
                              : categoriesController!.categoriesList[index]
                                          .listingLayout ==
                                      4
                                  ? ThreeProductsInRowLayout(
                                      products: categoriesController!
                                          .categoriesList[index].products,
                                    )
                                  : ListView(),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
