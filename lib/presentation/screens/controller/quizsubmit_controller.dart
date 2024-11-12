
import 'package:RiddleQing/data/api_service.dart';
import 'package:RiddleQing/data/models/quiz_submit_model.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/state_manager.dart';


class QuizSubmitController extends GetxController {
  var quizsubmitapi = QuizSubmit().obs;
  var isLoading = false.obs;
   


  void updateLoading(bool load) {
    this.isLoading.value = load;
    update();
  }
   Future<void> getQuizSubmitUser (
      {required String quiz_take_id,
      required String user_id,
      required String quiz_id,
      required String ques_id,
      required List<dynamic> ans_id}) async {
    var response = await ApiService.quizsubmitapi(
        quiz_take_id: quiz_take_id,
        user_id: user_id,
        quiz_id: quiz_id,
        ques_id: ques_id,
        ans_id: ans_id.map((id) => id.toString()).toList());
    this.quizsubmitapi.value = response;
    update();
  }}