import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';

errorSnackBar({
  BuildContext? context,
  String? title,
  String? msg,
}) {
  ElegantNotification.error(
    title: Text(title!),
    animation: ANIMATION.fromTop,
    animationDuration: Duration(seconds: 1),
    height: MediaQuery.of(context!).size.height * 0.06,
    toastDuration: Duration(seconds: 3),
    description: Text(msg!),
  ).show(context);
}

successSnackBar({
  BuildContext? context,
  String? title,
  String? msg,
}) {
  ElegantNotification.success(
    title: Text(title!),
    animation: ANIMATION.fromTop,
    animationDuration: Duration(seconds: 1),
    height: MediaQuery.of(context!).size.height * 0.06,
    toastDuration: Duration(seconds: 3),
    description: Text(msg!),
  ).show(context);
}

infoSnackBar({
  BuildContext? context,
  String? title,
  String? msg,
}) {
  ElegantNotification.info(
    title: Text(title!),
    animation: ANIMATION.fromTop,
    animationDuration: Duration(seconds: 1),
    height: MediaQuery.of(context!).size.height * 0.06,
    toastDuration: Duration(seconds: 3),
    description: Text(msg!),
  ).show(context);
}
