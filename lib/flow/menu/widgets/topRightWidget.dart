import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/appColors.dart';
import '../controllers/layoutChangeController.dart';
import '../views/ImageMenu/MenuImagesScreen.dart';

class TopLeftWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final LayoutChangeController? controller;
  const TopLeftWidget({Key? key, this.height, this.width, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
            width: width! * 0.23,
            height: height! * 0.046,
            decoration: BoxDecoration(
              color: Colors.grey.shade200.withOpacity(0.5),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(MenuImagesScreen());
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: Container(
                        height: height! * 0.032,
                        width: width! * 0.1,
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: Icon(
                          Icons.dining_outlined,
                          color: AppColors.pureWhiteColor,
                        )),
                  ),
                ),
                Obx(
                  () => InkWell(
                    onTap: () {
                      controller!.verticalLayout.value =
                          !controller!.verticalLayout.value;          
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: Container(
                        height: height! * 0.032,
                        width: width! * 0.1,
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: Image.asset(
                          controller!.verticalLayout.value
                              ? 'assets/horizontalIcon.png'
                              : 'assets/verticalIcon.png',
                          color: AppColors.pureWhiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
                // InkWell(
                //   onTap: () {
                //     controller!.verticalLayout.value = true;
                //   },
                //   child: Card(
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.all(
                //         Radius.circular(8),
                //       ),
                //     ),
                //     child: Container(
                //       height: height! * 0.032,
                //       width: width! * 0.1,
                //       decoration: BoxDecoration(
                //         color: AppColors.mainColor,
                //         borderRadius: BorderRadius.all(
                //           Radius.circular(8),
                //         ),
                //       ),
                //       child: Image.asset(
                //         'assets/verticalIcon.png',
                //         color: AppColors.pureWhiteColor,
                //       ),
                //     ),
                //   ),
                // )
              ],
            )),
      ),
    );
  }
}
