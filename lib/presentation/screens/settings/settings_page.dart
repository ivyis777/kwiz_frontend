
import 'package:RiddleQing/core/colors.dart';
import 'package:RiddleQing/core/storage_manager/local_storage_constants.dart';
import 'package:RiddleQing/gen/assets.gen.dart';
import 'package:RiddleQing/gen/fonts.gen.dart';
import 'package:RiddleQing/presentation/screens/CreatorQuizList/creator_quiz.dart';
import 'package:RiddleQing/presentation/screens/UnsubscriptionQuizzesList/unsubscriptionquizzes_list.dart';
import 'package:RiddleQing/presentation/screens/controller/creator_quiz_controller.dart';
import 'package:RiddleQing/presentation/screens/controller/wallet_balance_controller.dart';
import 'package:RiddleQing/presentation/screens/learderboard/leaderboard_screen.dart';
import 'package:RiddleQing/presentation/screens/onboarding/onboarding_page.dart';
import 'package:RiddleQing/presentation/screens/profile/profile_page.dart';
import 'package:RiddleQing/presentation/screens/settings/settings_constrants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:url_launcher/url_launcher.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);
  

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
      late String userId = ''; 
  bool _notificationsEnabled = true;
Future<void> _logout() async {
  try {
    // Sign out from Firebase
    await FirebaseAuth.instance.signOut();

    // Clear the token from local storage
    final box = GetStorage();
    await box.remove(LocalStorageConstants.token); // Remove the token
    await box.remove(LocalStorageConstants.userId); // Optionally remove other user data

    // Navigate to the OnBoardingPage
    Get.offAll(() => OnBoardingPage());
  } catch (e) {
    print("Error during logout: $e");
  }
}


final walletBalanceController = Get.put<WalletBalanceController>(WalletBalanceController());
 int _selectedIndex = 0;
  
   void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          SettingsConstrants.appbar,
          style: TextStyle(
            color: Colours.CardColour,
            fontFamily: FontFamily.rubik,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        foregroundColor: Colours.CardColour,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colours.CardColour,
          size: 25,
        ),
        backgroundColor: Colours.primaryColor,
      ),
      backgroundColor: Colours.CardColour,
      body: SingleChildScrollView(
        child:
      Container(
        margin: EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    SettingsConstrants.text1,
                    style: TextStyle(
                      fontFamily: FontFamily.rubik,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colours.textColour,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 20),
              child: Card(
                color: Colours.secondaryColour,
                elevation: 1,
                margin: EdgeInsets.symmetric(vertical: 10),

                child: ListTile(
                  leading: Image.asset(Assets.images.profileicon.path),
                   
                  title: Text(
                    SettingsConstrants.text2,
                    style: TextStyle(
                        fontFamily: FontFamily.rubik,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                        
                  ),
                  subtitle: Text(
                    SettingsConstrants.text3,
                    style: TextStyle(
                      fontFamily: FontFamily.rubik,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colours.textColour,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_rounded,
                    color: Colours.primaryColor,
                    size: 20,
                  ),
                  onTap: ()async {
                final box = GetStorage();
                final userId = box.read(LocalStorageConstants.userId).toString(); 
                  print('User ID: $userId');
                
                { Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
    
       ProfilePage()),
       
    );}}
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 20),
              child: Card(
                color: Colours.secondaryColour,
                elevation: 1,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  leading:  Image.asset(Assets.images.emailicon.path),
                  title: Text(
                    SettingsConstrants.text4,
                    style: TextStyle(
                        fontFamily: FontFamily.rubik,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                 
                  trailing: Icon(
                    Icons.arrow_forward,
                    color: Colours.primaryColor,
                    size: 20,
                  ),
                         onTap: () { Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RankingPage()),
    );;},
                ),
              ),
            ),
    
            
             Container(
              margin: EdgeInsets.only(right: 20),
              child: Card(
                color: Colours.secondaryColour,
                elevation: 1,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  leading:  Image.asset(Assets.images.lockicon.path),
                  title: Text(
                    SettingsConstrants.Quizes,
                    style: TextStyle(
                        fontFamily: FontFamily.rubik,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  
                  trailing: Icon(Icons.arrow_forward,
                      color: Colours.primaryColor, size: 20),
              onTap: () async{
     final creatorQuizController = Get.put<CreatorQuizController>(CreatorQuizController());
    final box = GetStorage();
    final userId = box.read(LocalStorageConstants.userId).toString();
    await creatorQuizController.fetchRecentQuiz(userId); 
 Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QuizCreatorPage()),
            );}
                ),
              ),
            ),
             Container(
              margin: EdgeInsets.only(right: 20),
              child: Card(
                color: Colours.secondaryColour,
                elevation: 1,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  leading:  Image.asset(Assets.images.emailicon.path),
                  title: Text(
                    SettingsConstrants.text14,
                    style: TextStyle(
                        fontFamily: FontFamily.rubik,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  
                  trailing: Icon(
                    Icons.arrow_forward,
                    color: Colours.primaryColor,
                    size: 20,
                  ),
                         onTap: () { Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UnsubscriptionQuizzesListPage()),
    );;},
                ),
              ),
            ),
    
            SizedBox(
              height: 10,
            ),
            
            Text(
              SettingsConstrants.text8,
              style: TextStyle(
                fontFamily: FontFamily.rubik,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colours.textColour,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            
            Container(
              margin: EdgeInsets.only(right: 26),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    SettingsConstrants.text10,
                    style: TextStyle(
                      fontFamily: FontFamily.rubik,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colours.primaryColor,
                    ),
                  ),
                  Switch(
                    value: _notificationsEnabled,
                    
                    onChanged: (value) {
                      setState(() {
                        _notificationsEnabled = value;
                      });
                    },
                    activeColor: Colours.CardColour,
                    inactiveThumbColor: Colours.CardColour,
                    activeTrackColor: Colours.primaryColor,
                    inactiveTrackColor: Colours.primaryColor,
                  ),
                ],
              ),
            ),
          
             Container(
              margin: EdgeInsets.only(right: 20),
              child: Card(
                color: Colours.secondaryColour,
                elevation: 1,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  
                 leading:  Image.asset(Assets.images.questionicon.path),
                  title: Text(
                    SettingsConstrants.text11,
                    style: TextStyle(
                        fontFamily: FontFamily.rubik,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(SettingsConstrants.text12,
                      style: TextStyle(
                        fontFamily: FontFamily.rubik,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colours.textColour,
                      )),
                  trailing: Icon(Icons.arrow_forward,
                      color: Colours.primaryColor, size: 20),
                  onTap: () {  launchUrl(Uri.parse("https://kwiizz.com/faqs.html"));;},
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: EdgeInsets.only(left: 140),
                child: TextButton(
                  onPressed: () async {
                    await _logout();
                         
                  },
                  child: Text(
                    SettingsConstrants.text15,
                    style: TextStyle(
                      color: Colours.redcolor,
                      fontSize: 16,
                      fontFamily: FontFamily.rubik,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),

    );

  }
}
