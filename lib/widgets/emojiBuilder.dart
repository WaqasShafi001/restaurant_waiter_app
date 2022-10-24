import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/common/appColors.dart';

class EmojiListBuilder extends StatelessWidget {
  final String? title;
  final double? height;
  final double? width;
  final int? itemCount;
  // final Function(int?)? onTap;
  final ValueSetter<int>? valueSetter;

  final List? controllerListOfBools;

  const EmojiListBuilder(
      {Key? key,
      this.title,
      this.height,
      this.width,
      this.itemCount,
      // this.onTap,
      this.controllerListOfBools,
      this.valueSetter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emojiList = [
      'assets/sadEmoji.png',
      'assets/confusedEmoji.png',
      'assets/happyEmoji.png',
    ];
    return Container(
      // height: height * 0.15,
      width: width,
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(
            //   height: height! * 0.01,
            // ),
            Text(
              title!,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width > 600
                    ? MediaQuery.of(context).size.height * 0.016
                    : MediaQuery.of(context).size.height * 0.015,
              ),
            ),
            SizedBox(
              height: height! * 0.005,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.09,
              color: Colors.transparent,
              child: Center(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: controllerListOfBools!.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: IconButton(
                      // color: AppColors.selectedCategoryColor,
                      iconSize: height! * 0.055,
                      onPressed: () {
                        valueSetter!(index);
                      },
                      //onTap!(index),
                      // onPressed: () {
                      //   setState(() {
                      //     feedbackController
                      //         .updateListofBoolStaffBehaviour(index);
                      //   });
                      // },

                      splashColor: AppColors.mainColor,
                      icon: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Image.asset(
                            emojiList[index],
                            // height: 100,
                            fit: BoxFit.cover,
                            height: height! * 0.04,
                            color: controllerListOfBools![index]
                                ? AppColors.mainColor
                                : AppColors.lightGrayColor,
                            // width: width*0.1,
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
    );
  }
}
