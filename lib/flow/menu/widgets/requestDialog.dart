// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/utils/snackBars.dart';
import 'package:restaurant_app/widgets/requestStripBuilder.dart';

import '../../../common/appColors.dart';
import '../../../widgets/commonButton.dart';
import '../controllers/requestController.dart';

class RequestDialog extends StatelessWidget {
  final RequestController? controller;
  const RequestDialog({
    Key? key,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: AppColors.mainColor,
        child: LayoutBuilder(
          builder: (context, constraints) => Container(
            height: constraints.maxHeight * 0.4,
            width: constraints.maxWidth * 0.6,
            decoration: BoxDecoration(
                color: AppColors.pureWhiteColor,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              color: AppColors.mainColor,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: constraints.maxHeight * 0.01),
                                child: Text(
                                  'requested_services',
                                  style: TextStyle(
                                    color: AppColors.pureWhiteColor,
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ).tr(),
                              ),
                              width: constraints.maxWidth,
                            ),
                            Positioned(
                              right: 5,
                              top: 5,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                  controller!.resetValues();

                                },
                                child: Container(
                                  height: 22,
                                  width: 22,
                                  color: Colors.transparent,
                                  child: Image.asset(
                                    'assets/cross.png',
                                    color: AppColors.pureWhiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: LayoutBuilder(
                          builder: (context, constraintss) => Container(
                            width: constraintss.maxWidth,
                            height: constraintss.maxHeight,
                            color: AppColors.pureWhiteColor,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: constraintss.maxHeight / 2,
                                      width: constraintss.maxWidth,
                                      color: AppColors.mainColor,
                                    ),
                                    Container(
                                      height: constraintss.maxHeight / 2,
                                      width: constraintss.maxWidth,
                                      color: AppColors.pureWhiteColor,
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.lightGreenColor,
                                  ),
                                  height: constraints.maxHeight * 0.1,
                                  width: constraints.maxWidth,
                                  child: Center(
                                    child: Image.asset(
                                      'assets/logo.png',
                                      height: constraints.maxHeight * 0.035,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 4,
                        child: Obx(
                          () => RequestStripBuilder(
                            controllerListOfBools:
                                controller!.listofBoolRequests,
                            itemCount: controller!.listofBoolRequests.length,
                            height: constraints.maxHeight,
                            mainScrollHeight: constraints.maxHeight * 0.15,
                            valueSetter: (value) {
                              controller!.updateListofBoolRequests(value);
                              print('-==-=-= $value');
                              if (value == 0) {
                                controller!.requestMessage.value = 'checkout';
                              } else if (value == 1) {
                                controller!.requestMessage.value = 'tap_water';
                              } else {
                                controller!.requestMessage.value =
                                    'call_waiter';
                              }

                              // controller!.requestMessage.value;
                            },
                            width: constraints.maxWidth,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Container(
                          width: constraints.maxWidth,
                          color: Colors.transparent,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 1,
                                  color: AppColors.lightGrayColor,
                                  width: constraints.maxWidth,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // CommonButton(
                                    //   color: AppColors.mainColor,
                                    //   onTap: () {
                                    //     Navigator.of(context).pop();
                                    //   },
                                    //   text: tr('cancel'),
                                    //   borderRadius: 8,
                                    //   textColor: AppColors.pureWhiteColor,
                                    //   width: constraints.maxWidth * 0.5,
                                    //   height: constraints.maxHeight * 0.035,
                                    // ),
                                    CommonButton(
                                      color: AppColors.mainColor,
                                      onTap: () {
                                        if (controller!
                                            .requestMessage.isEmpty) {
                                          errorSnackBar(
                                            context: context,
                                            title: tr('error'),
                                            msg: tr(
                                                'Please_choose_your_request'),
                                          );
                                        } else {
                                          Navigator.of(context).pop();
                                          controller!.requestServiceApi();

                                          controller!.isLoading.value
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator
                                                          .adaptive(),
                                                )
                                              : Get.generalDialog(
                                                  pageBuilder: (context,
                                                          animation,
                                                          secondaryAnimation) =>
                                                      Center(
                                                    child: Material(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12)),
                                                      child: LayoutBuilder(
                                                        builder: (context, c) =>
                                                            Container(
                                                          height:
                                                              c.maxHeight * 0.4,
                                                          width:
                                                              c.maxWidth * 0.6,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Image.asset(
                                                                'assets/doubleTick.png',
                                                              ),
                                                              Text(
                                                                'your_request_has_been_sent',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .width >
                                                                          600
                                                                      ? MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.016
                                                                      : MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.015,
                                                                ),
                                                              ).tr(),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  barrierLabel: '',
                                                  barrierDismissible: true,
                                                );
                                        }
                                      },
                                      text: tr('send'),
                                      borderRadius: 8,
                                      textColor: AppColors.pureWhiteColor,
                                      width: constraints.maxWidth * 0.5,
                                      height: constraints.maxHeight * 0.035,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
