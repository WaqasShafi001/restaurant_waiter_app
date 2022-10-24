// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../common/appColors.dart';

class CommonButton extends StatelessWidget {
  final double? height;
  final double? width;
  final String? text;
  final Function()? onTap;
  final Color? color;
  final Color? textColor;
  final bool? isIcon;
  final Widget? icon;
  final double? borderRadius;
  const CommonButton({
    Key? key,
    this.height,
    this.width,
    this.text,
    this.onTap,
    this.color,
    this.textColor,
    this.isIcon = false,
    this.icon,
    this.borderRadius = 13,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      onPressed: onTap!,
      minWidth: width! * 0.4,
      height: height,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius!))),
      color: color ?? AppColors.mainColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          isIcon! ? icon! : SizedBox(),
          SizedBox(
            width: 5,
          ),
          Text(
            text!,
            style: TextStyle(
              color: textColor ?? AppColors.pureBlackColor,
              fontSize: MediaQuery.of(context).size.width > 600
                  ? MediaQuery.of(context).size.height * 0.0175
                  : MediaQuery.of(context).size.height * 0.015,
            ),
          ),
        ],
      ),
    );
  }
}
