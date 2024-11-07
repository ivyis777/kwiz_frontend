import 'package:Kwiz/core/colors.dart';
import 'package:Kwiz/core/storage_manager/local_storage_constants.dart';
import 'package:Kwiz/gen/assets.gen.dart';
import 'package:Kwiz/gen/fonts.gen.dart';
import 'package:Kwiz/presentation/screens/FreeSubscription/free%20_subscription.dart';
import 'package:Kwiz/presentation/screens/controller/QuizList_controller.dart';
import 'package:Kwiz/presentation/screens/controller/quiz_subscription_controller.dart';
import 'package:Kwiz/presentation/screens/controller/wallet_balance_controller.dart';
import 'package:Kwiz/presentation/screens/payment/payment_page.dart';
import 'package:Kwiz/presentation/screens/quiz_details/quiz_details.dart';
import 'package:Kwiz/presentation/screens/quiz_details/quizdetails_contants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';





class QuizListPage extends StatefulWidget {
  final int? quizSubCategoryId;
  QuizListPage({required this.quizSubCategoryId});
  
  @override
  State<QuizListPage> createState() => _QuizListPageState();
}

class _QuizListPageState extends State<QuizListPage> {
  int _selectedIndex = 0;

  final quizlistController = Get.put<QuizlistController>(QuizlistController());
  final walletBalanceController = Get.put<WalletBalanceController>(WalletBalanceController());

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
 
Future<void> _refreshQuizzes() async {
  await quizlistController.fetchCategories(widget.quizSubCategoryId ?? 0); }

  @override
  Widget build(BuildContext context) {
    final quizlistController = Get.put<QuizlistController>(QuizlistController());

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (widget.quizSubCategoryId != null) {
        quizlistController.fetchCategories(widget.quizSubCategoryId!);
      }
    });
    print(widget.quizSubCategoryId);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quizzes",
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
      body: RefreshIndicator(
        onRefresh: _refreshQuizzes, 
        child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
  children: [
    Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              SizedBox(height: 20,),
              Obx(
    () => quizlistController.isLoading.value
                                ? CircularProgressIndicator()
                                : quizlistController.QuiztList.isEmpty
                                    ? Column(
                                        children: [
                                             Image.asset(Assets.images.workonit.path),
                                            
                                          
                                        ],
                                      )
      
      : Column(
          children: List.generate(
            quizlistController.QuiztList.length,
            (index) {
              index++;
              return Column(
                children: [
                  
                 Card(
          color: Colours.CardColour,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
                    child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [ SizedBox(width: 10),
    Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical:5),
      decoration: BoxDecoration(
        // color: Colours.wronganswer, 

        borderRadius: BorderRadius.circular(12),
        
      ),
              
                   child:   Text(
                       quizlistController.QuiztList[index-1].isLive ?? false ? 'Live Quiz' : 'Scheduled Quiz',
                        style: TextStyle(
                          color: Colours.wronganswer,
                          fontFamily: FontFamily.rubik,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      )),
                    
                   
                     SizedBox(width: 10),
    Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
       
        borderRadius: BorderRadius.circular(12),
      ),
                  child:     Text(
                quizlistController.QuiztList[index-1].isFree ?? false ? 'Free' : '₹${quizlistController.QuiztList[index-1].amount}',
                 style: TextStyle(
                 color: Colours.correctanswer,
                 fontFamily: FontFamily.rubik,
                 fontSize: 15,
                 fontWeight: FontWeight.w800,
                   ),
                    ),


                   
                 ) ]
                ),
                SizedBox(height: 10),
                Text(
                 '${quizlistController.QuiztList[index-1].quizTitle}',
                  style: TextStyle(
                    color: Colours.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.book_outlined, color: Colours.textColour),
                    SizedBox(width: 5),
                    Text(
                     '${quizlistController.QuiztList[index-1].numberOfQuestions} questions',
                      style: TextStyle(
                        color: Colours.textColour,
                        fontFamily: FontFamily.rubik,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 1,
                      height: 20,
                      color: Colours.textColour,
                    ),
                    SizedBox(width: 10),
                     Text(
                   '${quizlistController.QuiztList[index-1].quizDuration} mins',
                      style: TextStyle(
                        color: Colours.textColour,
                        fontFamily: FontFamily.rubik,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 1,
                      height: 20,
                      color: Colours.textColour,
                    ),
                    SizedBox(width: 10),
                    Text(
                       '${quizlistController.QuiztList[index-1].noOfMarks} marks',
                      style: TextStyle(
                        color: Colours.textColour,
                        fontFamily: FontFamily.rubik,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
               Row(
  children: [
    if (quizlistController.QuiztList[index-1].isScheduled ?? false)
      Icon(Icons.timer, color: Colours.textColour),
    if (quizlistController.QuiztList[index-1].isScheduled ?? false)
      SizedBox(width: 5), 
    if (quizlistController.QuiztList[index-1].isScheduled ?? false)
      Obx(() {
        
        final quizSchedule =
           quizlistController.QuiztList[index-1].quizSchedule;
        final formattedDateTime = quizSchedule != null
            ? DateFormat('dd/MM/yyyy hh:mm a').format(quizSchedule)
            : '';
        return Text(
          formattedDateTime,
          style: TextStyle(
            fontFamily: FontFamily.rubik,
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: Colours.textColour,
          ),
        );
      }),
  ],
),

                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(Assets.images.boyicon.path),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                               '${quizlistController.QuiztList[index-1].createdBy}',
                            style: TextStyle(
                              fontFamily: FontFamily.rubik,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colours.darkblueColor,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            QuizDetailsConstants.textcard8,
                            style: TextStyle(
                              fontFamily: FontFamily.rubik,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colours.textColour,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 7),
                   ElevatedButton(
  onPressed: () async {
    final quizSubscriptionController = Get.find<QuizSubscriptionController>();
    final box = GetStorage();
    final userId = box.read(LocalStorageConstants.userId).toString();
    final quiz = quizlistController.QuiztList[index-1];
    final quizId = quiz.quizId ?? "";
    
    

    try {
      final response = await quizSubscriptionController.getQuizSubscriptionUser(
        user_id: userId,
        quiz_id: quizId,
      

      );

      final statusCode = int.tryParse(response.status ?? "0") ?? 0;
      print("Response from backend: ${response.message}, Status: $statusCode");

      if (statusCode == 200) {
        // Check if the quiz is scheduled
        if (quiz.isScheduled == true) {
          final quizSchedule = quiz.quizSchedule;
          if (quizSchedule != null) {
            final currentTime = DateTime.now();
            final scheduledTime = quizSchedule;

            // Navigate to QuizDetails if current time is after or at the same time as scheduled time
            if (currentTime.isAfter(scheduledTime) || currentTime.isAtSameMomentAs(scheduledTime)) {
              print("Navigating to QuizDetails page...");
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QuizDetails(
                quizId: quizId,
               quizDuration: quiz.quizDuration,
            quizDescription: quiz.quizDescription ?? "",
            createdBy: quiz.createdBy ?? "",
            noOfMarks: quiz.noOfMarks ?? 0,
            numberOfQuestions: quiz.numberOfQuestions ?? 0,
              ))
            );
              
            } else {
              // Show dialog for scheduled quiz
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colours.CardColour,
                    title: Center(
                      child: Text(
                        "Quiz Notification",
                        style: TextStyle(
                          fontFamily: FontFamily.rubik,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colours.yellowcolor,
                        ),
                      ),
                    ),
                    content: Container(
                      margin: EdgeInsets.fromLTRB(15, 10, 10, 15),
                      child: Text(
                        "You have already subscribed, quiz will start at ${DateFormat('dd/MM/yyyy hh:mm a').format(quizSchedule)}. Stay tuned!",
                        style: TextStyle(
                          fontFamily: FontFamily.rubik,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colours.primaryColor,
                        ),
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "OK",
                          style: TextStyle(
                            fontFamily: FontFamily.rubik,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colours.yellowcolor,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          } else {
            print("Quiz schedule is null.");
          }
        } else {
         
          print("Navigating to QuizDetails page...");
           Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QuizDetails(
            quizId: quizId,
           quizDuration: quiz.quizDuration,
            quizDescription: quiz.quizDescription ?? "",
            createdBy: quiz.createdBy ?? "",
            noOfMarks: quiz.noOfMarks ?? 0,
            numberOfQuestions: quiz.numberOfQuestions ?? 0,
          )),
            );
        
        }
      } else if (statusCode == 400) {
    
        if (quiz.isFree == true) {
       
           DateTime quizSchedule = quiz.quizSchedule ?? DateTime.now();
          print("Navigating to QuizDetails page...");
           Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  FreeSubscriptionPage(
              quizId: quizId,
            createdBy: quiz.createdBy ?? "",
            quizTitle: quiz.quizTitle ?? '',
            quizCategory: quiz.quizCategory ?? '',
            quizSchedule: quizSchedule,
            quizSubCategory: quiz.quizSubCategory ?? '',
            isScheduled: quiz.isScheduled ?? false,

           
          )),
            );
        

           
          
        } else {
          
          print("Navigating to PaymentPage...");
          DateTime quizSchedule = quiz.quizSchedule ?? DateTime.now();
           Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  PaymentPage(
            email: "",
            keyID: "",
            keySecret: "",
            quizTitle: quiz.quizTitle ?? '',
            quizCategory: quiz.quizCategory ?? '',
            quizSchedule: quizSchedule,
            quizSubCategory: quiz.quizSubCategory ?? '',
            amount: quiz.amount ?? 0.0,
            createdBy: quiz.createdBy ?? "",
            quizId: quizId,
            isScheduled: quiz.isScheduled ?? false,
          )), // Push HomeSubPage
            );
         
        }
      } else {
        print("Unhandled status code: $statusCode");
      }
    } catch (e) {
      print("Error fetching subscription status: $e");
    }
  },
  child: Text(
    'Start Now',
    style: TextStyle(
      color: Colours.CardColour,
      fontFamily: FontFamily.rubik,
      fontSize: 15,
      fontWeight: FontWeight.w500,
    ),
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colours.primaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  ),
),

                  ],
                ),
              ],
            ),
                  ),
              )],
              );
            },
          ),
        ),
            )
],
          ),
        ),
      ),
    ),
  ],
),
          ],
        ),
      )),
    
    );
  }
}