import 'package:get/get.dart';

class ProductController extends GetxController {
  var slectedValue = 'Single'.obs;
  var quantityCounter = 1.obs;

  void increamentCounter(int? val) {
    if (val! >= 1) {
      quantityCounter.value++;
    }
  }

  void decreamentCounter(int? val) {
    if (val! > 1) {
      quantityCounter.value--;
    }
  }

  var selectedExtras = <int>[].obs; //use this list
  var selectedExtrasById = [].obs; 

  selectedExtrasByIndex(int index) {
    if (selectedExtras.value.contains(index)) {
      selectedExtras.value.remove(index);
    } else {
      selectedExtras.value.add(index);
    }
  }

  getNewListOfExtrasById(List list) {
    selectedExtrasById.clear();
    for (var entry in list) {
      var val = entry + 1;
      selectedExtrasById.add(val);
    }

    print('${selectedExtrasById.toSet().toList()}');
  }
}
