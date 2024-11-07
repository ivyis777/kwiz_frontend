import 'package:Kwiz/data/api_service.dart';
import 'package:Kwiz/data/models/completed_quiz_model.dart';
import 'package:get/get.dart';


class CompletedQuizController extends GetxController {
  var completedQuizData = CompletedQuizModel().obs;
  var isLoading = false.obs;

  void updateLoading(bool load) {
    isLoading.value = load;
    update();
  }

  Future<void> fetchCompletedQuizzes(String userId) async {
    updateLoading(true);
    try {
      var response = await ApiService.CompletedQuizapi(user_id: userId);
      // Print the response data received from the backend
      print('Response from backend: $response');
      completedQuizData.value = response;
      updateLoading(false);
    } catch (e) {
      updateLoading(false);
      var errorMessage = 'An error occurred while fetching completed quizzes';
      if (e.toString().contains('400')) {
        errorMessage = 'User ID is required';
      } else if (e.toString().contains('401')) {
        errorMessage = 'User ID is not registered';
      } else if (e.toString().contains('405')) {
        errorMessage = 'Invalid JSON format';
      }
      print('Error: $errorMessage');
      throw Exception(errorMessage);
    }
  }
}
