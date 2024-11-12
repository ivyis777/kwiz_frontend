
import 'package:RiddleQing/core/colors.dart';
import 'package:RiddleQing/presentation/screens/controller/quiz_give_controller.dart';
import 'package:RiddleQing/presentation/screens/controller/quiz_result_controller.dart';
import 'package:RiddleQing/presentation/screens/controller/quizsubmit_controller.dart';
import 'package:RiddleQing/presentation/screens/multiple_answer/multipleanswertype.dart';
import 'package:RiddleQing/presentation/screens/quiz_completed/quizcomp_page.dart';
import 'package:RiddleQing/presentation/screens/single_choice/single_choice.dart';
import 'package:RiddleQing/presentation/screens/true_or_false_type/trueorfalse.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


import 'dart:async';

import '../../../core/storage_manager/local_storage_constants.dart';

class QuizGiveUi extends StatefulWidget {
  final String quizId;
  final String quizTakeId;
  final int quizDuration;
  final int elapsedSeconds; 
   
  

  const QuizGiveUi({
    Key? key,
    required this.quizId,
    required this.quizTakeId,
    required this.quizDuration,
    this.elapsedSeconds = 0,
  }) : super(key: key);

  @override
  State<QuizGiveUi> createState() => _QuizGiveUiState();
}

class _QuizGiveUiState extends State<QuizGiveUi> {
  final quizGiveController = Get.put<QuizGiveController>(QuizGiveController());
   final QuizSubmitController _quizSubmitController =
      Get.put(QuizSubmitController());
  final QuizResultController _quizresultController =
      Get.put(QuizResultController());
  final quizSubmitController = Get.put<QuizSubmitController>(QuizSubmitController());
  final controller = PageController(initialPage: 0);
  bool showBackButton = false;
  final box = GetStorage();
  int timerValue = 0;
  late Timer _quizTimer;
  late int _remainingSeconds;
  late DateTime _quizStartTime;
 
  @override
  void initState() {
    super.initState();
   print((widget.quizDuration)*60);
     
    _remainingSeconds = widget.quizDuration - widget.elapsedSeconds;
    _quizStartTime = DateTime.now();
    _startTimer();
    final box = GetStorage();
     var user_id = box.read(LocalStorageConstants.userId); 
    box.write('quizStartTime', DateTime.now().toIso8601String());
    quizGiveController.quizGiveMethod(quiz_id: widget.quizId,user_id: user_id.toString());
    quizGiveController.partialQuizDataMethod(quizTakeID: widget.quizTakeId.toString());

    controller.addListener(() {
      setState(() {
        showBackButton = controller.page! > 0;
      });
    });
  }

  @override
  void dispose() {
    _quizTimer.cancel();
    controller.dispose();
    super.dispose();
  }

  String _getFormattedTimerValue() {
    int totalSeconds = widget.quizDuration * 60 - _remainingSeconds;
    int hours = totalSeconds ~/ 3600;
    int minutes = (totalSeconds % 3600) ~/ 60;
    int seconds = totalSeconds % 60;
    int milliseconds = (DateTime.now().difference(_quizStartTime).inMilliseconds % 1000);
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}:${milliseconds.toString().padLeft(3, '0')}';
  }


  Future<void> _handleQuizCompletion() async {
        final timerValue = _getFormattedTimerValue();
        print('timer value : ${timerValue} _getformatted : ${_getFormattedTimerValue()}');
    final box = GetStorage();
    final userId = box.read(LocalStorageConstants.userId).toString();


    try {
      await _quizresultController.getQuizResultUser(
        quiz_take_id: widget.quizTakeId.toString(),
        user_id: userId,
        
        isSubmit: false
      );
      print(timerValue);
      final quizResult = _quizresultController.quizresultapi.value;

      Get.offAll(() => QuizComplete(
        correctAnswers: quizResult.correctAnswers ?? 0,
        incorrectAnswers: quizResult.incorrectAnswers ?? 0,
        totalNoOfQuestion: quizResult.totalNoOfQuestions ?? 0,
      ));
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  void navigateBack() {
    if (controller.page! > 0) {
      controller.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

   void _startTimer() {
    _quizTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
        _handleQuizCompletion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.primaryColor,
        foregroundColor: Colours.CardColour,
        leading: showBackButton && controller.page! > 0
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: navigateBack,
              )
            : null,
      ),
      backgroundColor: Colours.primaryColor,
      body: Obx(() {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Text(
                'Time Left: ${(_remainingSeconds ~/ 60).toString().padLeft(2, '0')}:${(_remainingSeconds % 60).toString().padLeft(2, '0')}',
                style: TextStyle(
                  color: _remainingSeconds <= 120 ? Colors.red : Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: controller,
                physics: NeverScrollableScrollPhysics(),
                itemCount: (quizGiveController.quizGive.value.questionsData ?? []).length,
                itemBuilder: (BuildContext context, int index) {
                  return (quizGiveController.quizGive.value.questionsData ?? [])[index].questionData?.quesType == "1"
                      ? TrueOrFalseType(
                          quizGiveController: quizGiveController,
                          quizSubmitController: quizSubmitController,
                          quizTakeId: widget.quizTakeId,
                          pageController: controller,
                          totalQuestions: (quizGiveController.quizGive.value.questionsData ?? []).length,
                          questionsData: (quizGiveController.quizGive.value.questionsData ?? [])[index],
                          questionNumber: index + 1,
                          quizID: widget.quizId,
                          quizDuration: (widget.quizDuration ?? 0) ,
                         
                        
                          
                        )
                        
                      : (quizGiveController.quizGive.value.questionsData ?? [])[index].questionData?.quesType == "2"
                          ? MultipleAnswerType(
                              quizGiveController: quizGiveController,
                              quizSubmitController: quizSubmitController,
                              quizTakeId: widget.quizTakeId,
                              pageController: controller,
                              totalQuestions: (quizGiveController.quizGive.value.questionsData ?? []).length,
                              questionsData: (quizGiveController.quizGive.value.questionsData ?? [])[index],
                              questionNumber: index + 1,
                              quizID: widget.quizId,
                              quizDuration: (widget.quizDuration ?? 0) ,
                            
                            )
                          : (quizGiveController.quizGive.value.questionsData ?? [])[index].questionData?.quesType == "3"
                              ? SingleChoice(
                                  quizGiveController: quizGiveController,
                                  quizSubmitController: quizSubmitController,
                                  quizTakeId: widget.quizTakeId,
                                  pageController: controller,
                                  totalQuestions: (quizGiveController.quizGive.value.questionsData ?? []).length,
                                  questionsData: (quizGiveController.quizGive.value.questionsData ?? [])[index],
                                  questionNumber: index + 1,
                                  quizID: widget.quizId,
                                  quizDuration: (widget.quizDuration ?? 0) ,
                                
                                )
                              : SizedBox();
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
