import 'package:Kwiz/core/colors.dart';
import 'package:Kwiz/core/storage_manager/local_storage_constants.dart';
import 'package:Kwiz/data/models/questions_data.dart';
import 'package:Kwiz/gen/fonts.gen.dart';
import 'package:Kwiz/presentation/screens/answer_explanation/answer_exp.dart';
import 'package:Kwiz/presentation/screens/controller/quiz_give_controller.dart';
import 'package:Kwiz/presentation/screens/controller/quizsubmit_controller.dart';
import 'package:Kwiz/presentation/screens/quiz_details/submit_button.dart';
import 'package:Kwiz/presentation/widgets/common_ui_bg.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class MultipleAnswerType extends StatefulWidget {
  final PageController pageController;
  final QuestionsData questionsData;
  final int questionNumber;
  final int totalQuestions;
  final String quizTakeId;
  final QuizGiveController quizGiveController;
  final String quizID;
  final QuizSubmitController quizSubmitController;
  final int quizDuration; 
 
  
  const MultipleAnswerType({
    Key? key,
    required this.questionsData,
    required this.questionNumber,
    required this.totalQuestions,
    required this.pageController,
    required this.quizTakeId,
    required this.quizGiveController,
    required this.quizID,
    required this.quizSubmitController,
    required this.quizDuration,

  }) : super(key: key);

  @override
  State<MultipleAnswerType> createState() => _MultipleAnswerTypeState();
}

class _MultipleAnswerTypeState extends State<MultipleAnswerType> {
  List<String> answers = [];
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
      print('Quiz Duration: ${widget.quizDuration}');
    answers = widget.quizGiveController.getSelectedAnswers(widget.questionsData.questionData!.quesId!.toString());
    selectedIndex = widget.quizGiveController.getSelectedOption(widget.questionsData.questionData!.quesId!.toString());
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double padding = screenWidth * 0.05;
    double textFontSize = screenWidth * 0.04;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(height: screenHeight * 0.01),
        Expanded(
          child: CommonUIBG(
            widget: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  Container(
                    margin: EdgeInsets.only(left: padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: CircleAvatar(
                            backgroundColor: Colours.onpressedbutton,
                            radius: 28,
                            child: Text(
                              '${widget.questionNumber}',
                              style: TextStyle(
                                color: Colours.CardColour,
                                fontSize: textFontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          "QUESTION ${widget.questionNumber} OF ${widget.totalQuestions}",
                          style: TextStyle(
                            fontFamily: FontFamily.rubik,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colours.textColour,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          widget.questionsData.questionData?.quesTitle ?? '',
                          style: TextStyle(
                            fontFamily: FontFamily.rubik,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colours.primaryColor,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        for (int index = 0; index < (widget.questionsData.answerData ?? []).length; index++)
                          Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    var item = (widget.questionsData.answerData ?? [])[index].answerId.toString();
                                    if (answers.contains(item)) {
                                      answers.remove(item);
                                    } else {
                                      answers.add(item);
                                    }
                                    widget.quizGiveController.saveSelectedAnswers(widget.questionsData.questionData!.quesId!.toString(), answers);
                                    widget.quizGiveController.saveSelectedOption(widget.questionsData.questionData!.quesId!.toString(), index);
                                  });
                                },
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: answers.contains((widget.questionsData.answerData ?? [])[index].answerId.toString()),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          var item = (widget.questionsData.answerData ?? [])[index].answerId.toString();
                                          if (value!) {
                                            answers.add(item);
                                          } else {
                                            answers.remove(item);
                                          }
                                          widget.quizGiveController.saveSelectedAnswers(widget.questionsData.questionData!.quesId!.toString(), answers);
                                          widget.quizGiveController.saveSelectedOption(widget.questionsData.questionData!.quesId!.toString(), index);
                                        });
                                      },
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          (widget.questionsData.answerData ?? [])[index].options ?? '',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: FontFamily.rubik,
                                            color: Colours.primaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(screenWidth * 0.8, 56),
                                  padding: EdgeInsets.all(15),
                                  backgroundColor: null,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    side: BorderSide(color: Colors.grey),
                                  ),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.03),
                            ],
                          ),
                        SubmitButton(
                          isLastQuestion: widget.questionNumber == widget.totalQuestions,
                          onPressed: () async {
                            if (answers.isNotEmpty) {
                              final box = GetStorage();
                              if (widget.questionNumber < widget.totalQuestions) {
                                widget.quizGiveController.questionSaveMethod(
                                  quiz_take_id: widget.quizTakeId.toString(),
                                  user_id: box.read(LocalStorageConstants.userId).toString(),
                                  quiz_id: widget.quizID,
                                  ques_id: widget.questionsData.questionData!.quesId!.toString(),
                                  ans_id: answers,
                                );
                                widget.pageController.nextPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeIn,
                                );
                              } else {
                                await widget.quizSubmitController.getQuizSubmitUser(
                                  quiz_take_id: widget.quizTakeId.toString(),
                                  user_id: box.read(LocalStorageConstants.userId).toString(),
                                  quiz_id: widget.quizID,
                                  ques_id: widget.questionsData.questionData!.quesId!.toString(),
                                  ans_id: answers,
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AnwserExpl(
                                      quizDuration: widget.quizDuration ,
                                      dataList: widget.quizSubmitController.quizsubmitapi.value.data,
                                      quizTakeId: widget.quizTakeId,
                                      
                                      
                                      
                                    ),
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Please select at least one option before proceeding.",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colours.yellowcolor,
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.only(top: 10),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
