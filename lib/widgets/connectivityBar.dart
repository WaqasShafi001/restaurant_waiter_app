// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:restaurant_app/utils/GetXNetworkManager.dart';

class ConnectivityBar extends StatelessWidget {
  final GetXNetworkManager? networkManager;
  const ConnectivityBar({Key? key, this.networkManager}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          (networkManager!.connectionType.value == 1) ||
                  (networkManager!.connectionType.value == 2)
              ? networkManager!.widgetHideDecider.value
                  ? Container(
                      height: MediaQuery.of(context).size.height * 0.02,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.green,
                      child: Center(
                        child: Text(
                          'Connected',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : SizedBox()
              : networkManager!.widgetHideDecider.value
                  ? Container(
                      height: MediaQuery.of(context).size.height * 0.02,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.red,
                      child: Center(
                        child: Text(
                          'No Internet',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : SizedBox()
        ],
      ),
    );
  }
}
