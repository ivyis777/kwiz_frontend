import 'package:Kwiz/core/colors.dart';
import 'package:Kwiz/gen/assets.gen.dart';
import 'package:Kwiz/gen/fonts.gen.dart';
import 'package:Kwiz/presentation/screens/controller/question_controller.dart';
import 'package:Kwiz/presentation/screens/controller/quiz_give_controller.dart';
import 'package:Kwiz/presentation/screens/controller/wallet_balance_controller.dart';
import 'package:Kwiz/presentation/screens/quiz_details/quizdetails_contants.dart';
import 'package:Kwiz/presentation/screens/quiz_give/quiz_give_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/storage_manager/local_storage_constants.dart';

class QuizDetails extends StatefulWidget {
  final String quizId;
  final int? quizDuration;
  final String quizDescription;
  final String createdBy;
  final int noOfMarks;
  final int numberOfQuestions;
  
  const QuizDetails({Key? key,  required this.quizId,
    this.quizDuration,
    required this.quizDescription,
    required this.createdBy,
    required this.noOfMarks,
    required this.numberOfQuestions,}) : super(key: key);

  @override
  State<QuizDetails> createState() => _QuizDetailsState();
}
class _QuizDetailsState extends State<QuizDetails> {
  bool _isProcessing = false;

  final questionController = Get.put<QuestionController>(QuestionController());
  final quizGiveController = Get.put<QuizGiveController>(QuizGiveController());

 
  final walletBalanceController = Get.put<WalletBalanceController>(WalletBalanceController());
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.primaryColor,
        foregroundColor: Colours.CardColour,
      ),
      backgroundColor: Colours.primaryColor,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
             SizedBox(height: 20),
               Image.asset(
                Assets.images.quizdetail.path,
                width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
            Obx(() {
              if (questionController.isLoading.value) {
                return CircularProgressIndicator();
              } else {
                var basic = questionController.questionList.isNotEmpty
                    ? questionController.questionList.first.basic?.first
                    : null;
                var title = basic?.quizTitle ?? '';
                var category = basic?.quizCategory ?? '';
                var description = basic?.quizDescription ?? '';

                var questionType = questionController.questionList.isNotEmpty
                    ? questionController.questionList.first.question?.first.quesType ?? ''
                    : '';

                return Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 8, right: 8),
                    width: 379,
                    height: 504,
                    child: Card(
                      color: Colours.CardColour,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 18),
                            child: Text(
                              category,
                              style: TextStyle(
                                fontFamily: FontFamily.rubik,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colours.textColour,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 18),
                            child: Text(
                              title,
                              style: TextStyle(
                                fontFamily: FontFamily.rubik,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Colours.darkblueColor,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 12),
                            width: 335,
                            height: 64,
                            child: Card(
                              color: Colours.secondaryColour,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                    height: 10,
                                  ),
                                  Image.asset(Assets.images.icon5.path),
                                  SizedBox(width: 5, height: 10),
                                  Text(
                                    "${widget.numberOfQuestions} Questions",
                                    style: TextStyle(
                                      fontFamily: FontFamily.rubik,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(width: 10, height: 10),
                                        Image.asset(Assets.images.icon6.path),
                                        SizedBox(width: 5, height: 10),
                                        Text(
                                        "${widget.noOfMarks} Points",
                                          style: TextStyle(
                                            fontFamily: FontFamily.rubik,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                Text(
                                  widget.quizDescription,
                                  style: TextStyle(
                                    fontFamily: FontFamily.rubik,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colours.primaryColor,
                                  ),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  description,
                                  style: TextStyle(
                                    fontFamily: FontFamily.rubik,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colours.darkblueColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(Assets.images.boyicon.path),
                                SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.createdBy,
                                      style: TextStyle(
                                        fontFamily: FontFamily.rubik,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colours.darkblueColor,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      QuizDetailsConstants.textcard8,
                                      style: TextStyle(
                                        fontFamily: FontFamily.rubik,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colours.textColour,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                 SizedBox(height: 20),
Container(
  margin: EdgeInsets.only(left: 20),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(height: 20),
      Center(
        child: ElevatedButton(
          onPressed: _isProcessing
              ? null
              : () async {
                  setState(() {
                    _isProcessing = true;
                  });

                  final box = GetStorage();
                  final userId = box.read(LocalStorageConstants.userId).toString();
                  try {
                    await quizGiveController.quizTakeMetaMethod(
                      user_id: userId,
                      quiz_id: widget.quizId,
                      status: "On-going",
                    );

                    print('Quiz Duration: ${quizGiveController.quizTakeMeta.value.quizDuration}');
                    Get.offAll(QuizGiveUi(
                      quizId: widget.quizId ?? '',
                      quizTakeId: quizGiveController.quizTakeMeta.value.quizTakeId?.toString() ?? '',
                      quizDuration: (widget.quizDuration ?? 0) * 60,
                    ));

                    print((widget.quizDuration ?? 0) * 60);
                  } finally {
                    setState(() {
                      _isProcessing = false; // Stop processing and re-enable the button
                    });
                  }
                },
          child: _isProcessing
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colours.CardColour),
                )
              : Container(
                  child: Center(
                    child: Text(
                      QuizDetailsConstants.play,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: FontFamily.rubik,
                        color: Colours.CardColour,
                      ),
                    ),
                  ),
                ),
          style: ElevatedButton.styleFrom(
            fixedSize: Size(169, 56),
            backgroundColor: Colours.buttonColour,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
    ],
  ),
),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            }),
          ]
        ),
      ),
     
    );
  }
}

