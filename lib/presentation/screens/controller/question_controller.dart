
import 'package:RiddleQing/data/api_service.dart';
import 'package:RiddleQing/data/models/question_models.dart';
import 'package:get/get.dart';


class QuestionController extends GetxController {
  var questionList = <QuestionClass>[].obs;
  var isLoading = false.obs;

  void updateLoader(bool loader) {
    isLoading.value = loader;
  }

  Future<void> questionQuiz() async {
    updateLoader(true);

    // Creating an instance of ApiService
    final apiService = ApiService();

    // Calling questionAPI on the instance
    final response = await apiService.questionAPI();

    questionList.value = response;
    updateLoader(false);
  }
}
