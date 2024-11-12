
import 'package:RiddleQing/data/api_service.dart';
import 'package:RiddleQing/data/models/Subscribed_quizes.dart';
import 'package:get/get.dart';


class SubscribedQuizController extends GetxController {
  var subscribedQuizData = SubscribedQuizModel().obs;
  var isLoading = false.obs;

  void updateLoading(bool load) {
    this.isLoading.value = load;
    update();
  }

  Future<void> fetchRecentQuiz(String userId) async {
    updateLoading(true);
    try {
      var response = await ApiService.SubscriptedQuizapi(user_id: userId);
      this.subscribedQuizData.value = response;
      updateLoading(false);
    } catch (e) {
      updateLoading(false);
      throw Exception('Failed to get subscribed quizes: $e');
    }
  }
}
