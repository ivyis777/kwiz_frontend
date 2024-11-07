import 'dart:ui';
import 'package:Kwiz/core/colors.dart';
import 'package:Kwiz/core/storage_manager/local_storage_constants.dart';
import 'package:Kwiz/data/api_service.dart';
import 'package:Kwiz/presentation/screens/controller/user_controller.dart';
import 'package:Kwiz/utils/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnboardingController extends GetxController {
  final UserController userController = Get.find<UserController>();

  // Flag to prevent multiple navigation calls
  var isNavigating = false.obs;

  Future<void> login({required String email, required String otp, required bool through_google}) async {
    try {
      final loginResponse = await ApiService.loginAPI(email: email, otp: otp, through_google: through_google);
      print('Login Response: $loginResponse');

      if (loginResponse != null && loginResponse.status == "200") {
        String nameToDisplay = loginResponse.name ?? loginResponse.username ?? 'Default Username';
        userController.username.value = loginResponse.username ?? 'Default Username';
        userController.displayName.value = nameToDisplay;

        final box = GetStorage();
        box.write(LocalStorageConstants.sessionManager, true);
        box.write(LocalStorageConstants.userId, loginResponse.userId);
        box.write(LocalStorageConstants.token, loginResponse.token);
        box.write(LocalStorageConstants.branchId, loginResponse.branchId);
        box.write(LocalStorageConstants.companyId, loginResponse.companyId);
        box.write(LocalStorageConstants.userEmail, loginResponse.userEmail);
        box.write(LocalStorageConstants.username, loginResponse.username);
        box.write(LocalStorageConstants.displayName, userController.displayName.value);

        Get.snackbar(
          'Success',
          'Login successful',
          backgroundColor: Colours.yellowcolor,
          colorText: Colours.CardColour,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.all(16),
          titleText: const Text(
            'Success',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          messageText: const Text(
            'Login successful',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        );

        if (!isNavigating.value) {
          isNavigating.value = true; // Prevent multiple navigations
          Get.offAll(() => MainLayout());
        }
      } else {
        _handleLoginError(loginResponse?.status);
      }
    } catch (e) {
      print('Exception during login: $e');
      Get.snackbar(
        'Error',
        'An unexpected error occurred. Please try again.',
        backgroundColor: const Color.fromARGB(255, 241, 174, 66),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(16),
        titleText: const Text(
          'Error',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        messageText: const Text(
          'An unexpected error occurred. Please try again.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      );
    }
  }

  void _handleLoginError(String? status) {
    String errorMessage;
    switch (status) {
      case "404":
        errorMessage = 'User does not exist';
        break;
      case "405":
        errorMessage = 'Only POST requests are allowed';
        break;
      case "500":
        errorMessage = 'Server Error';
        break;
      case "402":
        errorMessage = 'Entered Wrong OTP';
        break;
      case "403":
        errorMessage = 'Enter valid Details';
        break;
      default:
        errorMessage = 'Login failed. Please try again.';
    }

    Get.snackbar(
      'Error',
      errorMessage,
      backgroundColor: const Color.fromARGB(255, 241, 174, 66),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      titleText: const Text(
        'Error',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      messageText: Text(
        errorMessage,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}
