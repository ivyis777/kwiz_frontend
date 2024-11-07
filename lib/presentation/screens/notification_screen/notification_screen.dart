import 'package:Kwiz/core/colors.dart';
import 'package:Kwiz/gen/fonts.gen.dart';
import 'package:Kwiz/presentation/screens/controller/QuizNotifications_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final QuiznotificationsController quiznotificationsController = Get.put(QuiznotificationsController());

  @override
  void initState() {
    super.initState();
    quiznotificationsController.quizNotifications();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
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
      backgroundColor: Colours.CardColour,
      body: Obx(
        () {
          if (quiznotificationsController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

        
          quiznotificationsController.notificationClass.sort((a, b) {
            DateTime aTime = a.getTimestampAsDateTime() ?? DateTime.now();
            DateTime bTime = b.getTimestampAsDateTime() ?? DateTime.now();
            return bTime.compareTo(aTime); 
          });

          return ListView.builder(
            itemCount: quiznotificationsController.notificationClass.length,
            itemBuilder: (context, index) {
              final notification = quiznotificationsController.notificationClass[index];

              final DateTime timestamp = notification.getTimestampAsDateTime() ?? DateTime.now();
              final String formattedTime = DateFormat('MMM d, yyyy h:mm a').format(timestamp);

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Text(
                        formattedTime,
                        style: TextStyle(
                          fontFamily: FontFamily.rubik,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colours.formTextColour,
                        ),
                      ),
                    ),
                    Card(
                      color: Colours.secondaryColour,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(
                          color: Colours.cardTextColour,
                          width: 0.1,
                        ),
                      ),
                      child: Container(
                        width: screenWidth * 0.9,
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(
                                notification.title ?? '',
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
                                  Text(
                                    notification.message ?? '',
                                    style: TextStyle(
                                      fontFamily: FontFamily.rubik,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colours.textColour,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
