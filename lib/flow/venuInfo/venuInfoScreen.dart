// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/flow/venuInfo/controller/venueLoginController.dart';
import 'package:restaurant_app/main.dart';
import 'package:restaurant_app/utils/GetXNetworkManager.dart';
import 'package:restaurant_app/utils/persistedClass.dart';
import 'package:restaurant_app/utils/snackBars.dart';
import 'package:restaurant_app/widgets/commonButton.dart';
import 'package:restaurant_app/widgets/connectivityBar.dart';
import 'package:restaurant_app/widgets/textInputField.dart';
import '../../common/appColors.dart';

class VenuInfoScreen extends StatelessWidget {
  const VenuInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var venueController = Get.put(VenueLoginController());
    GetXNetworkManager networkManager = Get.find<GetXNetworkManager>();
    SharedPreferenceClass prefes = SharedPreferenceClass();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundColor,
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
              FadeInRight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      height: constraints.maxHeight * 0.1,
                      alignment: Alignment.center,
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.012,
                    ),
                    RichText(
                      text: TextSpan(
                        text: tr('welcome_to'),
                        style: TextStyle(
                          color: AppColors.midBlackColor,
                          fontWeight: FontWeight.w500,
                          fontSize: MediaQuery.of(context).size.width > 600
                              ? MediaQuery.of(context).size.height * 0.019
                              : MediaQuery.of(context).size.height * 0.015,
                        ),
                        children: [
                          TextSpan(
                            text: ' AUR ',
                            style: TextStyle(
                              color: AppColors.mainColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => print('Tap Here onTap'),
                          ),
                          TextSpan(
                            text: tr('restaurant'),
                            style: TextStyle(
                              color: AppColors.midBlackColor,
                              fontWeight: FontWeight.w500,
                              fontSize: MediaQuery.of(context).size.width > 600
                                  ? MediaQuery.of(context).size.height * 0.02
                                  : MediaQuery.of(context).size.height * 0.015,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => print('Tap Here onTap'),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.035,
                    ),
                    Text(
                      'enter_venue_info',
                      style: TextStyle(
                        color: AppColors.midBlackColor,
                        fontSize: MediaQuery.of(context).size.width > 600
                            ? MediaQuery.of(context).size.height * 0.018
                            : MediaQuery.of(context).size.height * 0.015,
                      ),
                    ).tr(),
                    SizedBox(
                      height: constraints.maxHeight * 0.035,
                    ),
                    TextInputField(
                      hintText: tr('vanue_id'),
                      textController: venueController.venueIdController,
                      isPasswwordField: false,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.035,
                    ),
                    TextInputField(
                      hintText: tr('pincode'),
                      textController: venueController.veniPincodeController,
                      isPasswwordField: true,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.035,
                    ),
                    CommonButton(
                      text: tr('enter'),
                      width: constraints.maxWidth * 0.8,
                      height: constraints.maxHeight * 0.04,
                      color: AppColors.mainColor,
                      textColor: AppColors.pureWhiteColor,
                      onTap: () {
                        if (venueController.venueIdController.text.isEmpty) {
                          errorSnackBar(
                            context: context,
                            title: tr('error'),
                            msg: tr('Please_enter_the_Venue_ID'),
                          );
                        } else if (venueController
                            .veniPincodeController.text.isEmpty) {
                          errorSnackBar(
                            context: context,
                            title: tr('error'),
                            msg: tr('Please_enter_the_pincode'),
                          );
                        } else {
                          venueController.venueLogin(context);
                        }
                      },
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.03,
                    ),
                    Text(
                      'or',
                      style: TextStyle(
                        color: AppColors.midBlackColor,
                        fontSize: MediaQuery.of(context).size.width > 600
                            ? MediaQuery.of(context).size.height * 0.016
                            : MediaQuery.of(context).size.height * 0.015,
                      ),
                    ).tr(),
                    SizedBox(
                      height: constraints.maxHeight * 0.03,
                    ),
                    InkWell(
                      onTap: () {
                        // Get.to(MainScreen());
                      },
                      child: Material(
                        color: Colors.transparent,
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            'demo_restaurant',
                            style: TextStyle(
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width > 600
                                  ? MediaQuery.of(context).size.height * 0.018
                                  : MediaQuery.of(context).size.height * 0.015,
                            ),
                          ).tr(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: constraints.maxHeight * 0.035,
                right: constraints.maxWidth * 0.06,
                // left: constraints.maxWidth * 0.08,
                child: FadeInRight(
                  duration: Duration(seconds: 1),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                          width: constraints.maxWidth * 0.12,
                          height: constraints.maxHeight * 0.045,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200.withOpacity(0.5),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: FocusedMenuHolder(
                              menuWidth:
                                  MediaQuery.of(context).size.width * 0.25,
                              blurSize: .0,
                              menuItemExtent: 45,
                              menuBoxDecoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0))),
                              duration: Duration(milliseconds: 100),
                              animateMenuItems: true,
                              blurBackgroundColor: Colors.black54,
                              openWithTap:
                                  true, // Open Focused-Menu on Tap rather than Long Press
                              menuOffset:
                                  10.0, // Offset value to show menuItem from the selected item
                              bottomOffsetHeight: 80.0,
                              menuItems: [
                                FocusedMenuItem(
                                  title: Text("English"),
                                  trailingIcon:
                                      Image.asset('assets/english.png'),
                                  onPressed: () {
                                    findLanguageController.isEnglish.value =
                                        true;
                                    findLanguageController.isArabic.value =
                                        false;
                                    findLanguageController.isTurkish.value =
                                        false;

                                    context.setLocale(engLocale);
                                    prefes.addLocale(en: 'en', dd: 'US');
                                    Get.updateLocale(engLocale);
                                  },
                                ),
                                FocusedMenuItem(
                                  title: Text("العربية"),
                                  trailingIcon:
                                      Image.asset('assets/arabic.png'),
                                  onPressed: () {
                                    findLanguageController.isEnglish.value =
                                        false;
                                    findLanguageController.isArabic.value =
                                        true;
                                    findLanguageController.isTurkish.value =
                                        false;
                                    context.setLocale(arabLocale);
                                    prefes.addLocale(en: 'ar', dd: 'IQ');
                                    Get.updateLocale(arabLocale);
                                  },
                                ),
                                FocusedMenuItem(
                                  title: Text("Türkçe"),
                                  trailingIcon:
                                      Image.asset('assets/turkishFlag.png'),
                                  onPressed: () {
                                    findLanguageController.isEnglish.value =
                                        false;
                                    findLanguageController.isArabic.value =
                                        false;
                                    findLanguageController.isTurkish.value =
                                        true;
                                    context.setLocale(turkishLocale);
                                    prefes.addLocale(en: 'tr', dd: 'TR');
                                    Get.updateLocale(turkishLocale);
                                  },
                                ),
                              ],
                              onPressed: () {},
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                child: Container(
                                  height: constraints.maxHeight * 0.032,
                                  width: constraints.maxWidth * 0.1,
                                  decoration: BoxDecoration(
                                    color: AppColors.mainColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/globe.png',
                                        height: constraints.maxHeight * 0.02,
                                        color: AppColors.pureWhiteColor,
                                      ),
                                      Icon(
                                        Icons.expand_more,
                                        color: AppColors.pureWhiteColor,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                          //setting icon
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [
                          //     Card(
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.all(
                          //           Radius.circular(10),
                          //         ),
                          //       ),
                          //       child: Container(
                          //         height: constraints.maxHeight * 0.03,
                          //         width: constraints.maxWidth * 0.1,
                          //         decoration: BoxDecoration(
                          //           color: AppColors.mainColor,
                          //           borderRadius: BorderRadius.all(
                          //             Radius.circular(10),
                          //           ),
                          //         ),
                          //         child: Center(
                          //             child: Image.asset(
                          //           'assets/settingIcon.png',
                          //           height: constraints.maxHeight * 0.02,
                          //           color: AppColors.pureWhiteColor,
                          //         )),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          ),
                    ),
                  ),
                ),
              ),
              ConnectivityBar(
                networkManager: networkManager,
              ),
              venueController.isLoading.value
                  ? Center(child: CircularProgressIndicator.adaptive())
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
