
import 'package:RiddleQing/core/colors.dart';
import 'package:RiddleQing/data/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../emailpage/otp_page.dart';


class OtpController extends GetxController {
  var isLoading = false.obs;

  void updateLoading(bool load) {
    isLoading.value = load;
    update();
  }

  Future<void> getOtpUser({
    required BuildContext context,
    required String username,
    required String mobile,
    required String email,
  }) async {
    updateLoading(true);

    final response = await ApiService.OtpApi(username: username, mobile: mobile, email: email);

    updateLoading(false);

    print("Response status code: ${response.status}");
    print("Response body: ${response.message}");

    if (response.status == "200") {
      Get.to(OTPPage(email: email, username: username, mobile: mobile));
      _showSnackbar('Success', 'OTP sent successfully', true);
    } else if (response.status == "401") {
      _showSnackbar('Failed', 'User has already registered', false);
    } else {
      _showSnackbar('Failed', 'Failed to register', false);
    }
  }

  void _showSnackbar(String title, String message, bool isSuccess) {
    Get.snackbar(
      title,
      message,
      backgroundColor: isSuccess ? Colours.yellowcolor : Colours.yellowcolor,
      snackPosition: SnackPosition.TOP, 
      duration: Duration(seconds: 3), 
      snackStyle: SnackStyle.FLOATING, 
      margin: EdgeInsets.all(16), 
      titleText: Text(
        title,
        style: TextStyle(
          fontSize: 18, 
          fontWeight: FontWeight.bold,
       color:  Colours.CardColour,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          fontSize: 16, 
         color:  Colours.CardColour,
        ),
      ),
    );
  }
}
