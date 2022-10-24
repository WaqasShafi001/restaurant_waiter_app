// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/common/appColors.dart';
import 'package:restaurant_app/flow/menu/controllers/socialLinksController.dart';
import 'package:restaurant_app/utils/GetXNetworkManager.dart';
import 'package:restaurant_app/utils/snackBars.dart';
import 'package:restaurant_app/widgets/connectivityBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/commonButton.dart';
import '../../widgets/socialButton.dart';
import '../menu/widgets/topLeftWidget.dart';
import '../menu/views/menuScreen.dart';
import 'feedback/feedbackController.dart';
import 'feedback/feedbackFullPageDialog.dart';

class MainScreen extends StatelessWidget {
  final int? totalTables;
  const MainScreen({Key? key, this.totalTables}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var listOfTables = List<int>.generate(totalTables!, (index) => index + 1);
    print('this is total tables-==-= $listOfTables');

    GetXNetworkManager networkManager =
        Get.put(GetXNetworkManager(), permanent: true);
    var feedbackController = Get.put(FeedbackController());
    var socialLinksController = Get.put(SocialLinksController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (context, constraints) => Obx(
          () => Stack(
            alignment: Alignment.center,
            children: [
              Container(
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
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth * 0.07,
                  vertical: constraints.maxHeight * 0.09,
                ),
                child: Container(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/Frame.png',
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    height: constraints.maxHeight * 0.08,
                    alignment: Alignment.center,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.01,
                  ),
                  Text(
                    'restaurant',
                    style: TextStyle(
                      color: AppColors.mainColor,
                      fontSize: MediaQuery.of(context).size.width > 600
                          ? MediaQuery.of(context).size.height * 0.019
                          : MediaQuery.of(context).size.height * 0.015,
                    ),
                  ).tr(),
                  SizedBox(
                    height: constraints.maxHeight * 0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Choose_Table',
                        style: TextStyle(
                          color: AppColors.mainColor,
                          fontSize: MediaQuery.of(context).size.width > 600
                              ? MediaQuery.of(context).size.height * 0.017
                              : MediaQuery.of(context).size.height * 0.014,
                        ),
                      ).tr(),
                      SizedBox(
                        width: constraints.maxWidth * 0.06,
                      ),
                      Container(
                        height: constraints.maxHeight * 0.03,
                        width: constraints.maxWidth * 0.1,
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: Center(
                          child: DropdownButton(
                            value: socialLinksController.dropdownvalue.value,
                            style: TextStyle(
                              color: AppColors.pureWhiteColor,
                              fontSize: 18,
                            ),
                            alignment: Alignment.center,
                            dropdownColor: AppColors.mainColor,
                            icon: Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: AppColors.pureWhiteColor,
                            ),
                            items: listOfTables.map((e) {
                              return DropdownMenuItem(
                                child: Text(
                                  e.toString(),
                                ),
                                value: e,
                              );
                            }).toList(),
                            onChanged: (int? newValue) async {
                              socialLinksController.dropdownvalue.value =
                                  newValue!;

                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                              // prefs.remove('TableNumber');

                              prefs.setInt('TableNumber',
                                  socialLinksController.dropdownvalue.value);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.04,
                  ),
                  CommonButton(
                    text: tr('menu'),
                    textColor: AppColors.pureWhiteColor,
                    width: constraints.maxWidth * 0.8,
                    height: constraints.maxHeight * 0.04,
                    onTap: () {
                      socialLinksController.dropdownvalue.value == null
                          ? errorSnackBar(
                              context: context,
                              title: 'Error',
                              msg: 'Please choose a table number')
                          : Get.to(MainMenuScreen());
                    },
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.1,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.06,
                    width: constraints.maxWidth * 0.7,
                    color: Colors.transparent,
                    child: socialLinksController.isLoading.value
                        ? Center(child: CircularProgressIndicator.adaptive())
                        : Center(
                            child: ListView.builder(
                              itemCount:
                                  socialLinksController.socialList.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => Center(
                                child: SocialButton(
                                  imagePath: socialLinksController
                                      .socialList[index].icon,
                                  constraints: constraints,
                                  url: socialLinksController
                                      .socialList[index].link,
                                  qrImagepath: socialLinksController
                                      .socialList[index].qrCode,
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
              Positioned(
                top: constraints.maxHeight * 0.035,
                right: constraints.maxWidth * 0.06,
                left: constraints.maxWidth * 0.06,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TopRightWidget(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                    ),
                    ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Container(
                          width: constraints.maxWidth * 0.12,
                          height: constraints.maxHeight * 0.045,
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
                                  //pop up page dialog
                                  feedbackController.showFullPageDialog.value =
                                      true;
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  child: Container(
                                    height: constraints.maxHeight * 0.03,
                                    width: constraints.maxWidth * 0.1,
                                    decoration: BoxDecoration(
                                      color: AppColors.mainColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                    ),
                                    child: Center(
                                        child: Image.asset(
                                      'assets/smily.png',
                                      height: constraints.maxHeight * 0.02,
                                      color: AppColors.pureWhiteColor,
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ConnectivityBar(
                networkManager: networkManager,
              ),
              feedbackController.showFullPageDialog.value
                  ? FadeIn(
                      child: Container(
                        height: constraints.maxHeight,
                        width: constraints.maxWidth,
                        color: Colors.black38,
                        child: FeedbackFullPageDialog(
                          feedbackController: feedbackController,
                          height: constraints.maxHeight,
                          width: constraints.maxWidth,
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
