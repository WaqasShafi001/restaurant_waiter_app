// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/common/capitilizeExtention.dart';
import 'package:restaurant_app/main.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../../common/appColors.dart';
import '../../../../common/sizeConfig.dart';
import '../../controllers/categoriesProductsApiController.dart';
import 'categoryPageController.dart';

class CategorySection extends StatefulWidget {
  final double? height;
  final double? width;
  final CategoriesProductsApiController? categoriesController;
  final ItemScrollController? scrollController;
  final PageController? pageController;
  final GetPageController? putPageController;
  const CategorySection({
    Key? key,
    this.height,
    this.width,
    this.scrollController,
    this.pageController,
    this.putPageController,
    this.categoriesController,
  }) : super(key: key);

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      color: AppColors.backgroundColor,
      width: widget.width! * 0.3,
      height: widget.height,
      child: ScrollablePositionedList.builder(
        itemCount: widget.categoriesController!.categoriesList.length + 1,
        shrinkWrap: true,
        itemScrollController: widget.scrollController,
        initialAlignment: 0,
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          if (index == widget.categoriesController!.categoriesList.length) {
            return InkWell(
              onTap: () {
                widget.scrollController!.jumpTo(index: 0, alignment: 0.0);

                widget.pageController!.animateToPage(0,
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.easeIn);
              },
              child: Padding(
                padding: EdgeInsets.only(
                  top: widget.height! * 0.01,
                ),
                child: Container(
                  height: widget.height! * 0.12,
                  width: widget.width,
                  color: AppColors.mainColor.withOpacity(0.5),
                  child: Padding(
                    padding: EdgeInsets.all(widget.height! * 0.025),
                    child: CircleAvatar(
                      backgroundColor: AppColors.pureWhiteColor,
                      child: Icon(
                        Icons.arrow_upward_sharp,
                        color: AppColors.mainColor,
                        size: widget.height! * 0.03,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return InkWell(
            onTap: () {
              widget.scrollController!.scrollTo(
                  index: widget.putPageController!.selectedIndex.value,
                  curve: Curves.linear,
                  alignment: 0,
                  // index == 0
                  //     ? 0.0
                  //     : index == 1
                  //         ? 0.12
                  //         : index == 2
                  //             ? 0.24
                  //             : index ==
                  //                     widget.allCategoryController!
                  //                             .categoriesList
                  //                             .indexOf(widget
                  //                                 .allCategoryController!
                  //                                 .categoriesList
                  //                                 .last) -
                  //                         1
                  //                 ? 0.6
                  //                 : index ==
                  //                         widget.allCategoryController!
                  //                             .categoriesList
                  //                             .indexOf(widget
                  //                                 .allCategoryController!
                  //                                 .categoriesList
                  //                                 .last)
                  //                     ? 0.7
                  //                     : 0.5,
                  duration: Duration(milliseconds: 700));
              widget.putPageController!.selectedIndex.value = index;
              widget.pageController!.jumpToPage(
                widget.putPageController!.selectedIndex.value,
              );
            },

            //// wrap with obx here
            child: Obx(
              () => Padding(
                padding: MediaQuery.of(context).size.width > 600
                    ? const EdgeInsets.symmetric(horizontal: 14, vertical: 4)
                    : const EdgeInsets.all(0.0),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 700),
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.width > 600
                      ? SizeConfig.blockSizeVertical! * 20.9
                      : SizeConfig.blockSizeVertical! * 20.5,
                  // width: width! * 0.3,

                  width: SizeConfig.blockSizeHorizontal! * 30,
                  // bg color
                  color: widget.putPageController!.selectedIndex.value == index
                      ? AppColors.mainColor.withOpacity(0.1)
                      : AppColors.backgroundColor,
                  child: Stack(
                    alignment: AlignmentDirectional.topCenter,
                    clipBehavior: Clip.antiAlias,
                    children: [
                      // Align(
                      //   alignment: Alignment.topCenter,
                      //   child: Padding(
                      //     padding:
                      //         const EdgeInsets.symmetric(horizontal: 4),
                      //     child: Container(
                      //       height: MediaQuery.of(context).size.width > 600
                      //           ? SizeConfig.blockSizeVertical! * 19.5
                      //           : SizeConfig.blockSizeVertical! * 20,
                      //       // width: MediaQuery.of(context).size.width > 600
                      //       //     ? width! * 0.3
                      //       //     : width! * 0.24,
                      //       width: SizeConfig.blockSizeHorizontal! * 28,
                      //       decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         shape: BoxShape.circle,
                      //         border: Border.all(
                      //           color: Colors.green,
                      //           width:
                      //               SizeConfig.blockSizeHorizontal! * 1.5,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),capitalizeFirstofEach
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 700),
                          alignment: Alignment.center,
                          // height: MediaQuery.of(context).size.width > 600
                          //     ? height! * 0.165
                          //     : height! * 0.13,
                          // width: width! * 0.3,
                          height: MediaQuery.of(context).size.width > 600
                              ? SizeConfig.blockSizeVertical! * 17
                              : SizeConfig.blockSizeVertical! * 12.5,
                          decoration: BoxDecoration(
                            // bg for under circle image
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                findLanguageController.isEnglish.value
                                    ? widget
                                        .categoriesController!
                                        .categoriesList[index]
                                        .title!
                                        .capitalizeFirstofEach
                                    : findLanguageController.isArabic.value
                                        ? widget
                                                    .categoriesController!
                                                    .categoriesList[index]
                                                    .translations!
                                                    .length >
                                                0
                                            ? widget
                                                .categoriesController!
                                                .categoriesList[index]
                                                .translations![0]
                                                .title!
                                                .capitalizeFirstofEach
                                            : 'No ar title'
                                        : findLanguageController.isTurkish.value
                                            ? widget
                                                        .categoriesController!
                                                        .categoriesList[index]
                                                        .translations!
                                                        .length >
                                                    1
                                                ? widget
                                                    .categoriesController!
                                                    .categoriesList[index]
                                                    .translations![1]
                                                    .title!
                                                    .capitalizeFirstofEach
                                                : 'No tr title'
                                            : '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.width > 600
                                          ? MediaQuery.of(context).size.height *
                                              0.016
                                          : MediaQuery.of(context).size.height *
                                              0.015,
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical! * 0.5,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        // top: MediaQuery.of(context).size.width > 600
                        //     ? height! * 0.013
                        //     : height! * 0.024,
                        top: MediaQuery.of(context).size.width > 600
                            ? SizeConfig.blockSizeVertical! * 1.8
                            : SizeConfig.blockSizeVertical! * 3.4,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            // height: height! * 0.15,
                            // width: width! * 0.23,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 0),
                              boxShadow: [
                                // BoxShadow(
                                //   offset: Offset(-1, 2),
                                //   blurRadius: 1,
                                //   blurStyle: BlurStyle.normal,
                                //   spreadRadius: 0.1,
                                //   color: Colors.black26,
                                // ),
                              ],
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                                border: Border.all(
                                  color: widget.putPageController!.selectedIndex
                                              .value ==
                                          index
                                      ? AppColors.mainColor
                                      : AppColors.mainColor.withOpacity(0.4),
                                  width: 3,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: AvatarView(
                                  // radius: MediaQuery.of(context).size.width > 600
                                  //     ? width! * 0.113
                                  //     : width! * 0.1,
                                  radius: MediaQuery.of(context).size.width >
                                          600
                                      ? SizeConfig.blockSizeHorizontal! * 11
                                      : SizeConfig.blockSizeHorizontal! * 11.5,
                                  borderColor: AppColors.pureWhiteColor,
                                  borderWidth: 1,
                                  avatarType: AvatarType.CIRCLE,
                                  backgroundColor: AppColors.pureWhiteColor,
                                  imagePath:
                                      //thumbnail image path

                                      // widget
                                      //         .allCategoryController!
                                      //         .categoriesList[index]
                                      //         .thumbnail ??
                                      //     '',
                                      widget.categoriesController!
                                          .categoriesList[index].tabImage!,
                                  placeHolder: Center(
                                    child: Image.asset(
                                      'assets/no_image.png',
                                    ),
                                  ),
                                  errorWidget: Center(
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
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
