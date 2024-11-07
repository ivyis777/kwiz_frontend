import 'package:Kwiz/core/colors.dart';
import 'package:Kwiz/core/storage_manager/local_storage_constants.dart';
import 'package:Kwiz/gen/assets.gen.dart';
import 'package:Kwiz/gen/fonts.gen.dart';
import 'package:Kwiz/presentation/screens/controller/completedquiz_controller.dart';
import 'package:Kwiz/presentation/screens/controller/subscribed_quizes.controller.dart';
import 'package:Kwiz/presentation/screens/controller/unsubscribe_controller.dart';
import 'package:Kwiz/presentation/screens/controller/wallet_balance_controller.dart';
import 'package:Kwiz/presentation/screens/live_quizes/live_quizes.dart';
import 'package:Kwiz/presentation/screens/subscription/subscription_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import 'package:toggle_switch/toggle_switch.dart';

class SubscriptionPage extends StatefulWidget {
  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  int _selectedIndex = 0;
  int _selectedToggleIndex = 0;
  late WalletBalanceController walletBalanceController;
  final subscribedQuizController = Get.put(SubscribedQuizController());
  final completedQuizController = Get.put(CompletedQuizController());
  bool isProcessing = false; 
  @override
  void initState() {
    super.initState();
    walletBalanceController = Get.put(WalletBalanceController());
    final box = GetStorage();
    final userId = box.read(LocalStorageConstants.userId).toString();
    subscribedQuizController.fetchRecentQuiz(userId);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
void _onToggleSwitchTapped(int? index) async {
  setState(() {
    _selectedToggleIndex = index ?? 0; 
  });

  if (_selectedToggleIndex == 1) {
    final box = GetStorage();
    final userId = box.read(LocalStorageConstants.userId).toString();
    await completedQuizController.fetchCompletedQuizzes(userId);
  }
}

  Future<void> _refreshQuizzes() async {
     final box = GetStorage();
    final userId = box.read(LocalStorageConstants.userId).toString();
      await subscribedQuizController. fetchRecentQuiz(userId); 
     await completedQuizController. fetchCompletedQuizzes(userId); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          subscriptionConstaints.appBar,
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ToggleSwitch(
              minWidth: 327.0,
              minHeight: 48,
              cornerRadius: 20.0,
              activeBgColors: [
                [Colours.leaderBoardCardColor],
                [Colours.leaderBoardCardColor]
              ],
              activeFgColor: Colours.CardColour,
              inactiveBgColor: Colours.black,
              inactiveFgColor: Colours.leaderboardtext,
              initialLabelIndex: _selectedToggleIndex,
              totalSwitches: 2,
              labels: ['Subscribed', 'Completed Quizes'],
              customTextStyles: [
                TextStyle(
                  fontFamily: FontFamily.rubik,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                )
              ],
              radiusStyle: true,
              onToggle: _onToggleSwitchTapped,
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32.0),
                        topRight: Radius.circular(32.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                 child: Container(
  margin: EdgeInsets.only(left: 24, right: 24),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 20),
      Obx(
        () => _selectedToggleIndex == 0
            ? subscribedQuizController.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: _refreshQuizzes,
                    child: subscribedQuizController.subscribedQuizData.value?.subscribedQuizzes == null ||
                            subscribedQuizController.subscribedQuizData.value!.subscribedQuizzes!.isEmpty
                        ? Center(
                            child: Text(
                              'No subscribed quizzes',
                              style: TextStyle(
                                fontFamily: FontFamily.rubik,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colours.textColour,
                              ),
                            ),
                          )
                        : Column(
                            children: subscribedQuizController.subscribedQuizData.value?.subscribedQuizzes?.map((quiz) {
                              if (quiz == null) return Container();
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
                                                quiz.quizSubCategory ?? '',
                                                style: TextStyle(
                                                  fontFamily: FontFamily.rubik,
                                                  fontSize: 18,
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
                                                quiz.quizSchedule != null
                                                    ? DateFormat('dd/MM/yyyy hh:mm a').format(quiz.quizSchedule!)
                                                    : '',
                                                style: TextStyle(
                                                  fontFamily: FontFamily.rubik,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colours.textColour,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Center(
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 20,
                                              child: IconButton(
                                                icon: Icon(Icons.share),
                                                color: Colours.primaryColor,
                                                onPressed: () {
                                                  // Add your sharing logic here
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      leading: Image.asset(
                                        Assets.images.cardimage4.path,
                                      ),
                                      trailing: Image.asset(
                                        Assets.images.vector.path,
                                      ),
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return CupertinoAlertDialog(
                                              content: Text(
                                                subscriptionConstaints.popuptext1,
                                                style: TextStyle(
                                                  fontFamily: FontFamily.rubik,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colours.black,
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Get.to(() => LiveQuizPage());
                                                  },
                                                  child: Text(
                                                    subscriptionConstaints.popuptext2,
                                                    style: TextStyle(
                                                      fontFamily: FontFamily.rubik,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w400,
                                                      color: Colours.black,
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    showDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      builder: (BuildContext context) {
                                                        return CupertinoAlertDialog(
                                                          content: Text(
                                                            "Are you sure?",
                                                            style: TextStyle(
                                                              fontFamily: FontFamily.rubik,
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w400,
                                                              color: Colours.black,
                                                            ),
                                                          ),
                actions: <Widget>[
 TextButton(
  onPressed: isProcessing
      ? null // Disable the button if already processing
      : () async {
          setState(() {
            isProcessing = true; // Start processing state
          });

          final box = GetStorage();
          final userId = box.read(LocalStorageConstants.userId).toString();
          UnsubscribeController controller = UnsubscribeController(
            user_id: userId,
            quiz_id: quiz.quizId!, // Ensure `quiz` is defined
          );

          try {
            await controller.unsubscribe();
            if (mounted) {
              Navigator.of(context).pop(); // Close the dialog
              await _refreshQuizzes(); // Refresh the quizzes list
            }
          } catch (e) {
            print('Error unsubscribing: $e'); // Handle any errors
          } finally {
            if (mounted) {
              setState(() {
                isProcessing = false; // Reset the processing state
              });
            }
          }
        },
  child: isProcessing
      ? SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation<Color>(Colours.primaryColor), 
          ),
        ) // Show a loader while processing
      : Text("Yes"),
),

TextButton(
  onPressed: isProcessing
      ? null // Disable the button if already processing
      : () {
          if (mounted) {
            Navigator.of(context).pop(); // Close the dialog
          }
        },
  child: Text("No"),
),

],



                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Text(
                                                    subscriptionConstaints.popuptext3,
                                                    style: TextStyle(
                                                      fontFamily: FontFamily.rubik,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w400,
                                                      color: Colours.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              );
                            }).toList() ?? [],
                          ),
                
                )
     

                                : _selectedToggleIndex == 1
                                    ? completedQuizController.isLoading.value
                                        ? Center(child: CircularProgressIndicator())
                                         : RefreshIndicator(
                      onRefresh: _refreshQuizzes,
                      child:  completedQuizController.completedQuizData.value.playedQuizzes!.isEmpty
                                              ? Text(
                                                     'No completed quizzes',
                                             
                                                style: TextStyle(
                                                  fontFamily: FontFamily.rubik,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colours.textColour,
                                                ),
                                              )
                                            : Column(
                                                children: completedQuizController.completedQuizData.value!.playedQuizzes?.map((quiz) {
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
                                                            quiz.quizName ?? '',
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
                                                                    'Questions: ${quiz.numberOfQuestions.toString()}',
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
                                                                    'Correct: ${quiz.correctAnswers.toString()}',
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
                                                                    'Incorrect: ${quiz.incorrectAnswers.toString()}',
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
                                                                    'Earned: ₹${quiz.earnedAmount.toString()}',
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
                                                                    'Status: ${quiz.playStatus}',
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
                                                                    quiz.quizSubmission != null
                                                                        ? DateFormat('dd/MM/yyyy hh:mm a').format(quiz.quizSubmission!)
                                                                        : '',
                                                                    style: TextStyle(
                                                                      fontFamily: FontFamily.rubik,
                                                                      fontSize: 16,
                                                                      fontWeight: FontWeight.w400,
                                                                      color: Colours.textColour,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          leading: Image.asset(
                                                            Assets.images.cardimage4.path,
                                                          ),
                                                        
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                    ],
                                                  );
                                                }).toList() ?? [],
                                              ))
                                    : Container(), 
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      
    );
  }
}
