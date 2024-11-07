import 'package:Kwiz/data/api_service.dart';
import 'package:Kwiz/data/models/search_model.dart';
import 'package:Kwiz/presentation/screens/controller/add_categegory_controller.dart';
import 'package:get/get.dart';



class SearchController extends GetxController {
  var quizzes = <SearchModel>[].obs;
  var categories = <String>[].obs;
  var subCategories = <String>[].obs;
  var selectedCategory = ''.obs;
  var selectedSubCategory = ''.obs;
  var searchResults = <SearchModel>[].obs;
  var searchQuery = ''.obs;

  final ApiService apiService = ApiService();
  final QuizGetController quizGetController = Get.find(); 

  @override
  void onInit() {
    super.onInit();
    fetchQuizzes();
  }

  void fetchQuizzes() async {
    try {
      var quizList = await apiService.fetchQuizzes();
      quizzes.assignAll(quizList);
      updateCategories();
    } catch (e) {
      print('Error fetching quizzes: $e');
    }
  }

  void updateCategories() {
    categories.assignAll(quizzes
        .map((quiz) => quiz.quizCategory)
        .where((category) => category != null)
        .toSet()
        .cast<String>());
  }

  void fetchSubCategories(String category) {
    subCategories.assignAll(quizzes
        .where((quiz) => quiz.quizCategory == category)
        .map((quiz) => quiz.quizSubCategory)
        .where((subCategory) => subCategory != null)
        .toSet()
        .cast<String>());


    if (subCategories.isNotEmpty) {
      selectedSubCategory.value = subCategories.first;
    } else {
      selectedSubCategory.value = '';
    }
  }

  void performSearch(String query) {
    quizGetController.filterQuizzes(query, selectedCategory.value, selectedSubCategory.value);
  }

  void resetSearch() {
    searchQuery.value = '';
    selectedCategory.value = '';
    selectedSubCategory.value = '';
  }
}
