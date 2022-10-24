// ignore_for_file: prefer_typing_uninitialized_variables, must_call_super, non_constant_identifier_names

import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class GetXNetworkManager extends GetxController {
  //this variable 0 = No Internet, 1 = connected to WIFI ,2 = connected to Mobile Data.
  var connectionType = 0.obs;
  var widgetHideDecider = true.obs;
  //Instance of Flutter Connectivity
  final Connectivity _connectivity = Connectivity();

  //Stream to keep listening to network change state
  late StreamSubscription _streamSubscription;

  @override
  void onInit() {
    GetConnectionType();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateState);
  }

  // a method to get which connection result, if you we connected to internet or no if yes then which network
  Future<void> GetConnectionType() async {
    var connectivityResult;
    try {
      print('see if it is called time to time');
      connectivityResult = await (_connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      print(e);
    }
    return _updateState(connectivityResult);
  }

  // state update, of network, if you are connected to WIFI connectionType will get set to 1,
  // and update the state to the consumer of that variable.
  _updateState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionType.value = 1;
        autoHideWidget(true);
        update();
        break;
      case ConnectivityResult.mobile:
        connectionType.value = 2;
        autoHideWidget(true);

        update();
        break;
      case ConnectivityResult.none:
        connectionType.value = 0;
        autoHideWidget(false);

        update();
        break;

      default:
        Get.snackbar('Network Error', 'Failed to get Network Status');
        break;
    }
  }

  Future<bool> autoHideWidget(bool val) async {
    widgetHideDecider.value = true;

    print('this is called');
    if (val == true) {
      Future.delayed(
        Duration(seconds: 3),
      ).then(
        (value) {
          print('level 1');
          widgetHideDecider.value = false;
        },
      );
    } else {
      Future.delayed(
        Duration(seconds: 3),
      ).then(
        (value) {
          print('level 11');

          widgetHideDecider.value = false;
        },
      );
    }
    return val;
  }

  @override
  void onClose() {
    //stop listening to network state when app is closed
    _streamSubscription.cancel();
  }
}
