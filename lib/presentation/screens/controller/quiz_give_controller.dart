import 'package:Kwiz/data/api_service.dart';
import 'package:Kwiz/data/models/Subscribed_quizes.dart';
import 'package:Kwiz/data/models/quiz_give.dart';
import 'package:Kwiz/data/models/quiz_recent_class.dart';
import 'package:Kwiz/data/models/quiz_take.dart';
import 'package:Kwiz/data/models/quiz_take_mata.dart';
import 'package:get/get.dart';


class QuizGiveController extends GetxController {
  var quizGive = QuizGive().obs;
  var quizRecentClass = QuizRecentClass().obs;
  var quizTakeMeta = QuizTakeMeta().obs;
  var questionSave = QuizTake().obs;
  var subscribedQuiz = SubscribedQuizzes(); 
  var selectedAnswers = <String, List<String>>{}.obs;
  var selectedOptions = <String, int>{}.obs; 

  Future<void> quizGiveMethod({required String quiz_id,required String user_id}) async {
    var response = await ApiService.quizGiveAPI(quiz_id: quiz_id,user_id: user_id);
    this.quizGive.value = response;
    update();
  }

  Future<void> partialQuizDataMethod({required String quizTakeID}) async {
    var response = await ApiService.partialQuizData(quizTakeID);
    this.quizRecentClass.value = response;
    update();
  }

  Future<void> quizTakeMetaMethod(
      {required String user_id,
      required String quiz_id,
      required String status}) async {
    var response = await ApiService.quizTakeMeta( 
        user_id: user_id, quiz_id: quiz_id, status: status);
    this.quizTakeMeta.value = response;
       print('Quiz Duration in Controller: ${quizTakeMeta.value.quizDuration}');
    update();
  }

  Future<void> questionSaveMethod(
      {required String quiz_take_id,
      required String user_id,
      required String quiz_id,   
      required String ques_id,
      required List<dynamic> ans_id}) async {
    var response = await ApiService.questionSave(
        quiz_take_id: quiz_take_id,
        user_id: user_id,
        quiz_id: quiz_id,
        ques_id: ques_id,
        ans_id: ans_id.map((id) => id.toString()).toList());
    this.questionSave.value = response;
    update();
  }

  void saveSelectedAnswers(String quesId, List<String> selectedAnswersList) {
    selectedAnswers[quesId] = selectedAnswersList;
    update();
  }

  List<String> getSelectedAnswers(String quesId) {
    return selectedAnswers[quesId] ?? [];
  }

  void saveSelectedOption(String quesId, int selectedIndex) {
    selectedOptions[quesId] = selectedIndex;
    update(); 
  }

  int? getSelectedOption(String quesId) {
    return selectedOptions[quesId];
  }
}
