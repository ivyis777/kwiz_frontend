
import 'package:RiddleQing/core/colors.dart';
import 'package:RiddleQing/core/storage_manager/local_storage_constants.dart';
import 'package:RiddleQing/gen/assets.gen.dart';
import 'package:RiddleQing/gen/fonts.gen.dart';
import 'package:RiddleQing/presentation/screens/Alltimeranking/all_time_ranking.dart';
import 'package:RiddleQing/presentation/screens/controller/completedquiz_controller.dart';
import 'package:RiddleQing/presentation/screens/controller/wallet_balance_controller.dart';
import 'package:RiddleQing/presentation/screens/controller/weeklyleaderboard_controller.dart';
import 'package:RiddleQing/presentation/screens/learderboard/leaderboard_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:toggle_switch/toggle_switch.dart';
import 'package:intl/intl.dart'; 
class RankingPage extends StatefulWidget {
  const RankingPage({Key? key}) : super(key: key);

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  final walletBalanceController = Get.put(WalletBalanceController());
  final completedQuizController = Get.put(CompletedQuizController());
  final weeklyleaderboardController = Get.put(WeeklyleaderboardController());
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

 @override
void initState() {
  super.initState();
  
  _loadRankingData(index: _selectedIndex);
}


Future<void> _loadRankingData({required int index}) async {
  setState(() {
    _selectedIndex = index;
  });

  if (index == 0) {
      final box = GetStorage();
                final userId = box.read(LocalStorageConstants.userId).toString();
    final user_id =  userId; 
    await weeklyleaderboardController.fetchweeklyLeaderBoardAll(user_id: userId);
  } else {
    final box = GetStorage();
    final userId = box.read(LocalStorageConstants.userId).toString();
    if (userId.isNotEmpty) {
      await completedQuizController.fetchCompletedQuizzes(userId);
    }
  }
}

void _onToggle(int? index) async {
  await _loadRankingData(index: index ?? 0);
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          RankingConstants.AppBar,
          style: TextStyle(
            fontFamily: FontFamily.rubik,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        foregroundColor: Colours.CardColour,
        backgroundColor: Colours.primaryColor,
      ),
      backgroundColor: Colours.primaryColor,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                initialLabelIndex: _selectedIndex,
                totalSwitches: 2,
                labels: [
                  RankingConstants.Toggletext1,
                  RankingConstants.Toggletext2
                ],
                customTextStyles: [
                  TextStyle(
                    fontFamily: FontFamily.rubik,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  )
                ],
                 radiusStyle: true,
                onToggle: _onToggle,
              ),
              SizedBox(height: 20),
              _selectedIndex == 0
                  ? Container(
                   child: Obx(() {
  if (weeklyleaderboardController.isLoading.value) {
    return Center(child: CircularProgressIndicator());
  } else if (weeklyleaderboardController.weeklyleaderboardData.value .data== null ||
             
             weeklyleaderboardController.weeklyleaderboardData.value.data!.isEmpty) {
    return Text(
      'You have not completed any of the quizzes',
      style: TextStyle(
        fontFamily: FontFamily.rubik,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colours.black,
      ),
    );
  } else {
    var sortedQuizzes = weeklyleaderboardController.weeklyleaderboardData.value.data!
        .where((quiz) => quiz.quizSubmission != null)
        .toList();
    sortedQuizzes.sort((a, b) => b.quizSubmission!.compareTo(a.quizSubmission!));
    
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: sortedQuizzes.length,
      itemBuilder: (context, index) {
        final quiz = sortedQuizzes[index];
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
                            fontWeight: FontWeight.w500,
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
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: Colours.primaryColor,
                ),
                onTap: () {
                  final quizId = quiz.quizId;
                  Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  AllTimeRankingPage(quizId: quizId!.toString()),
            ));

                },
              ),
            ),
            SizedBox(height: 10),
          ],
        );
      },
    );
  }
}),

                    )
                  : Obx(() {
  if (completedQuizController.isLoading.value) {
    return Center(child: CircularProgressIndicator());
  } else if (completedQuizController.completedQuizData.value.playedQuizzes == null ||
             completedQuizController.completedQuizData.value.playedQuizzes!.isEmpty) {
    return Text(
      'You have not played any recent quizzes',
      style: TextStyle(
        fontFamily: FontFamily.rubik,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colours.black,
      ),
    );
  } else {
    var sortedQuizzes = completedQuizController.completedQuizData.value.playedQuizzes!
        .where((quiz) => quiz.quizSubmission != null)
        .toList();
    sortedQuizzes.sort((a, b) => b.quizSubmission!.compareTo(a.quizSubmission!));

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: sortedQuizzes.length,
      itemBuilder: (context, index) {
        final quiz = sortedQuizzes[index];
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
                            fontWeight: FontWeight.w500,
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
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: Colours.primaryColor,
                ),
                onTap: () {
                     final quizId = quiz.quizId;
                   Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>AllTimeRankingPage(quizId: quizId!.toString()),
            ));
                  
                },
              ),
            ),
            SizedBox(height: 10),
          ],
        );
      },
    );
  }
})

            ],
          ),
        ),
      ),
      
    
    );
  }
}
