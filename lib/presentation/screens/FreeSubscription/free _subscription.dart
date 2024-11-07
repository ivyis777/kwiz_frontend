import 'package:Kwiz/core/colors.dart';
import 'package:Kwiz/core/storage_manager/local_storage_constants.dart';
import 'package:Kwiz/data/models/live_quizes_Model.dart';
import 'package:Kwiz/gen/assets.gen.dart';
import 'package:Kwiz/gen/fonts.gen.dart';
import 'package:Kwiz/presentation/screens/controller/add_categegory_controller.dart';
import 'package:Kwiz/presentation/screens/controller/payfromwallet_controller.dart';
import 'package:Kwiz/presentation/screens/controller/wallet_balance_controller.dart';
import 'package:Kwiz/presentation/screens/quiz_details/quiz_details.dart';
import 'package:Kwiz/presentation/widgets/common_ui_bg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class FreeSubscriptionPage extends StatefulWidget {
  final String quizTitle;
  final String quizCategory;
  final DateTime quizSchedule;
  final String? quizSubCategory;
  final String? createdBy;
  final String? quizId;
  final bool isScheduled;

  const FreeSubscriptionPage({
    Key? key,
    required this.quizId,
    this.quizTitle = '',
    this.quizCategory = '',
    required this.quizSchedule,
    this.quizSubCategory = '',
    this.createdBy = "",
    required this.isScheduled,
  }) : super(key: key);

  @override
  State<FreeSubscriptionPage> createState() => _FreeSubscriptionPageState();
}

class _FreeSubscriptionPageState extends State<FreeSubscriptionPage> {
  bool _isProcessing = false;

  int _selectedIndex = 0;
  late final QuizGetController quizGetController;
  final walletBalanceController = Get.put<WalletBalanceController>(WalletBalanceController());
  final payWalletController = Get.put<PayWalletController>(PayWalletController());

  @override
  void initState() {
    super.initState();
    quizGetController = Get.put(QuizGetController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      quizGetController.getQuiz();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  DateTime convertToIST(DateTime dateTime) {
    return dateTime.toUtc().add(const Duration(hours: 0, minutes: 0));
  }

  @override
  Widget build(BuildContext context) {
    DateTime quizScheduleIST = convertToIST(widget.quizSchedule);
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Subscribe To Play",
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
      backgroundColor: Colours.primaryColor,
      body: CommonUIBG(
        widget: Obx(
          () {
            final quizzes = quizGetController.filteredQuizList;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.03),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 9.0),
                    child: Card(
                      color: Colours.secondaryColour,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  Assets.images.cardimage4.path,
                                  width: screenWidth * 0.12,
                                  height: screenHeight * 0.12,
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.07),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.quizTitle,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: Colours.primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      widget.quizCategory,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colours.textColour,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      widget.quizSubCategory ?? '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colours.textColour,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text(
                                          'Created by :',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colours.black,
                                          ),
                                        ),
                                        SizedBox(width: screenWidth * 0.1),
                                        Text(
                                          widget.createdBy ?? '',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colours.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    if (widget.isScheduled)
                                      Container(
                                        margin: const EdgeInsets.only(right: 33),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              'Date & Time :',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Colours.black,
                                              ),
                                            ),
                                            const SizedBox(width: 2),
                                            Text(
                                              DateFormat('dd/MM/yyyy \n hh:mm a').format(quizScheduleIST),
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Colours.black,
                                              ),
                                            ),
                                          ],
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
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subscription Fee:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colours.black,
                          ),
                        ),
                        Text(
                          '₹0',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colours.black,
                          ),
                        ),
                      ],
                    ),
                  ),
            
                SizedBox(height: screenHeight * 0.08),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Center(
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
                await payWalletController.getPayWalletUser(
                  context: context,
                  user_id: userId,
                  amount: 0,
                  quiz_id: widget.quizId ?? '',
                  coupon_code: "",
                  coupon_applied: false,
                  amount_deducted: 0,
                );

                final quiz = quizzes.firstWhere(
                  (q) => q.quizId == widget.quizId,
                  orElse: () => QuizGetClass(),
                );

                print("Navigating to QuizDetails page...");
                 Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QuizDetails(
                  quizId: quiz.quizId.toString(),
                  quizDuration: quiz.quizDuration,
                  quizDescription: quiz.quizDescription ?? "",
                  createdBy: quiz.createdBy ?? "",
                  noOfMarks: quiz.noOfMarks ?? 0,
                  numberOfQuestions: quiz.numberOfQuestions ?? 0,
                )));
            
              } finally {
                setState(() {
                  _isProcessing = false; 
                });
              }
            },
      child: _isProcessing
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colours.CardColour),
            )
          : Text(
              'Subscribe',
              style: TextStyle(
                color: Colours.CardColour,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colours.primaryColor,
        minimumSize: Size(90, 40),
      ),
    ),
  ),
),

                ],
              ),
            );
          },
        ),
      ),
    
    );
  }
}
