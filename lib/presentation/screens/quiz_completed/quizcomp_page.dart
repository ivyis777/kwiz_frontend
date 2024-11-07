import 'package:Kwiz/core/colors.dart';
import 'package:Kwiz/core/storage_manager/local_storage_constants.dart';
import 'package:Kwiz/gen/assets.gen.dart';
import 'package:Kwiz/gen/fonts.gen.dart';
import 'package:Kwiz/presentation/screens/controller/recent_quiz_controller.dart';
import 'package:Kwiz/presentation/screens/controller/wallet_balance_controller.dart';
import 'package:Kwiz/presentation/screens/quiz_completed/quizcomp_constants.dart';
import 'package:Kwiz/utils/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';



class QuizComplete extends StatefulWidget {
  final int correctAnswers;
  final int incorrectAnswers;
  final int totalNoOfQuestion;

  const QuizComplete({
    Key? key,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.totalNoOfQuestion,
  }) : super(key: key);

  @override
  State<QuizComplete> createState() => _QuizCompleteState();
}

class _QuizCompleteState extends State<QuizComplete> {
  bool _isProcessing = false;
  final walletBalanceController = Get.put<WalletBalanceController>(WalletBalanceController());
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          QuizCompleteConstants.appbar1,
          style: TextStyle(
            color: Colours.primaryColor,
            fontFamily: FontFamily.rubik,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        foregroundColor: Colours.CardColour,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colours.primaryColor,
          size: 25,
        ),
        backgroundColor: Colours.CardColour,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.cancel,
              color: Colours.primaryColor,
            ),
          ),
        ],
      ),
      backgroundColor: Colours.CardColour,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: screenWidth * 0.025),
            height: screenHeight * 0.3,
            width: screenWidth * 0.9,
            child: Card(
              color: Colours.onpressedbutton,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.025),
                  Image.asset(
                    Assets.images.quizcompleted.path,
                    width: screenWidth * 0.6,
                    height: screenHeight * 0.2,
                  ),
                
                ],
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.05),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: screenWidth * 0.02,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Text(
                        QuizCompleteConstants.numberofques,
                        style: TextStyle(
                          color: Colours.textColour,
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "${widget.totalNoOfQuestion} questions",
                        style: TextStyle(
                          color: Colours.primaryColor,
                          fontFamily: FontFamily.rubik,
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        QuizCompleteConstants.incorrectanswers,
                        style: TextStyle(
                          color: Colours.textColour,
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "${widget.incorrectAnswers} questions",
                        style: TextStyle(
                          color: Colours.primaryColor,
                          fontFamily: FontFamily.rubik,
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Text(
                        QuizCompleteConstants.correctanswer,
                        style: TextStyle(
                          color: Colours.textColour,
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "${widget.correctAnswers} questions",
                        style: TextStyle(
                          color: Colours.primaryColor,
                          fontFamily: FontFamily.rubik,
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        Container(
  margin: EdgeInsets.only(left: screenWidth * 0.06, bottom: screenHeight * 0.12),
  child: Row(
    children: [
      Row(
        children: [
          SizedBox(height: screenHeight * 0.015),
          ElevatedButton(
            onPressed: _isProcessing
                ? null
                : () async {
                    setState(() {
                      _isProcessing = true; // Start processing and disable the button
                    });

                    final recentQuizController = Get.put<RecentQuizController>(RecentQuizController());
                    final box = GetStorage();
                    final userId = box.read(LocalStorageConstants.userId).toString();
                    
                    try {
                      await recentQuizController.fetchRecentQuiz(userId);
                      Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainLayout()));
                    } catch (e) {
                      print('Error occurred: $e');
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
                : Text(
                    QuizCompleteConstants.text12,
                    style: TextStyle(
                      color: Colours.CardColour,
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(screenWidth * 0.65, screenHeight * 0.07),
              backgroundColor: Colours.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.1),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.share,
              color: Colours.primaryColor,
            ),
          ),
        ],
      ),
    ],
  ),
),

        ],
      ),
    
   );
  }
}
