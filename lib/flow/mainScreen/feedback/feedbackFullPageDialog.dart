// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/utils/snackBars.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import '../../../common/appColors.dart';
import '../../../widgets/commonButton.dart';
import '../../../widgets/emojiBuilder.dart';
import '../../../widgets/grayInputField.dart';
import 'feedbackController.dart';

class FeedbackFullPageDialog extends StatelessWidget {
  final double? height;
  final double? width;
  const FeedbackFullPageDialog({
    Key? key,
    required this.feedbackController,
    this.height,
    this.width,
  }) : super(key: key);

  final FeedbackController feedbackController;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: Obx(
          () => Center(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Container(
                width: width! * 0.85,
                height: height! * 0.9,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.pureWhiteColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        GestureDetector(
                          onTap: () {
                            feedbackController.showFullPageDialog.value = false;
                          },
                          child: Container(
                            height: 22,
                            width: 22,
                            color: Colors.transparent,
                            child: Image.asset(
                              'assets/cross.png',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.004,
                    ),
                    Column(
                      children: [
                        Text(
                          'please_give_us_your_valuable_feedback',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width > 600
                                ? MediaQuery.of(context).size.height * 0.017
                                : MediaQuery.of(context).size.height * 0.015,
                            color: AppColors.pureBlackColor,
                          ),
                        ).tr(),
                        SizedBox(
                          height: height! * 0.03,
                        ),
                        EmojiListBuilder(
                          height: height!,
                          width: width!,
                          title: tr('service_efficiency'),
                          itemCount: feedbackController
                              .listofBoolServiceEfficency.length,
                          controllerListOfBools:
                              feedbackController.listofBoolServiceEfficency,
                          valueSetter: (value) {
                            feedbackController
                                .updateListofBoolTasteOfFood(value);
                            feedbackController.serviceEfficencyRating.value =
                                value + 1;
                          },
                        ),
                        Text(
                          'cleanliness',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width > 600
                                ? MediaQuery.of(context).size.height * 0.016
                                : MediaQuery.of(context).size.height * 0.015,
                          ),
                        ).tr(),
                        SizedBox(
                          height: height! * 0.02,
                        ),
                        SmoothStarRating(
                          allowHalfRating: false,
                          onRatingChanged: (v) {
                            feedbackController.cleanlinessRating.value = v;
                          },
                          starCount: 5,
                          rating: feedbackController.cleanlinessRating.value,
                          size: 40.0,
                          filledIconData: Icons.star,
                          halfFilledIconData: Icons.star_border,
                          color: AppColors.mainColor,
                          borderColor: AppColors.lightGrayColor,
                          spacing: 0.0,
                        ),
                        SizedBox(
                          height: height! * 0.025,
                        ),
                        Text(
                          'overall_impression',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width > 600
                                ? MediaQuery.of(context).size.height * 0.016
                                : MediaQuery.of(context).size.height * 0.015,
                          ),
                        ).tr(),
                        SizedBox(
                          height: height! * 0.02,
                        ),
                        SmoothStarRating(
                          allowHalfRating: false,
                          onRatingChanged: (v) {
                            feedbackController.overallImpressionRating.value =
                                v;
                          },
                          starCount: 5,
                          rating:
                              feedbackController.overallImpressionRating.value,
                          size: 40.0,
                          filledIconData: Icons.star,
                          halfFilledIconData: Icons.star_border,
                          color: AppColors.mainColor,
                          borderColor: AppColors.lightGrayColor,
                          spacing: 0.0,
                        ),
                        SizedBox(
                          height: height! * 0.028,
                        ),
                        Text(
                          'would_you_like_to_visit_again',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width > 600
                                ? MediaQuery.of(context).size.height * 0.016
                                : MediaQuery.of(context).size.height * 0.015,
                          ),
                        ).tr(),
                        SizedBox(height: height! * 0.018),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //                 width: constraints.maxWidth * 0.8,
                            // height: constraints.maxHeight * 0.04,
                            CommonButton(
                              height: height! * 0.04,
                              width: width! * 0.6,
                              color: feedbackController.yesButtonClicked.value
                                  ? AppColors.mainColor
                                  : AppColors.mainColor.withOpacity(0.5),
                              onTap: () {
                                feedbackController.visitAgain.value = 1;
                                feedbackController.yesButtonClicked.value =
                                    true;
                                feedbackController.noButtonClicked.value =
                                    false;

                                print('${feedbackController.visitAgain.value}');
                              },
                              text: tr('yes'),
                              textColor: AppColors.pureWhiteColor,
                            ),
                            SizedBox(
                              width: width! * 0.04,
                            ),
                            CommonButton(
                              height: height! * 0.04,
                              width: width! * 0.6,
                              color: feedbackController.noButtonClicked.value
                                  ? AppColors.darkGrayColor
                                  : AppColors.darkGrayColor.withOpacity(0.5),
                              textColor: AppColors.pureWhiteColor,
                              onTap: () {
                                feedbackController.visitAgain.value = 0;
                                feedbackController.yesButtonClicked.value =
                                    false;
                                feedbackController.noButtonClicked.value = true;
                                print('${feedbackController.visitAgain.value}');
                              },
                              text: tr('no'),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height! * 0.015,
                        ),
                        GrayInputField(
                          width: width,
                          topTitle: tr('your_comment'),
                          textController: feedbackController.commentController,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () {
                            FocusScope.of(context).nextFocus();
                          },
                        ),
                        SizedBox(
                          height: height! * 0.015,
                        ),
                        GrayInputField(
                          width: width,
                          topTitle: tr('name'),
                          textController: feedbackController.nameController,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () {
                            FocusScope.of(context).nextFocus();
                          },
                        ),
                        SizedBox(
                          height: height! * 0.015,
                        ),
                        GrayInputField(
                          width: width,
                          topTitle: tr('email'),
                          textController: feedbackController.emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                        ),
                        SizedBox(
                          height: height! * 0.02,
                        ),
                        SizedBox(
                          height: height! * 0.012,
                        ),
                        CommonButton(
                          width: width! * 0.6,
                          height: height! * 0.04,
                          onTap: () {
                            if (feedbackController
                                    .serviceEfficencyRating.value ==
                                0) {
                              infoSnackBar(
                                context: context,
                                title: 'Info',
                                msg: 'Please rate Service Efficeincy',
                              );
                            } else if (feedbackController
                                    .cleanlinessRating.value ==
                                0) {
                              infoSnackBar(
                                context: context,
                                title: 'Info',
                                msg: 'Please rate Cleanliness',
                              );
                            } else if (feedbackController
                                    .overallImpressionRating.value ==
                                0) {
                              infoSnackBar(
                                context: context,
                                title: 'Info',
                                msg: 'Please rate Overall Impression',
                              );
                            } else if (feedbackController
                                        .yesButtonClicked.value ==
                                    false &&
                                feedbackController.noButtonClicked.value ==
                                    false) {
                              infoSnackBar(
                                context: context,
                                title: 'Info',
                                msg: 'Please tell us about your next visit',
                              );
                            } else if (feedbackController
                                .commentController.text.isEmpty) {
                              infoSnackBar(
                                context: context,
                                title: 'Info',
                                msg: 'We need your comments',
                              );
                            } else if (feedbackController
                                .nameController.text.isEmpty) {
                              infoSnackBar(
                                context: context,
                                title: 'Info',
                                msg: 'You forgot to enter your name',
                              );
                            } else if (feedbackController
                                .emailController.text.isEmpty) {
                              infoSnackBar(
                                context: context,
                                title: 'Info',
                                msg: 'Please enter your email',
                              );
                            } else {
                              feedbackController.submitFeedback();
                              feedbackController.showFullPageDialog.value =
                                  false;
                            }
                          },
                          text: tr('submit'),
                          textColor: AppColors.pureWhiteColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
