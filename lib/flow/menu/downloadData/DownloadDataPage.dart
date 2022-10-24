import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/common/appColors.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class DownloadDataPage extends StatelessWidget {
  const DownloadDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: Stack(
            children: [
              Column(
                children: [
                  Flexible(
                    flex: 6,
                    child: Container(
                      height: constraints.maxHeight * 0.6,
                      width: constraints.maxWidth,
                      // color: AppColors.pureWhiteColor,
                      color: AppColors.pureWhiteColor,
                      child: Center(
                        child: Image.asset(
                          'assets/download.png',
                          height: constraints.maxHeight * 0.4,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
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
                                  color: AppColors.pureWhiteColor,
                                ),
                                Container(
                                  height: constraintss.maxHeight / 2,
                                  width: constraintss.maxWidth,
                                  color: AppColors.backgroundColor,
                                ),
                              ],
                            ),
                            CircularStepProgressIndicator(
                              totalSteps: 100,
                              currentStep: 74,
                              stepSize: 10,
                              selectedColor: AppColors.mainColor,
                              unselectedColor: AppColors.lightGrayColor,
                              padding: 0,
                              width: 150,
                              height: 150,
                              child: Center(
                                child: CircleAvatar(
                                  radius: 100,
                                  backgroundColor: AppColors.backgroundColor,
                                  child: RichText(
                                    text: TextSpan(
                                        text: '70',
                                        style: TextStyle(
                                          color: AppColors.mainColor,
                                          fontSize:
                                              constraints.maxHeight * 0.025,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: '%',
                                              style: TextStyle(
                                                color: AppColors.mainColor,
                                                fontSize:
                                                    constraints.maxHeight *
                                                        0.018,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  // navigate to desired screen
                                                })
                                        ]),
                                  ),
                                ),
                              ),
                              unselectedStepSize: 14,
                              selectedStepSize: 14,
                              roundedCap: (_, __) => true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      width: constraints.maxWidth,
                      color: AppColors.backgroundColor,
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              'Downloading Data',
                              style: TextStyle(
                                fontSize: constraints.maxHeight * 0.028,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: constraints.maxHeight * 0.02,
                            ),
                            Text(
                              'Downloading your restaurant data from the server.',
                              style: TextStyle(
                                fontSize: constraints.maxHeight * 0.018,
                              ),
                            ),
                            Text(
                              'Please wait...',
                              style: TextStyle(
                                fontSize: constraints.maxHeight * 0.018,
                              ),
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
    );
  }
}
