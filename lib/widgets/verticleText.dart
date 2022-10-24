import 'package:flutter/material.dart';
import 'package:restaurant_app/common/appColors.dart';

class VerticalText extends StatelessWidget {
  final String text;

  const VerticalText(this.text);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 25,
      direction: Axis.vertical,
      alignment: WrapAlignment.center,
      children: text
          .split("")
          .map(
            (string) => Text(
              string,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.014,
                color: AppColors.pureWhiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
          .toList(),
    );
  }
}
