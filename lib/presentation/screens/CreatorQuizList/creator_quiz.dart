import 'package:Kwiz/core/colors.dart';
import 'package:Kwiz/gen/assets.gen.dart';
import 'package:Kwiz/gen/fonts.gen.dart';
import 'package:Kwiz/presentation/screens/controller/creator_quiz_controller.dart';
import 'package:Kwiz/presentation/screens/controller/wallet_balance_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class QuizCreatorPage extends StatefulWidget {
  @override
  State<QuizCreatorPage> createState() => _QuizCreatorState();
}

class _QuizCreatorState extends State<QuizCreatorPage> {
  int _selectedIndex = 0;
  final creatorQuizController = Get.put<CreatorQuizController>(CreatorQuizController());
  final walletBalanceController = Get.put<WalletBalanceController>(WalletBalanceController());

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Quizzes",
          style: TextStyle(
            color: Colours.CardColour,
            fontFamily: FontFamily.rubik,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        foregroundColor: Colours.primaryColor,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colours.CardColour,
          size: 25,
        ),
        backgroundColor: Colours.primaryColor,
      ),
      backgroundColor: Colours.primaryColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Obx(
                    () => creatorQuizController.isLoading.value
                        ? Center(child: CircularProgressIndicator())
      : creatorQuizController.creatorQuizData.value.data == null ||
              creatorQuizController.creatorQuizData.value.data!.isEmpty
          ? Center(
              child: Text(
                'You are not the creator ',
                style: TextStyle(
                  fontFamily: FontFamily.rubik,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colours.textColour,
                ),
              ),
            )
                        : Column(
                            children: List.generate(
                              creatorQuizController.creatorQuizData.value.data?.length ?? 0,
                              (index) {
                                final quiz = creatorQuizController.creatorQuizData.value.data![index];
                                return Column(
                                  children: [
                                    Card(
                                      color: Colours.CardColour,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(22.0),
                                        side: BorderSide(
                                          color: Colours.cardTextColour,
                                          width: 0.1,
                                        ),
                                      ),
                                      child: ListTile(
                                        title: Text(
                                          quiz.quizTitle ?? '',
                                          style: TextStyle(
                                            fontFamily: FontFamily.rubik,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colours.primaryColor,
                                          ),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Subcategory: ${quiz.quizSubCategory ?? ''}',
                                                  style: TextStyle(
                                                    fontFamily: FontFamily.rubik,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colours.textColour,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Text(
                                                  'Questions: ${quiz.numberOfQuestions ?? 0}',
                                                  style: TextStyle(
                                                    fontFamily: FontFamily.rubik,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colours.textColour,
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Text(
                                                  'ID: ${quiz.quizId ?? 0}',
                                                  style: TextStyle(
                                                    fontFamily: FontFamily.rubik,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colours.textColour,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Center(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  
                                                },
                                                child: Text(
                                                  'Schedule',
                                                  style: TextStyle(
                                                    fontFamily: FontFamily.rubik,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colours.primaryColor,
                                                  foregroundColor: Colours.CardColour,
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        leading: Image.asset(
                                          Assets.images.cardimage4.path,
                                        ),
                                        trailing: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 20,
                                          child: IconButton(
                                            icon: Icon(Icons.share),
                                            color: Colours.primaryColor,
                                            onPressed: () {
                                             
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                );
                              },
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
     
      );
    
  }
}
