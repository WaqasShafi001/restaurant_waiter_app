// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/common/appColors.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../controllers/categoriesProductsApiController.dart';
import '../../widgets/discountOffersWidget.dart';
import 'categoryPageController.dart';
import 'categorySection.dart';
import 'productSection.dart';

class VerticalLayout extends StatefulWidget {
  final CategoriesProductsApiController? categoriesController;

  const VerticalLayout({Key? key, this.categoriesController}) : super(key: key);

  @override
  State<VerticalLayout> createState() => _VerticalLayoutState();
}

class _VerticalLayoutState extends State<VerticalLayout> {
  PageController pageController = PageController();
  var putPageController = Get.put(GetPageController());
  ItemScrollController scrollController = ItemScrollController();

  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) => Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: Column(
            children: [
              FadeInDown(
                duration: Duration(milliseconds: 300),
                child: AnimatedContainer(
                  duration: Duration(microseconds: 300),
                  child: DiscountOffersWidget(
                    height: isVisible
                        ? MediaQuery.of(context).size.height
                        : MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width,
                    isVisible: isVisible,
                  ),
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.012,
              ),
              widget.categoriesController!.categoriesList.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Text('No Vertical Product Listing'),
                      ),
                    )
                  : Expanded(
                      child: Row(
                        children: [
                          FadeInLeft(
                            duration: Duration(milliseconds: 700),
                            child: CategorySection(
                              height: constraints.maxHeight,
                              width: constraints.maxWidth,
                              categoriesController: widget.categoriesController,
                              pageController: pageController,
                              putPageController: putPageController,
                              scrollController: scrollController,
                            ),
                          ),

                          // products 70%-width pages
                          Listener(
                            onPointerMove: (moveEvent) {
                              if (moveEvent.delta.dy > 0) {
                                print("swipe down");
                                setState(() {
                                  isVisible = true;
                                });
                              } else if (moveEvent.delta.dy < 0) {
                                setState(() {
                                  isVisible = false;
                                });
                              }
                            },
                            child: FadeInUp(
                              duration: Duration(milliseconds: 1000),
                              child: ProductSection(
                                  // allCategoryController: allCategoryController,
                                  categoriesController:
                                      widget.categoriesController,
                                  height: constraints.maxHeight,
                                  pageController: pageController,
                                  putPageController: putPageController,
                                  scrollController: scrollController,
                                  width: constraints.maxWidth
                                  // lastIndex: allCategoryController.categoriesList
                                  //     .indexOf(
                                  //         allCategoryController.categoriesList.last),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
