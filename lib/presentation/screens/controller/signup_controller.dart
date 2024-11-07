import 'package:Kwiz/core/colors.dart';
import 'package:Kwiz/data/api_service.dart';
import 'package:Kwiz/presentation/screens/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SignupController extends GetxController {
  var isLoading = false.obs;

  void updateLoading(bool load) {
    isLoading.value = load;
    update();
  }

  Future<void> getSignupUser({
    required BuildContext context,
    required String username,
    required String mobile,
    required String email,
    required String otp,
    required String fcmToken,
  }) async {
    updateLoading(true);

    final response = await ApiService.signupApi(
      username: username,
      mobile: mobile,
      email: email,
      otp: otp,
      fcmToken: fcmToken,
    );

    updateLoading(false);

    if (response.status == "200") {
      Get.offAll(OnBoardingPage());
      _showSnackbar('Success', 'Registered successfully! Please login', true);
    } else {
      _showSnackbar('Error', 'Invalid OTP', false);
    }
  }

  void _showSnackbar(String title, String message, bool isSuccess) {
    Get.snackbar(
      title,
      message,
      backgroundColor: isSuccess ? Colours.yellowcolor : Colours.yellowcolor, 
      colorText: Colors.white, 
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 3), 
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
          color: Colours.CardColour,
        ),
      ),
    );
  }
}
