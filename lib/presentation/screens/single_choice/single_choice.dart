
import 'package:RiddleQing/core/colors.dart';
import 'package:RiddleQing/core/storage_manager/local_storage_constants.dart';
import 'package:RiddleQing/data/models/questions_data.dart';
import 'package:RiddleQing/gen/fonts.gen.dart';
import 'package:RiddleQing/presentation/screens/answer_explanation/answer_exp.dart';
import 'package:RiddleQing/presentation/screens/controller/quiz_give_controller.dart';
import 'package:RiddleQing/presentation/screens/controller/quizsubmit_controller.dart';
import 'package:RiddleQing/presentation/screens/quiz_details/submit_button.dart';
import 'package:RiddleQing/presentation/widgets/common_ui_bg.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';


class SingleChoice extends StatefulWidget {
  final PageController pageController;
  final QuestionsData questionsData;
  final int questionNumber;
  final int totalQuestions;
  final String quizTakeId;
  final QuizGiveController quizGiveController;
  final String quizID;
  final QuizSubmitController quizSubmitController;
  final int quizDuration;


  const SingleChoice({
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
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  int? selectedIndex;
  String? errorMessage;
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
      print('Quiz Duration: ${widget.quizDuration}');
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
        SizedBox(height: 10),
        Expanded(
          child: CommonUIBG(
            widget: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Center(
                    child: CircleAvatar(
                      backgroundColor: Colours.onpressedbutton,
                      radius: 28,
                      child: Text(
                        '${widget.questionNumber}',
                        style: TextStyle(color: Colours.CardColour, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          "QUESTION ${widget.questionNumber} OF ${widget.totalQuestions}",
                          style: TextStyle(
                              fontFamily: FontFamily.rubik,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colours.textColour),
                        ),
                        SizedBox(height: 10),
                        Text(
                          widget.questionsData.questionData?.quesTitle ?? '',
                          style: TextStyle(
                              fontFamily: FontFamily.rubik,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colours.primaryColor),
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 2),
                            child: SizedBox(
                              height: 20,
                            )),
                        for (int index = 0;
                            index <
                                (widget.questionsData.answerData?.length ?? 0);
                            index++)
                          Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                child: Text(
                                  widget.questionsData.answerData?[index]
                                          .options ??
                                      '',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: FontFamily.rubik,
                                      color: selectedIndex == index ? Colours.CardColour : Colours.primaryColor),
                                ),
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(screenWidth * 0.8, 58),
                                  backgroundColor: selectedIndex == index ? Colours.primaryColor : null,
                                  padding: EdgeInsets.all(15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    side: BorderSide(
                                      color: selectedIndex == index ? Colours.primaryColor : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        Container(
                          margin: EdgeInsets.only(left: 5, right: 15),
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              if (errorMessage != null)
                                Text(
                                  errorMessage!,
                                  style: TextStyle(color: Colors.red),
                                ),
                              SubmitButton(
                                isLastQuestion: widget.questionNumber == widget.totalQuestions,
                                onPressed: () async {
                                  if (selectedIndex != null) {
                                    widget.quizGiveController.saveSelectedOption(widget.questionsData.questionData!.quesId!.toString(), selectedIndex!);
                                    
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
                                        ans_id: [widget.questionsData.answerData![selectedIndex!].answerId],
                                      );
              
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AnwserExpl(
                                            dataList: widget.quizSubmitController.quizsubmitapi.value.data,
                                            quizTakeId: widget.quizTakeId,
                                            quizDuration: (widget.quizDuration ?? 0) ,
                                         
                                           
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
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
