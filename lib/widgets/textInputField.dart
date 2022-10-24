// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/appColors.dart';

class TextInputField extends StatefulWidget {
  final String? titleText;
  final String? hintText;
  final String? initialText;
  final TextInputType? keyboardType;
  final bool isPasswwordField;
  final TextInputAction? textInputAction;
  final TextEditingController? textController;
  final bool? enabled;

  const TextInputField(
      {Key? key,
      this.titleText,
      this.hintText,
      this.initialText,
      this.keyboardType,
      this.isPasswwordField = false,
      this.textInputAction,
      this.textController,
      this.enabled = true})
      : super(key: key);

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  bool isObsecure = true;
  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.18),
      child: Center(
        child: TextFormField(
          keyboardType: widget.keyboardType,
          cursorColor: AppColors.mainColor,
          textInputAction: widget.textInputAction,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.lightGrayColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.mainColor, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: AppColors.lightGrayColor, width: 1.0),
            ),
            contentPadding: EdgeInsets.only(left: 10),
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: AppColors.lightGrayColor,
            ),
            suffixIcon: widget.isPasswwordField
                ? InkWell(
                    onTap: () {
                      setState(() {
                        isObsecure = !isObsecure;
                      });
                    },
                    child: Icon(
                      !isObsecure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility,
                      color: AppColors.lightGrayColor,
                      size: height * 0.025,
                    ),
                  )
                : SizedBox(),
          ),
          showCursor: true,
          enabled: widget.enabled,
          controller: widget.textController,
          obscureText: widget.isPasswwordField ? isObsecure : !isObsecure,
          textAlignVertical: TextAlignVertical.center,
        ),
      ),
    );
  }
}
