
import 'package:RiddleQing/data/api_service.dart';
import 'package:RiddleQing/data/models/quiz_result_model.dart';
import 'package:get/get.dart';

import 'dart:core';

class QuizResultController extends GetxController {
  var quizresultapi = QuizResultModel().obs;
  var isLoading = false.obs;

  void updateLoading(bool load) {
    this.isLoading.value = load;
    update();
  }

  Future<QuizResultModel?> getQuizResultUser({
    required  quiz_take_id,
    required String user_id,
    required bool isSubmit
   
  }) async {
    updateLoading(true);
    try {
      var response = await ApiService.QuizResultapi(
        quiz_take_id: quiz_take_id,
        user_id: user_id,
        isSubmit:isSubmit

       
      );
      this.quizresultapi.value = response;
      updateLoading(false);
      return response;
    } catch (e) {
      updateLoading(false);
      throw Exception('Failed to get quiz result: $e');
    }
  }
}

 