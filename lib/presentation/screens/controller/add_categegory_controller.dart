import 'package:Kwiz/data/api_service.dart';
import 'package:Kwiz/data/models/live_quizes_Model.dart';
import 'package:get/get.dart';


class QuizGetController extends GetxController {
  var quizGetList = <QuizGetClass>[].obs;
  var isLoading = false.obs;
  var searchQuery = ''.obs;
  var selectedCategory = ''.obs;
  var selectedSubCategory = ''.obs;
   var selectedQuizId = ''.obs;
 

  List<QuizGetClass> get filteredQuizList {
    return quizGetList.where((quiz) {
      bool matchesSearch = searchQuery.value.isEmpty ||
          (quiz.quizTitle?.toLowerCase().contains(searchQuery.value.toLowerCase()) ?? false);
      bool matchesCategory = selectedCategory.value.isEmpty || quiz.quizCategory == selectedCategory.value;
      bool matchesSubCategory = selectedSubCategory.value.isEmpty || quiz.quizSubCategory == selectedSubCategory.value;
      return matchesSearch && matchesCategory && matchesSubCategory;
    }).toList();
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  void setSelectedCategory(String category) {
    selectedCategory.value = category;
  }

  void setSelectedSubCategory(String subCategory) {
    selectedSubCategory.value = subCategory;
  }

  void updateLoader(bool loader) {
    isLoading.value = loader;
  }

  Future<void> getQuiz() async {
    updateLoader(true);
    try {
      final response = await ApiService.quizGetAPI(); 
      quizGetList.assignAll(response);
    } catch (e) {
      print('Error fetching quizzes: $e');
    } finally {
      updateLoader(false);
    }
  }

  void filterQuizzes(String query, String category, String subCategory) {
    setSearchQuery(query);
    setSelectedCategory(category);
    setSelectedSubCategory(subCategory);
  }
     @override
  void onInit() {
    super.onInit();
    getQuiz();
  }
   void resetSearch() {
    searchQuery.value = '';
    selectedCategory.value = '';
    selectedSubCategory.value = '';
    getQuiz(); 
  }
}

