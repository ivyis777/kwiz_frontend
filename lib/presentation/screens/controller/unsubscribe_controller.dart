
import 'package:RiddleQing/core/colors.dart';
import 'package:RiddleQing/data/api_service.dart';
import 'package:RiddleQing/data/models/Unsubscribe_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class UnsubscribeController {
  final String user_id;
  final String quiz_id;

  UnsubscribeController({required this.user_id, required this.quiz_id});

  Future<void> unsubscribe() async {
    try {
      // Directly get the UnsubscribeModel instance
      UnsubscribeModel result = await ApiService.Unsubscribedapi(
        user_id: user_id,
        quiz_id: quiz_id,
      );

      // Check the status
      if (result.status == 'success') {
        Get.snackbar(
          'Unsubscribe Successful',
          result.message ?? 'You have successfully unsubscribed.',
           messageText: Text(
           result.message ?? 'You have successfully unsubscribed.',
        style: TextStyle(
          color: Colours.CardColour,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colours.yellowcolor,
          colorText: Colors.white,
        );
      } 
      else if (result.status == '406') {
        Get.snackbar(
          '',
          result.message ?? 'Quiz Unsubscription Time Ended',
           messageText: Text(
         result.message ?? 'Quiz Unsubscription Time Ended',
        style: TextStyle(
          color: Colours.CardColour,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colours.yellowcolor,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          '',
          result.message ?? 'An unknown error occurred.',
          messageText: Text(
          result.message ?? 'An unknown error occurred.',
        style: TextStyle(
          color: Colours.CardColour,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colours.yellowcolor,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error occurred during unsubscribe: $e',
       
          messageText: Text(
          'Error occurred during unsubscribe: $e',
        style: TextStyle(
          color: Colours.CardColour,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.yellow,
        colorText: Colors.white,
      );
    }
  }
}
