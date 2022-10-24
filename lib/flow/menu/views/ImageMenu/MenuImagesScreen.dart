import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:restaurant_app/common/appColors.dart';
import 'package:restaurant_app/flow/menu/views/ImageMenu/imageViewController.dart';
import 'package:restaurant_app/main.dart';

class MenuImagesScreen extends StatelessWidget {
  const MenuImagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imageViewController = Get.put(ImageViewController());
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Obx(
          () => Container(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/sp_bg.png',
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: constraints.maxHeight * 0.04,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Align(
                          alignment: findLanguageController.isEnglish.value ||
                                  findLanguageController.isTurkish.value
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: Container(
                            height: constraints.maxHeight * 0.032,
                            width: constraints.maxWidth * 0.1,
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
                      Align(
                        alignment: findLanguageController.isEnglish.value ||
                                findLanguageController.isTurkish.value
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          height: constraints.maxHeight * 0.032,
                          width: constraints.maxWidth * 0.1,
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Center(
                            child: Text(
                              '${imageViewController.numberOfImage.value + 1}/${imageViewController.galleryItems.length}',
                              style: TextStyle(
                                color: AppColors.pureWhiteColor,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Menu',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.01,
                ),
                Text(
                  'Click to view full size image',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: PhotoViewGallery.builder(
                          scrollPhysics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          builder: (BuildContext context, int index) {
                            return PhotoViewGalleryPageOptions(
                              basePosition: Alignment.center,
                              tightMode: true,
                              imageProvider: AssetImage(
                                  imageViewController.galleryItems[index]),
                              initialScale:
                                  PhotoViewComputedScale.contained * 0.8,
                            );
                          },
                          itemCount: imageViewController.galleryItems.length,
                          loadingBuilder: (context, event) => Center(
                            child: Container(
                              width: 20.0,
                              height: 20.0,
                              child: CircularProgressIndicator(
                                value: event == null
                                    ? 0
                                    : event.cumulativeBytesLoaded /
                                        event.expectedTotalBytes!,
                              ),
                            ),
                          ),
                          backgroundDecoration: BoxDecoration(),
                          pageController: PageController(),
                          onPageChanged: (val) {
                            print(val);

                            imageViewController.numberOfImage.value = val;
                          },
                        ),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.01,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
