import 'package:Kwiz/core/colors.dart';
import 'package:Kwiz/gen/assets.gen.dart';
import 'package:Kwiz/gen/fonts.gen.dart';
import 'package:Kwiz/presentation/screens/controller/leaderboardall_controller.dart';
import 'package:Kwiz/presentation/screens/controller/wallet_balance_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class AllTimeRankingPage extends StatefulWidget {
  final String quizId;

  const AllTimeRankingPage({Key? key, required this.quizId}) : super(key: key);

  @override
  State<AllTimeRankingPage> createState() => _AllTimeRankingPageState();
}

class _AllTimeRankingPageState extends State<AllTimeRankingPage> {
  final walletBalanceController = Get.put<WalletBalanceController>(WalletBalanceController());
  final leaderboardallController = Get.put<LeaderboardallController>(LeaderboardallController());
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchLeaderboardData();
  }

  String formatTime(double timeInSeconds) {
    final milliseconds = (timeInSeconds * 1000).toInt();
    final duration = Duration(milliseconds: milliseconds);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    String twoDigitMilliseconds = (duration.inMilliseconds % 1000).toString().padLeft(3, "0");
    return "$twoDigitMinutes:$twoDigitSeconds:$twoDigitMilliseconds";
  }

  void _fetchLeaderboardData() {
    leaderboardallController.fetchLeaderBoardAll(quizId: widget.quizId);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
List<Color> crownColors = [
  Colours.yellowcolor,   
  Colours.textColour,    
  Colours.redcolor
];
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colours.primaryColor,
      appBar: AppBar(
        title: Text(
          "Ranking",
          style: TextStyle(
            color: Colours.CardColour,
            fontFamily: FontFamily.rubik,
            fontSize: screenWidth * 0.06,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colours.primaryColor,
        foregroundColor: Colours.CardColour,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colours.CardColour,
          size: screenWidth * 0.07,
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32.0),
                  topRight: Radius.circular(32.0),
                ),
              ),
              child: Container(
                margin: EdgeInsets.all(18),
                child: Obx(() {
                  if (leaderboardallController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    final leaderboardData = leaderboardallController.leaderboardData.value.data ?? [];
                    leaderboardData.sort((a, b) {
                      int compareMarks = (b.correctAnswers ?? 0).compareTo(a.correctAnswers ?? 0);
                      if (compareMarks != 0) return compareMarks;

                      double timeTakenA = _parseTimeTaken(a.timeTaken);
                      double timeTakenB = _parseTimeTaken(b.timeTaken);
                      return timeTakenA.compareTo(timeTakenB);
                    });

                    return ListView.builder(
                      itemCount: leaderboardData.length,
                      itemBuilder: (context, index) {
                        final data = leaderboardData[index];
                        double timeTaken = _parseTimeTaken(data?.timeTaken);


                        return Card(
                          color: Colours.secondaryColour,
                          child: ListTile(
                            leading: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colours.CardColour,
                                  radius: screenWidth * 0.03,
                                  child: Text(
                                    (index + 1).toString(),
                                    style: TextStyle(
                                      fontFamily: FontFamily.rubik,
                                      color: Colours.cardTextColour,
                                      fontWeight: FontWeight.w500,
                                      fontSize: screenWidth * 0.04,
                                    ),
                                  ),
                                ),
                               SizedBox(width: 10),
                                ClipOval(
                                  child: Image.asset(
                                    Assets.images.profile.path,
                                    fit: BoxFit.cover,
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                              ],
                            ),
                            title: Text(
                              data?.username ?? "",
                              style: TextStyle(
                                fontFamily: FontFamily.rubik,
                                fontSize: screenWidth * 0.045,
                                color: Colours.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${data?.correctAnswers ?? 0} Points",
                                  style: TextStyle(
                                    fontFamily: FontFamily.rubik,
                                    fontSize: screenWidth * 0.04,
                                    color: Colours.textColour,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 20),
                                Text(
                                  "${formatTime(timeTaken)}",
                                  style: TextStyle(
                                    fontFamily: FontFamily.rubik,
                                    fontSize: screenWidth * 0.04,
                                    color: Colours.textColour,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            trailing: index < 3
            ? Icon(
                FontAwesomeIcons.crown,
                color: crownColors[index],
                size: screenWidth * 0.07,
              )
            : null,
      ),
    );
  },
                    
                    );
                  }
                }),
              ),
            ),
          );
        },
      ),
   
      
    );
  }
double _parseTimeTaken(String? timeTaken) {
  if (timeTaken == null || timeTaken.isEmpty) {
    return 0.0;
  }

  try {
 
    final parts = timeTaken.split(":");
    int minutes = 0;
    int seconds = 0;
    int milliseconds = 0;

    if (parts.length == 3) {
      minutes = int.parse(parts[0]);
      final secParts = parts[1].split(".");
      seconds = int.parse(secParts[0]);
      milliseconds = int.parse(secParts.length > 1 ? secParts[1] : "0");
    } else if (parts.length == 2) {
      final secParts = parts[1].split(".");
      seconds = int.parse(parts[0]);
      milliseconds = int.parse(secParts.length > 1 ? secParts[1] : "0");
    } else if (parts.length == 1) {
      final secParts = parts[0].split(".");
      seconds = int.parse(secParts[0]);
      milliseconds = int.parse(secParts.length > 1 ? secParts[1] : "0");
    } else {
      throw FormatException("Unexpected time format");
    }

    return minutes * 60 + seconds + milliseconds / 1000.0;
  } catch (e) {
    print("Error parsing time: $e");
    return 0.0;
  }
}
}



