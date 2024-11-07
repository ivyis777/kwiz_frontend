import 'package:Kwiz/data/api_service.dart';
import 'package:Kwiz/data/models/creator_quiz_model.dart';
import 'package:get/get.dart';


class CreatorQuizController extends GetxController {
  var creatorQuizData = CreatorQuizModel().obs;
  var isLoading = false.obs;

  void updateLoading(bool load) {
    this.isLoading.value = load;
    update();
  }

  Future<void> fetchRecentQuiz(String userId) async {
    updateLoading(true);
    try {
      var response = await ApiService.CreatorQuizapi(user_id: userId);
      this.creatorQuizData.value = response;
      updateLoading(false);
    } catch (e) {
      updateLoading(false);
      throw Exception('Failed to get subscribed quizes: $e');
    }
  }
}
