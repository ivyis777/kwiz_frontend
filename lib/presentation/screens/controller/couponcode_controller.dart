import 'package:Kwiz/core/colors.dart';
import 'package:Kwiz/data/api_service.dart';
import 'package:Kwiz/data/models/couponcode_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CouponcodeController extends GetxController {
  double amount;
  RxString couponCode;
  var isLoading = false.obs; 
  RxString couponMessage = ''.obs;
  RxDouble amountDeducted = 0.0.obs;
  RxDouble originalAmount = 0.0.obs;

  CouponcodeController({
    required this.amount,
    required String coupon_code,
  }) : couponCode = coupon_code.obs {
    originalAmount.value = amount;
  }

Future<bool> applyCouponCode() async {
  isLoading.value = true;
  try {
    // Fetching the coupon code data from the API
    final CouponCodeModel response = await ApiService.CouponCodeApi(
      amount: originalAmount.value,
      coupon_code: couponCode.value,
    );

    print('Parsed response: ${response.toJson()}');

    // Handle the response
    if (response.status == "200") {
      // Extract values from response
      double amountDeductedValue = double.tryParse(response.amountDeducted ?? '0.0') ?? 0.0;

      // Update observable values
      amountDeducted.value = amountDeductedValue;
      amount = originalAmount.value - amountDeducted.value;

      // Extract and display the success message
      couponMessage.value = "Coupon applied successfully. Discount: ₹${amountDeducted.value}";
      _showSnackbar(couponMessage.value);

      return true; // Indicate success
    } else {
      // Handle unexpected status codes
      _handleErrorResponse(response);
      return false; // Indicate failure
    }
  } on ApiException catch (e) {
    // Handle API exceptions
    couponMessage.value = e.message;
    _showSnackbar(couponMessage.value);
    return false; // Indicate failure
  } catch (e) {
    // Handle unexpected errors
    couponMessage.value = 'An unexpected error occurred.';
    _showSnackbar(couponMessage.value);
    return false; // Indicate failure
  } finally {
    // Reset loading state regardless of the outcome
    isLoading.value = false;
  }
}


  void _handleErrorResponse(CouponCodeModel response) {
    final error = response.message ?? 'An error occurred.';
    final statusCode = response.status ?? '500';

    // Reset amount and amount deducted
    amountDeducted.value = 0.0;
    amount = originalAmount.value;

    switch (statusCode) {
      case '404':
        couponMessage.value = 'Enter coupon code';
        break;
      case '401':
        couponMessage.value = 'Coupon is not valid on the current date.';
        break;
      case '405':
        couponMessage.value = 'Invalid coupon code';
        break;
      case '500':
        couponMessage.value = 'Server error. Please try again later.';
        break;
      default:
        couponMessage.value = 'An error occurred. Please try again.';
        break;
    }
    _showSnackbar(couponMessage.value);
  }

  void _showSnackbar(String message) {
    Get.snackbar(
      "",
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colours.yellowcolor,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      snackStyle: SnackStyle.FLOATING,
      messageText: Center(
        child: Text(
          message,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

}