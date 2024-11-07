import 'package:Kwiz/data/api_service.dart';
import 'package:Kwiz/data/models/quizzeslist_model.dart';
import 'package:get/get.dart';



class QuizlistController extends GetxController {
  var QuiztList = <QuizzesListModel>[].obs;
  var isLoading = false.obs;

  void updateLoader(bool loader) {
    this.isLoading.value = loader;
  }

  Future<void> fetchCategories(int quizSubCategoryId) async {
    updateLoader(true);
    try {
      var response = await ApiService.QuizzesListGetAPI( quizSubCategoryId); 
      QuiztList.assignAll(response); 
    } catch (e) {
      print('Error fetching categories: $e');

    } finally {
      updateLoader(false);
    }
  }
}
