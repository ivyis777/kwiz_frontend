import 'package:Kwiz/core/colors.dart';
import 'package:Kwiz/data/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResendOtpController extends GetxController {
  var isLoading = false.obs;
  var isButtonEnabled = true.obs;

  void updateLoading(bool load) {
    isLoading.value = load;
    update();
  }

  Future<bool> getResendOtpUser({
    required BuildContext context,
    required String email,
  }) async {
    updateLoading(true);

    final response = await ApiService.ResendotpURL(email: email);

    updateLoading(false);

    print("Response status code: ${response.status}");
    print("Response body: ${response.message}");

    if (response.status == "200") {
      showTopSnackBar(context, 'Success', 'OTP sent successfully', true);
      return true; // Indicate success
    } else if (response.status == "401") {
      showTopSnackBar(context, 'Failed', 'OTP not sent. Please try Get OTP', false);
    } else {
      showTopSnackBar(context, 'Failed', 'Failed to verify', false);
    }

    return false; // Indicate failure
  }

  void showTopSnackBar(BuildContext context, String title, String message, bool isSuccess) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).viewInsets.top + 50,
        left: 10,
        right: 10,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSuccess ? Colours.yellowcolor : Colours.yellowcolor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colours.CardColour,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colours.CardColour,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay?.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 3), () => overlayEntry.remove());
  }
}
