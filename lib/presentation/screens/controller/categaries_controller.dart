import 'package:Kwiz/data/api_service.dart';
import 'package:Kwiz/data/models/categaries_model.dart';
import 'package:get/get.dart';


class CategariesController extends GetxController {
  var categariesGetList = <CategariesModel>[].obs;
  var isLoading = false.obs;

  void updateLoader(bool loader) {
    this.isLoading.value = loader;
  }

  Future<void> fetchCategories(int quizTypeId) async {
    updateLoader(true);
    try {
      var response = await ApiService.CatagariesGetAPI(quizTypeId); 
      categariesGetList.assignAll(response); 
    } catch (e) {
      print('Error fetching categories: $e');

    } finally {
      updateLoader(false);
    }
  }
}
