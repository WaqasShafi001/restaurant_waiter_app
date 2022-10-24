// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../common/appColors.dart';

class GrayInputField extends StatelessWidget {
  final String? topTitle;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? textController;
  final VoidCallback? onEditingComplete;
  const GrayInputField({
    Key? key,
    required this.width,
    this.topTitle,
    this.keyboardType,
    this.textInputAction,
    this.textController, this.onEditingComplete,
  }) : super(key: key);

  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width! * 0.85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            topTitle!,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width > 600
                  ? MediaQuery.of(context).size.height * 0.013
                  : MediaQuery.of(context).size.height * 0.012,
            ),
          ),
          TextFormField(
            textInputAction: textInputAction,
            keyboardType: keyboardType,
            controller: textController,
            onEditingComplete: onEditingComplete,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.textfieldBgColor,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.textfieldBgColor,
                  width: 1,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.textfieldBgColor,
                  width: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
