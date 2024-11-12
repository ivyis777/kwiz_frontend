
import 'package:RiddleQing/data/api_service.dart';
import 'package:RiddleQing/data/models/quiz_recent_class.dart';
import 'package:get/get.dart';



class RecentQuizController extends GetxController {
  var recentQuizData = QuizRecentClass().obs;
  var isLoading = false.obs;

  void updateLoading(bool load) {
    this.isLoading.value = load;
    update();
  }

  Future<void> fetchRecentQuiz(String userId) async {
    updateLoading(true);
    try {
      var response = await ApiService.QuizRecentapi(user_id: userId);
      this.recentQuizData.value = response;
      updateLoading(false);
    } catch (e) {
      updateLoading(false);
      throw Exception('Failed to get recent quiz: $e');
    }
  }
}
