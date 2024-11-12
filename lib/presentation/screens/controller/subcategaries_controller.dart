
import 'package:RiddleQing/data/api_service.dart';
import 'package:RiddleQing/data/models/subcategaries_model.dart';
import 'package:get/get.dart';


class SubcategariesController extends GetxController {
  var SubcategariesGetList = <SubCategariesModel>[].obs;
  var isLoading = false.obs;

  void updateLoader(bool loader) {
    this.isLoading.value = loader;
  }

  Future<void> fetchCategories(int quizCategoryId) async {
    updateLoader(true);
    try {
      var response = await ApiService.SubCatagariesGetAPI( quizCategoryId); 
      SubcategariesGetList.assignAll(response); 
    } catch (e) {
      print('Error fetching categories: $e');

    } finally {
      updateLoader(false);
    }
  }
}
