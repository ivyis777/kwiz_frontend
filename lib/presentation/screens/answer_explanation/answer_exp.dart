
import 'package:RiddleQing/core/colors.dart';
import 'package:RiddleQing/core/storage_manager/local_storage_constants.dart';
import 'package:RiddleQing/data/models/quiz_submit_model.dart' as quizModel;
import 'package:RiddleQing/gen/assets.gen.dart';
import 'package:RiddleQing/gen/fonts.gen.dart';
import 'package:RiddleQing/presentation/screens/answer_explanation/answerexp_constants.dart';
import 'package:RiddleQing/presentation/screens/controller/quiz_result_controller.dart';
import 'package:RiddleQing/presentation/screens/controller/quizsubmit_controller.dart';
import 'package:RiddleQing/presentation/screens/controller/wallet_balance_controller.dart';
import 'package:RiddleQing/presentation/screens/home/home_constraints.dart';
import 'package:RiddleQing/presentation/screens/home/home_page.dart';
import 'package:RiddleQing/presentation/screens/quiz_completed/quizcomp_page.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';



class AnwserExpl extends StatefulWidget {
  final List<quizModel.Data>? dataList;
  final String quizTakeId;
  final int quizDuration;


  const AnwserExpl({
    Key? key,
    this.dataList,
    required this.quizTakeId,
    required this.quizDuration,
    
  }) : super(key: key);

  @override
  State<AnwserExpl> createState() => _AnwserExplState();
}



class _AnwserExplState extends State<AnwserExpl> {
  bool _isProcessing = false;
  late PageController _pageController;
  final QuizSubmitController _quizSubmitController =
      Get.put(QuizSubmitController());
  final QuizResultController _quizresultController =
      Get.put(QuizResultController());
  
  int _selectedIndex = 0;
  late String formattedTime;
  @override
  void initState() {
    super.initState();
    print(widget.quizDuration);
     _pageController = PageController();
      
  }
void goToFirstPage() {
  if (_pageController.hasClients) {
    _pageController.animateToPage(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  } else {
    print("PageController is not attached to any scroll view.");
  }
}
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

 
  
  final walletBalanceController =
      Get.put<WalletBalanceController>(WalletBalanceController());
 
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AnswerConstants.appbar,
          style: TextStyle(
            color: Colours.CardColour,
            fontFamily: FontFamily.rubik,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colours.primaryColor,
        foregroundColor: Colours.CardColour,
        iconTheme: IconThemeData(
          color: Colours.CardColour,
          size: 25,
        ),
       
      ),
      backgroundColor: Colours.CardColour,
      body:  PageView(
      controller: _pageController,
        children: [Obx(
          () => _quizSubmitController.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(constraints.maxWidth < 600 ? 10.0 : 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15),
                            Container(
                              child: Center(child: Image.asset(Assets.images.review.path)),
                            ),
                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25),
                              child: Text(
                                AnswerConstants.text4,
                                style: TextStyle(
                                  fontFamily: FontFamily.rubik,
                                  fontSize: 18,
                                  color: Colours.cardTextColour,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (int i = 0; i < (widget.dataList?.length ?? 0); i++)
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${widget.dataList![i].question}',
                                          style: TextStyle(
                                            fontFamily: FontFamily.rubik,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colours.primaryColor,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        for (var answer in widget.dataList![i].answer ?? [])
                                          Text(
                                            answer,
                                            style: TextStyle(
                                              fontFamily: FontFamily.rubik,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Colours.cardTextColour,
                                            ),
                                          ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: (){
                                          Navigator.of(context).pop(); 
                                      },
                                      child: Text(
                                        AnswerConstants.editanswer,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: FontFamily.rubik,
                                          color: Colours.CardColour,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        fixedSize: Size(double.infinity, 50),
                                        backgroundColor: Colours.buttonColour,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),
                                    ),
                                  ),
                                 SizedBox(width: 20),
Expanded(
  child: ElevatedButton(
    onPressed: _isProcessing
        ? null
        : () async {
            setState(() {
              _isProcessing = true; // Start processing and disable the button
            });

            final box = GetStorage();
            final userId = box.read(LocalStorageConstants.userId).toString();

            try {
              await _quizresultController.getQuizResultUser(
                quiz_take_id: widget.quizTakeId.toString(),
                user_id: userId,
                isSubmit: true,
              );

              final quizResult = _quizresultController.quizresultapi.value;

              Get.offAll(() => QuizComplete(
                correctAnswers: quizResult.correctAnswers ?? 0,
                incorrectAnswers: quizResult.incorrectAnswers ?? 0,
                totalNoOfQuestion: quizResult.totalNoOfQuestions ?? 0,
              ));
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
            AnswerConstants.cardtext14,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: FontFamily.rubik,
              color: Colours.CardColour,
            ),
          ),
    style: ElevatedButton.styleFrom(
      fixedSize: Size(double.infinity, 50),
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
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colours.CardColour,
                content: Text(
                  HomeConstaints.popuptext3,
                  style: TextStyle(
                    fontFamily: FontFamily.rubik,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colours.primaryColor,
                  ),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(); 
                            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
                          },
                          child: Text(
                            HomeConstaints.popuptext5,
                            style: TextStyle(
                              fontFamily: FontFamily.rubik,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colours.CardColour,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colours.primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colours.CardColour,
                                  content: Text(
                                    "Wow! Thanks for applying \n for the creator role our \n team will connect with \n you shortly Thanks",
                                    style: TextStyle(
                                      fontFamily: FontFamily.rubik,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      color: Colours.primaryColor,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    Center(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
                                        },
                                        child: Text(
                                          "Done",
                                          style: TextStyle(
                                            fontFamily: FontFamily.rubik,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colours.CardColour,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colours.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text(
                            HomeConstaints.popuptext4,
                            style: TextStyle(
                              fontFamily: FontFamily.rubik,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colours.CardColour,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colours.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
        child: Icon(
          Icons.add,
          color: Colours.primaryColor,
        ),
        backgroundColor: Colours.CardColour,
        shape: CircleBorder(),
      ),
      
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
