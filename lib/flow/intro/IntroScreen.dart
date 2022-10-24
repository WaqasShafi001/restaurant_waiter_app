import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/common/appColors.dart';
import 'package:restaurant_app/flow/intro/widgets/introOne.dart';
import 'package:restaurant_app/flow/intro/widgets/introThree.dart';
import 'package:restaurant_app/flow/intro/widgets/introTwo.dart';
import '../../widgets/commonButton.dart';
import '../venuInfo/venuInfoScreen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int currentIndex = 0;
  List listdot = [1, 2, 3];
  PageController pageController = PageController();
  List<Widget> listOfWidget = [IntroOne(), IntroTwo(), IntroThree()];

  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Container(
        height: height,
        width: width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/sp_bg.png',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            PageView.builder(
              itemBuilder: (c, index) => listOfWidget[index],
              controller: pageController,
              itemCount: listOfWidget.length,
              physics: PageScrollPhysics(),
              scrollDirection: Axis.horizontal,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
            Positioned(
              bottom: height * 0.05,
              child: Column(
                children: [
                  Row(
                    children: listdot.map((e) {
                      int index = listdot.indexOf(e);
                      return currentIndex == index
                          ? Container(
                              height: 10,
                              width: 10,
                              margin: EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.mainColor),
                            )
                          : Container(
                              height: 10,
                              width: 10,
                              margin: EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.lightGrayColor,
                              ),
                            );
                    }).toList(),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CommonButton(
                    borderRadius: 12,
                    color: AppColors.mainColor,
                    height: height * 0.05,
                    onTap: () {
                      if (currentIndex != 2) {
                        setState(() {
                          //currentIndex = index;
                          currentIndex = currentIndex + 1;
                        });
                        pageController.nextPage(
                            duration: Duration(milliseconds: 700),
                            curve: Curves.easeIn);
                      } else {
                        Get.offAll(VenuInfoScreen());
                      }
                    },
                    width: width,
                    text: currentIndex != 2 ? tr('next') : tr('continue'),
                    textColor: AppColors.pureWhiteColor,
                  )
                ],
              ),
            ),
            Positioned(
              top: height * 0.035,
              right: width * 0.05,
              child: InkWell(
                onTap: () {
                  Get.offAll(VenuInfoScreen());
                },
                child: Material(
                  color: AppColors.mainColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  type: MaterialType.button,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'skip',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: height * 0.018,
                          color: AppColors.pureWhiteColor,
                        ),
                      ).tr(),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
