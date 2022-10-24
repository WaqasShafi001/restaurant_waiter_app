import 'package:get/get.dart';
import 'package:restaurant_app/utils/GetXNetworkManager.dart';

class NetworkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetXNetworkManager>(() => GetXNetworkManager(), fenix: true);
  }
}
