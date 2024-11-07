import 'package:Kwiz/data/api_service.dart';
import 'package:Kwiz/data/models/QuizSubscription.dart';
import 'package:get/get.dart';


class QuizSubscriptionController extends GetxController {
  var isLoading = false.obs;

  void updateLoading(bool load) {
    this.isLoading.value = load;
    update();
  }

  Future<QuizSubscriptionModel> getQuizSubscriptionUser({
    required String user_id,
    required String quiz_id,
  
  }) async {
    updateLoading(true);
    final response = await ApiService.QuizSubscriptionapi(
      user_id: user_id,
      quiz_id: quiz_id,
    

    );
    updateLoading(false);
    return response;
  }
}






