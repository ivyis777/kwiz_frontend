
import 'package:RiddleQing/core/colors.dart';
import 'package:RiddleQing/core/storage_manager/local_storage_constants.dart';
import 'package:RiddleQing/data/models/questions_data.dart';
import 'package:RiddleQing/gen/assets.gen.dart';
import 'package:RiddleQing/gen/fonts.gen.dart';
import 'package:RiddleQing/presentation/screens/answer_explanation/answer_exp.dart';
import 'package:RiddleQing/presentation/screens/controller/quiz_give_controller.dart';
import 'package:RiddleQing/presentation/screens/controller/quizsubmit_controller.dart';
import 'package:RiddleQing/presentation/screens/quiz_details/submit_button.dart';
import 'package:RiddleQing/presentation/widgets/common_ui_bg.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';


class TrueOrFalseType extends StatefulWidget {
  final PageController pageController;
  final QuestionsData questionsData;
  final int questionNumber;
  final int totalQuestions;
  final String quizTakeId;
  final QuizGiveController quizGiveController;
  final String quizID;
  final QuizSubmitController quizSubmitController;
  final int quizDuration;


  const TrueOrFalseType({
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
  State<TrueOrFalseType> createState() => _TrueOrFalseTypeState();
}

class _TrueOrFalseTypeState extends State<TrueOrFalseType> {
  int? selectedIndex;
  String? errorMessage;
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
      print('Quiz Duration: ${widget.quizDuration}');
    // Restore the selected index from the stored state
    selectedIndex = widget.quizGiveController.getSelectedOption(widget.questionsData.questionData!.quesId!.toString());
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double padding = screenWidth * 0.05;
    double textFontSize = screenWidth * 0.04;

    bool hasValidAnswers = widget.questionsData.answerData != null && widget.questionsData.answerData!.length >= 2;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(height: screenHeight * 0.02),
        Expanded(
          child: CommonUIBG(
            widget: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  Center(
                    child: CircleAvatar(
                      backgroundColor: Colours.onpressedbutton,
                      radius: screenWidth * 0.07,
                      child: Text(
                        '${widget.questionNumber}',
                        style: TextStyle(
                          color: Colours.CardColour,
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Container(
                    margin: EdgeInsets.only(left: 50),
                    child: Image.asset(Assets.images.trueorfalse.path),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'QUESTION ${widget.questionNumber} OF ${widget.totalQuestions}',
                          style: TextStyle(
                            fontFamily: FontFamily.rubik,
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w400,
                            color: Colours.textColour,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          widget.questionsData.questionData?.quesTitle ?? '',
                          style: TextStyle(
                            fontFamily: FontFamily.rubik,
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w400,
                            color: Colours.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  if (hasValidAnswers)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: padding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                selectedIndex = 0;
                              });
                            },
                            child: Text(
                              widget.questionsData.answerData![0].options ?? '',
                              style: TextStyle(
                                fontFamily: FontFamily.rubik,
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.w500,
                                color: Colours.CardColour,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.02,
                                horizontal: screenWidth * 0.06,
                              ),
                              backgroundColor: selectedIndex == 0
                                  ? Colours.primaryColor
                                  : Colours.textColour,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(screenWidth * 0.05),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                selectedIndex = 1;
                              });
                            },
                            child: Text(
                              widget.questionsData.answerData![1].options ?? '',
                              style: TextStyle(
                                fontFamily: FontFamily.rubik,
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.w500,
                                color: Colours.CardColour,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.02,
                                horizontal: screenWidth * 0.06,
                              ),
                              backgroundColor: selectedIndex == 1
                                  ? Colours.primaryColor
                                  : Colours.textColour,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(screenWidth * 0.05),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: padding),
                      child: Text(
                        'No valid answers available for this question.',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                    ),
                  SizedBox(height: screenHeight * 0.03),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding),
                    child: Column(
                      children: [
                        if (errorMessage != null)
                          Text(
                            errorMessage!,
                            style: TextStyle(color: Colors.red),
                          ),
                        SubmitButton(
                          isLastQuestion: widget.questionNumber == widget.totalQuestions,
                          onPressed: () async {
                            if (selectedIndex != null && hasValidAnswers) {
                              widget.quizGiveController.saveSelectedOption(
                                  widget.questionsData.questionData!.quesId!.toString(),
                                  selectedIndex!);
              
                              if (widget.questionNumber < widget.totalQuestions) {
                                widget.quizGiveController.questionSaveMethod(
                                  quiz_take_id: widget.quizTakeId,
                                  user_id: box.read(LocalStorageConstants.userId).toString(),
                                  quiz_id: widget.quizID,
                                  ques_id: widget.questionsData.questionData!.quesId!.toString(),
                                  ans_id: [widget.questionsData.answerData![selectedIndex!].answerId.toString()],
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
                                  ans_id: [
                                    widget.questionsData.answerData![selectedIndex!].answerId,
                                  ],
                                );
              
                                Navigator.push(
                                  
                                  context,
                                  
                                  MaterialPageRoute(
                                    builder: (context) => 
                                    AnwserExpl(
                                      
                                      dataList: widget.quizSubmitController.quizsubmitapi.value.data,
                                      quizTakeId: widget.quizTakeId,
                                      quizDuration: (widget.quizDuration ?? 0),
                                   
                                      
                                    ), 
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Please select an option before proceeding.",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor:Colours.yellowcolor,
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
