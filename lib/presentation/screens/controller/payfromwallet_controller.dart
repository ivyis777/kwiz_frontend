
import 'package:RiddleQing/core/colors.dart';
import 'package:RiddleQing/data/api_service.dart';
import 'package:RiddleQing/presentation/screens/success%20and%20failure%20payment/SuccessAndFailure_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PayWalletController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
    var isSuccess = false.obs;

  void updateLoading(bool load) {
    isLoading.value = load;
    update();
  }

  void showPopup(String message) {
    Get.snackbar(
      '',
      '',
      backgroundColor: Colours.yellowcolor,
      colorText: Colours.CardColour,
      snackPosition: SnackPosition.TOP,
      messageText: Text(
        message,
        style: TextStyle(
          color: Colours.CardColour,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      titleText: SizedBox.shrink(),
    );
  }

  Future<void> getPayWalletUser({
    required BuildContext context,
    required String user_id,
    required String quiz_id,
    required double amount, 
    required String coupon_code,
    required bool coupon_applied,
    required double amount_deducted,
  }) async {
    if (user_id.isEmpty) {
      errorMessage.value = "User ID is required";
      print('Error: ${errorMessage.value}');
      showPopup(errorMessage.value);
      return;
    }

    updateLoading(true);
    try {
      final response = await ApiService.PayWalletapi(
        user_id: user_id,
        amount: amount,
        quiz_id: quiz_id,
        coupon_code: coupon_code,
        coupon_applied: coupon_applied,
        amount_deducted: amount_deducted,
      );
      updateLoading(false);

      int transactionId = response.transactionId ?? 0;
      String transactionAmount = (response.amount != null) ? double.tryParse(response.amount.toString())?.toString() ?? '0.0' : '0.0';
      DateTime subscriptionTime = response.subTime ?? DateTime.now();
        print('API Response Amount: ${response.amount}');
      if (response.status == "200") {
        print("Successfully Quiz Subscribed");
        showPopup("Successfully Quiz Subscribed");

        navigateToPaymentResult(
          context: context,
          isSuccess: true,
          transactionId: transactionId.toString(),
          amount: transactionAmount.toString(),
          subtime: subscriptionTime,
        );
      } else {
        handleErrorResponse(response.status.toString(), context, transactionId, transactionAmount, subscriptionTime);
      }
    } catch (e) {
      errorMessage.value = "An error occurred while processing the request";
      print('Error: $e');
      showPopup(errorMessage.value);
      updateLoading(false);
    }
  }

  void handleErrorResponse(String status, BuildContext context, int transactionId, String transactionAmount, DateTime subscriptionTime) {
    switch (status) {
      case "400":
        errorMessage.value = "Bad Request: The request could not be understood or was missing required parameters.";
        break;
      case "401":
        errorMessage.value = "User already subscribed";
        break;
      case "404":
        errorMessage.value = "Insufficient funds";
        break;
      case "405":
        errorMessage.value = "Quizzes not Subscribed";
        break;
      case "406":
        errorMessage.value = "Quiz Subscription Time Expired. Thank You";
        break;
      case "500":
        errorMessage.value = "Server error..please try later";
        break;
      default:
        errorMessage.value = "An unexpected error occurred";
    }
    print('Error: ${errorMessage.value}');
    showPopup(errorMessage.value);

    navigateToPaymentResult(
      context: context,
      isSuccess: false,
      transactionId: transactionId.toString(),
      amount: transactionAmount.toString(),
      subtime: subscriptionTime,
    );
  }

  void navigateToPaymentResult({
    required BuildContext context,
    required bool isSuccess,
    required String transactionId,
    required   amount,
    required DateTime subtime,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentResult(
          isSuccess: isSuccess,
          transactionId: transactionId,
          amount: amount,
          subtime: subtime,
        ),
      ),
    );
  }

 
  void payFromWallet(String keyID, String keySecret, double amount, double totalAmount, String s, String t, String quizTitle) {}
}
