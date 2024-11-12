
import 'package:RiddleQing/core/colors.dart';
import 'package:RiddleQing/core/storage_manager/local_storage_constants.dart';
import 'package:RiddleQing/gen/assets.gen.dart';
import 'package:RiddleQing/gen/fonts.gen.dart';
import 'package:RiddleQing/presentation/screens/FreeSubscription/free%20_subscription.dart';
import 'package:RiddleQing/presentation/screens/controller/add_categegory_controller.dart';
import 'package:RiddleQing/presentation/screens/controller/quiz_subscription_controller.dart';
import 'package:RiddleQing/presentation/screens/controller/search_controller.dart'as MySearchController;
import 'package:RiddleQing/presentation/screens/controller/wallet_balance_controller.dart';
import 'package:RiddleQing/presentation/screens/payment/payment_page.dart';
import 'package:RiddleQing/presentation/screens/quiz_details/quiz_details.dart';
import 'package:RiddleQing/presentation/screens/quiz_details/quizdetails_contants.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';




class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}
class _SearchScreenState extends State<SearchScreen> {
  final MySearchController.SearchController controller =
      Get.put(MySearchController.SearchController());
  final walletBalanceController = Get.put<WalletBalanceController>(WalletBalanceController());
  final quizGetController = Get.put<QuizGetController>(QuizGetController());
  @override
  Widget build(BuildContext context) {
     controller.resetSearch();
    quizGetController.resetSearch();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Discover',
          style: TextStyle(
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
   TextField(
  decoration: InputDecoration(
    labelText: 'Search',
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colours.primaryColor, 
        width: 2.0,
      ),
      borderRadius: BorderRadius.circular(8.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colours.primaryColor.withOpacity(0.5), 
        width: 1.5,
      ),
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
  onChanged: (value) {
    quizGetController.setSearchQuery(value);
    controller.performSearch(value);
  },
),

SizedBox(height: 16),
Obx(() {
  print('Categories: ${controller.categories}');
  return DropdownButton<String>(
    focusColor: Colours.primaryColor,
    isExpanded: true,
    hint: Text(
      'Select Category',
      style: TextStyle(
        color: Colours.textColour,
        fontFamily: FontFamily.rubik,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
    value: controller.selectedCategory.value.isEmpty
        ? null
        : controller.selectedCategory.value,
    items: controller.categories.map((String category) {
      return DropdownMenuItem<String>(
        value: category,
        child: Text(category),
      );
    }).toList(),
    onChanged: (value) {
      if (value != null) {
        controller.selectedCategory.value = value;
        controller.fetchSubCategories(value);
        quizGetController.setSelectedCategory(value);
        controller.performSearch(controller.searchQuery.value);
      }
    },
  );
}),
SizedBox(height: 16),
Obx(() {
  print('SubCategories: ${controller.subCategories}');
  return DropdownButton<String>(
    isExpanded: true,
    hint: Text(
      'Select SubCategory',
      style: TextStyle(
        color: Colours.textColour,
        fontFamily: FontFamily.rubik,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
    value: controller.selectedSubCategory.value.isEmpty
        ? null
        : controller.selectedSubCategory.value,
    items: controller.subCategories.map((String subCategory) {
      return DropdownMenuItem<String>(
        value: subCategory,
        child: Text(subCategory),
      );
    }).toList(),
    onChanged: (value) {
      if (value != null) {
        controller.selectedSubCategory.value = value;
        quizGetController.setSelectedSubCategory(value);
        controller.performSearch(controller.searchQuery.value);
      }
    },
  );
}),

            SizedBox(height: 16),
            Expanded(
              child: Obx(() => quizGetController.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : quizGetController.filteredQuizList.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                             
                              Text('No quizzes found',style: TextStyle(
            fontFamily: FontFamily.rubik,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: quizGetController.filteredQuizList.length,
                          itemBuilder: (context, index) {
                            final quiz =
                                quizGetController.filteredQuizList[index];
                            return Card(
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
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            quiz.isLive ?? false
                                                ? 'Live Quiz'
                                                : 'Schedule Quiz',
                                            style: TextStyle(
                                              color: Colours.wronganswer,
                                              fontFamily: FontFamily.rubik,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            quiz.isFree ?? false
                                                ? 'Free'
                                                : '₹${quiz.amount}',
                                            style: TextStyle(
                                              color: Colours.correctanswer,
                                              fontFamily: FontFamily.rubik,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      '${quiz.quizTitle}',
                                      style: TextStyle(
                                        color: Colours.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Icon(Icons.book_outlined,
                                            color: Colours.textColour),
                                        SizedBox(width: 5),
                                        Text(
                                          '${quiz.numberOfQuestions} questions',
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
                                          '${quiz.quizDuration} mins',
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
                                          '${quiz.noOfMarks} marks',
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
    if (quiz.isScheduled ?? false)
      Icon(Icons.timer, color: Colours.textColour),
    if (quiz.isScheduled ?? false)
      SizedBox(width: 5),
    if (quiz.isScheduled ?? false)
      
      Text(
        quiz.quizSchedule != null
            ? DateFormat('dd/MM/yyyy hh:mm a').format(quiz.quizSchedule!)
            : 'No schedule',
        style: TextStyle(
          fontFamily: FontFamily.rubik,
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: Colours.textColour,
        ),
      ),
  ],
),
                                    SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                            Assets.images.boyicon.path),
                                        SizedBox(width: 15),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${quiz.createdBy}',
                                                style: TextStyle(
                                                  fontFamily:
                                                      FontFamily.rubik,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colours.darkblueColor,
                                                ),
                                              ),
                                              SizedBox(height: 2),
                                              Text(
                                                QuizDetailsConstants.textcard8,
                                                style: TextStyle(
                                                  fontFamily:
                                                      FontFamily.rubik,
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
                                            final quizSubscriptionController =
                                                Get.find<QuizSubscriptionController>();
                                            final box = GetStorage();
                                            final userId = box.read(
                                                    LocalStorageConstants.userId)
                                                .toString();
                                            final quizId = quiz.quizId ?? "";
                                             double amount = quiz.amount ?? 0.0;
    double amountDeducted = quiz.amount ?? 0.0;
    bool couponApplied = false;
    String couponCode = "";
                                            try {
                                              final response =
                                                  await quizSubscriptionController
                                                      .getQuizSubscriptionUser(
                                                user_id: userId,
                                                quiz_id: quizId, 
                                              );
                                              final statusCode =
                                                  int.tryParse(response.status ??
                                                          "0") ??
                                                      0;
                                              print(
                                                  "Response from backend: ${response.message}, Status: $statusCode");
                                              if (statusCode == 200) {
                                                if (quiz.isScheduled ==
                                                    true) {
                                                  final quizSchedule =
                                                      quiz.quizSchedule;
                                                  if (quizSchedule != null) {
                                                    final currentTime =
                                                        DateTime.now();
                                                    final scheduledTime =
                                                        quizSchedule;

                                                    if (currentTime
                                                            .isAfter(
                                                                scheduledTime) ||
                                                        currentTime
                                                            .isAtSameMomentAs(
                                                                scheduledTime)) {
                                                      print(
                                                          "Navigating to QuizDetails page...");
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
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            backgroundColor:
                                                                Colours
                                                                    .CardColour,
                                                            title: Center(
                                                              child: Text(
                                                                "Quiz Notification",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      FontFamily
                                                                          .rubik,
                                                                  fontSize: 22,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colours
                                                                      .yellowcolor,
                                                                ),
                                                              ),
                                                            ),
                                                            content:
                                                                Container(
                                                              margin: EdgeInsets
                                                                  .fromLTRB(
                                                                      15,
                                                                      10,
                                                                      10,
                                                                      15),
                                                              child: Text(
                                                                "You have already subscribed, quiz will start at ${DateFormat('dd/MM/yyyy hh:mm a').format(quizSchedule)}. Stay tuned!",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      FontFamily
                                                                          .rubik,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colours
                                                                      .primaryColor,
                                                                ),
                                                              ),
                                                            ),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child: Text(
                                                                  "OK",
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        FontFamily
                                                                            .rubik,
                                                                    fontSize:
                                                                        22,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colours
                                                                        .yellowcolor,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    }
                                                  } else {
                                                    print(
                                                        "Quiz schedule is null.");
                                                  }
                                                } else {
                                                  print(
                                                      "Navigating to QuizDetails page...");
                                                       Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  QuizDetails(
                                                        quizId: quizId,
                                                        quizDuration: quiz.quizDuration,
            quizDescription: quiz.quizDescription ?? "",
            createdBy: quiz.createdBy ?? "",
            noOfMarks: quiz.noOfMarks ?? 0,
            numberOfQuestions: quiz.numberOfQuestions ?? 0,
                                                      ))
            );
                                                }
                                              } else if (statusCode == 400) {
                                                if (quiz.isFree == true) {
 DateTime quizSchedule = quiz.quizSchedule ?? DateTime.now();
          print("Navigating to QuizDetails page...");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FreeSubscriptionPage(
              quizId: quizId,
            createdBy: quiz.createdBy ?? "",
            quizTitle: quiz.quizTitle ?? '',
            quizCategory: quiz.quizCategory ?? '',
            quizSchedule: quizSchedule,
            quizSubCategory: quiz.quizSubCategory ?? '',
            isScheduled: quiz.isScheduled ?? false,),
            ));
                                                } else {
                                                  print(
                                                      "Navigating to PaymentPage...");
                                                  DateTime quizSchedule =
                                                      quiz.quizSchedule ??
                                                          DateTime.now();
                                                            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>PaymentPage(
                                                        email: "",
                                                        keyID: "",
                                                        keySecret: "",
                                                        quizTitle:
                                                            quiz.quizTitle ??
                                                                '',
                                                        quizCategory:
                                                            quiz.quizCategory ??
                                                                '',
                                                        quizSchedule:
                                                            quizSchedule,
                                                        amount: quiz.amount ?? 0.0,
                                                        createdBy: quiz.createdBy ??
                                                            "",
                                                        quizId: quizId,
                                                        isScheduled:
                                                            quiz.isScheduled ??
                                                                false,
                                                      ))
            );
                                             
                                                }
                                              } else {
                                                print(
                                                    "Unhandled status code: $statusCode");
                                              }
                                            } catch (e) {
                                              print(
                                                  "Error fetching subscription status: $e");
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
                                            backgroundColor:
                                                Colours.primaryColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
        )]
        ),
      ),
    );
  }
}