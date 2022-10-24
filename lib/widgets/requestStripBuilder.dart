// ignore_for_file: prefer_const_constructors
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/common/appColors.dart';

class RequestStripBuilder extends StatelessWidget {
  final double? height;
  final double? width;
  final int? itemCount;
  final double? mainScrollHeight;
  // final Function(int?)? onTap;
  final ValueSetter<int>? valueSetter;

  final List? controllerListOfBools;

  const RequestStripBuilder(
      {Key? key,
      this.height,
      this.width,
      this.itemCount,
      // this.onTap,
      this.controllerListOfBools,
      this.valueSetter,
      this.mainScrollHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var requestList = [
      'request_checkout',
      'request_tap_water',
      'call_waiter',
    ];
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: mainScrollHeight,
            color: Colors.transparent,
            child: Center(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: controllerListOfBools!.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: InkWell(
                    onTap: () {
                      valueSetter!(index);
                    },
                    child: Container(
                      width: width,
                      height: height! * 0.04,
                      color: controllerListOfBools![index]
                          ? AppColors.lightGreenColor
                          : AppColors.pureWhiteColor,
                      child: Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              requestList[index],
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width >
                                        600
                                    ? MediaQuery.of(context).size.height * 0.014
                                    : MediaQuery.of(context).size.height *
                                        0.013,
                              ),
                            ).tr(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                controllerListOfBools![index]
                                    ? Icon(
                                        Icons.check,
                                      )
                                    : SizedBox(),
                                SizedBox(),
                                SizedBox(),
                              ],
                            ),
                          ],
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
    );
  }
}
