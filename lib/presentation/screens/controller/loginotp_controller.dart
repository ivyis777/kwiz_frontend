import 'package:Kwiz/core/colors.dart';
import 'package:Kwiz/data/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginOtpController extends GetxController {
  var isLoading = false.obs;
  var isButtonEnabled = true.obs;

  void updateLoading(bool load) {
    isLoading.value = load;
  }

  Future<bool> getLoginOtpUser({
    required BuildContext context,
    required String email,
  }) async {
    updateLoading(true);

    final response = await ApiService.LoginotpURL(email: email);
    updateLoading(false);

    print("Response status code: ${response.status}");
    print("Response body: ${response.message}");

    if (response.status == "200") {
      _showSnackbar('Success', 'Email sent successfully', true);
      return true; // Indicate success
    } else if (response.status == "401") {
      _showSnackbar('Failed', 'Email not registered', false);
    } else if (response.status == "402") {
      _showSnackbar('Failed', 'Invalid OTP', false);
    } else {
      _showSnackbar('Failed', 'Failed to register', false);
    }
    
    return false; // Indicate failure
  }

  void _showSnackbar(String title, String message, bool isSuccess) {
    Get.snackbar(
      title,
      message,
      backgroundColor: isSuccess ? Colours.yellowcolor : Colours.yellowcolor,
      colorText: Colours.CardColour,
      snackPosition: SnackPosition.TOP,
      snackStyle: SnackStyle.FLOATING,
      margin: EdgeInsets.all(16),
      titleText: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colours.CardColour,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colours.CardColour,
        ),
      ),
    );
  }
}
