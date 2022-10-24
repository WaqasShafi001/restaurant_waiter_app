import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/flow/search/model/allTagsModel.dart';
import 'package:restaurant_app/flow/search/model/basicSearchModel.dart';
import 'package:restaurant_app/utils/apiUrls.dart';
import 'package:restaurant_app/utils/navigatorService.dart';
import 'package:restaurant_app/utils/snackBars.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchController extends GetxController {
  var showFilter = false.obs;
  var isLoading = true.obs;
  var allTags = <Tagg>[].obs;

  TextEditingController searchTxtController = TextEditingController();
  var allSearchedProducts = <SearchedProduct>[].obs;
  @override
  void onInit() {
    searchProducts(title: '');
    super.onInit();
  }

  var selesctedTags = [].obs;

  var selectedtagsById = [].obs;

  selectedTagsByIndex(int index) {
    if (selesctedTags.value.contains(index)) {
      selesctedTags.value.remove(index);
    } else {
      selesctedTags.value.add(index);
    }
  }

  getNewListOfTagsById(List list) {
    selectedtagsById.clear();
    for (var entry in list) {
      var val = entry + 1;
      selectedtagsById.add(val);
    }

    print('${selectedtagsById.toSet().toList()}');
  }

  getAllTags() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var thisID = pref.getInt('venueID');
    print('this is ID $thisID');
    try {
      var response = await http.get(
        Uri.parse(
          '$baseURL$getAllTagsUrl/$thisID',
        ),
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        AllTagsModel model = AllTagsModel.fromJson(result);

        allTags.value = model.data!;

        print('this is list of tags -=- = $allTags');
        isLoading.value = false;
      } else {
        errorSnackBar(
          context: NavigationService.navigatorKey.currentContext,
          title: 'Error',
          msg: 'Opps! Something went wrong',
        );
      }
    } catch (e) {
      errorSnackBar(
        context: NavigationService.navigatorKey.currentContext,
        title: 'Error',
        msg: e.toString(),
      );
    }
  }

  resetSearch() {
    showFilter.value = false;
    selesctedTags.clear();
    selectedtagsById.clear();
    searchTxtController.clear();
    allSearchedProducts.clear();

    searchProducts(title: '');
  }

  searchProducts({required String title}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var thisID = pref.getInt('venueID');
    print('this is ID $thisID');

    allSearchedProducts.clear();
    try {
      var response = await http.post(Uri.parse('$baseURL$searchUrl'), body: {
        'filter': '0',
        'tags[]': '',
        'venue_id': '$thisID',
        'title': '${title.isEmpty ? '' : title}',
      });

      var data = jsonDecode(response.body);

      BasicSearchModel model = BasicSearchModel.fromJson(data);

      if (response.statusCode == 200) {
        allSearchedProducts.value = model.data!;
      } else {
        errorSnackBar(
          context: NavigationService.navigatorKey.currentContext,
          title: 'Error',
          msg: 'Try again later',
        );
      }
    } catch (e) {
      errorSnackBar(
        context: NavigationService.navigatorKey.currentContext,
        title: 'Error',
        msg: e.toString(),
      );
    }
  }

  searchProductsWithTags({required String title}) async {
    allSearchedProducts.clear();

    SharedPreferences pref = await SharedPreferences.getInstance();
    var thisID = pref.getInt('venueID');
    print('this is ID $thisID');

    getNewListOfTagsById(selesctedTags);
    print('this is list of ids of tags  ${selectedtagsById.toSet().toList()}');

    String newVal = json.encode(selectedtagsById
        .toSet()
        .toList()
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .trim());
    print('new val -== $newVal');
    try {
      var response = await http.post(Uri.parse('$baseURL$searchUrl'), body: {
        'filter': "1",
        'tags[]': newVal.replaceAll('"', '').trim(),
        'venue_id': "$thisID",
        'title': "${title.isEmpty ? '' : title}",
      });

      var data = jsonDecode(response.body);

      BasicSearchModel model = BasicSearchModel.fromJson(data);

      if (response.statusCode == 200) {
        allSearchedProducts.value = model.data!;
        print('search with filter  1 and body is $data');
        print('$allSearchedProducts');
      } else {
        errorSnackBar(
          context: NavigationService.navigatorKey.currentContext,
          title: 'Error',
          msg: 'Try again later',
        );
      }
    } catch (e) {
      errorSnackBar(
        context: NavigationService.navigatorKey.currentContext,
        title: 'Error',
        msg: e.toString(),
      );
    }
  }
}
