import 'package:Kwiz/data/api_service.dart';
import 'package:Kwiz/data/models/TypesOfCategeries.dart';
import 'package:get/get.dart';





class TypesOfCategeriesController extends GetxController {
  var typesCatGetList = <TypesOfCategariesModel>[].obs;
  var isLoading = false.obs;

  void updateLoader(bool loader) {
    this.isLoading.value = loader;
  }

  Future<void> TypeCatGetAPI() async {
    updateLoader(true);
    final response = await ApiService.TypeCatGetAPI();
    this.typesCatGetList.value = response;
    updateLoader(false);
  }
}