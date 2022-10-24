// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:restaurant_app/common/capitilizeExtention.dart';
import 'package:restaurant_app/main.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../controllers/categoriesProductsApiController.dart';
import 'categoryPageController.dart';
import 'productPageWidget.dart';

class ProductSection extends StatefulWidget {
  final double? height;
  final double? width;
  final ItemScrollController? scrollController;
  final GetPageController? putPageController;
  final CategoriesProductsApiController? categoriesController;
  final PageController? pageController;

  const ProductSection({
    Key? key,
    this.scrollController,
    this.putPageController,
    // this.allCategoryController,
    this.pageController,
    this.height,
    this.width,
    this.categoriesController,
  }) : super(key: key);

  @override
  State<ProductSection> createState() => _ProductSectionState();
}

class _ProductSectionState extends State<ProductSection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: PageView.builder(
        // physics: NeverScrollableScrollPhysics(),
        onPageChanged: (value) {
          widget.putPageController!.selectedIndex.value = value;
          widget.scrollController!.scrollTo(
            index: value,
            alignment: 0,

            /// aligment set
            ///
            // value == 0
            //     ? 0.0
            //     : value == 1
            //         ? 0.15
            //         : value == 2
            //             ? 0.25
            //             : value ==
            //                     widget.allCategoryController!.categoriesList
            //                             .indexOf(widget.allCategoryController!
            //                                 .categoriesList.last) -
            //                         1
            //                 ? 0.55
            //                 : value ==
            //                         widget.allCategoryController!.categoriesList
            //                             .indexOf(widget.allCategoryController!
            //                                 .categoriesList.last)
            //                     ? 0.7
            //                     : 0.4,
            curve: Curves.linear,
            duration: Duration(
              milliseconds: 700,
            ),
          );
        },
        controller: widget.pageController,
        itemBuilder: (context, index) {
          return ProductsPageForPageView(
            // allCategoryController: widget.allCategoryController,
            categoriesController: widget.categoriesController,

            categoryTitle: findLanguageController.isEnglish.value
                ? widget.categoriesController!.categoriesList[index].title!
                    .capitalizeFirstofEach
                : findLanguageController.isArabic.value
                    ? widget.categoriesController!.categoriesList[index]
                                .translations!.length >
                            0
                        ? widget.categoriesController!.categoriesList[index]
                            .translations![0].title!.capitalizeFirstofEach
                        : 'No ar title'
                    : findLanguageController.isTurkish.value
                        ? widget.categoriesController!.categoriesList[index]
                                    .translations!.length >
                                1
                            ? widget.categoriesController!.categoriesList[index]
                                .translations![1].title!.capitalizeFirstofEach
                            : 'No tr title'
                        : '',

            indexForCategory: index,
          );
        },
        scrollDirection: Axis.vertical,
        itemCount: widget.categoriesController!.categoriesList.length,
      ),
    );
  }
}
