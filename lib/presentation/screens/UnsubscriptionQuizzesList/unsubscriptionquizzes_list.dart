
import 'package:RiddleQing/core/colors.dart';
import 'package:RiddleQing/gen/fonts.gen.dart';
import 'package:RiddleQing/presentation/screens/controller/unsubscribtionlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class UnsubscriptionQuizzesListPage extends StatefulWidget {
  const UnsubscriptionQuizzesListPage({super.key});

  @override
  State<UnsubscriptionQuizzesListPage> createState() => _UnsubscriptionQuizzesListPageState();
}

class _UnsubscriptionQuizzesListPageState extends State<UnsubscriptionQuizzesListPage> {
  final unsubscribtionlistController = Get.put<UnsubscribtionlistController>(UnsubscribtionlistController());

  @override
  void initState() {
    super.initState();
    unsubscribtionlistController.UnsubscribeListApi();
  }

  String formatDateTime(DateTime? dateTime) {
    return dateTime != null ? DateFormat('dd/MM/yyyy hh:mm a').format(dateTime) : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Unsubscribed Quizzes",
          style: TextStyle(
            color: Colours.CardColour,
            fontFamily: FontFamily.rubik,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        foregroundColor: Colours.CardColour,
        centerTitle: true,
        backgroundColor: Colours.primaryColor,
      ),
      backgroundColor: Colours.primaryColor,
      body: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32.0),
            topRight: Radius.circular(32.0),
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        child: Obx(() {
          if (unsubscribtionlistController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (unsubscribtionlistController.unsubscriptionListClass.value.data == null || unsubscribtionlistController.unsubscriptionListClass.value.data!.isEmpty) {
            return Center(
              child: Text(
                "No unsubscribed quizzes ",
                style: TextStyle(
                  color: Colours.cardTextColour,
                  fontFamily: FontFamily.rubik,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: unsubscribtionlistController.unsubscriptionListClass.value.data!.length,
              itemBuilder: (context, index) {
                final quiz = unsubscribtionlistController.unsubscriptionListClass.value.data![index];
                return Card(
                  color: Colours.CardColour,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5.0,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quiz Title: ${quiz.quizTitle}',
                          style: TextStyle(
                            color: Colours.primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Subscription Time: ${formatDateTime(quiz.subTime)}',
                          style: TextStyle(
                            color: Colours.textColour,
                            fontFamily: FontFamily.rubik,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Unsubscription Time: ${formatDateTime(quiz.unsubTime)}',
                          style: TextStyle(
                            color: Colours.textColour,
                            fontFamily: FontFamily.rubik,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}
