
import 'package:RiddleQing/core/colors.dart';
import 'package:RiddleQing/data/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class WalletTransferController extends GetxController {
  var isLoading = false.obs;

  void updateLoading(bool load) {
    isLoading.value = load;
    update();
  }

  Future<Map<String, dynamic>> getWalletTransferUser({
    required BuildContext context,
    required String user_id,
    required String to_email,
    required double amount,
  }) async {
    updateLoading(true);

    try {
      final response = await ApiService.walletTransferApi(user_id: user_id, to_email: to_email, amount: amount);
      updateLoading(false);

      print("Response status code: 200");
      print("Response body: ${response.message}");

    
      Get.snackbar(
        'Success',
        'Payment successful',
        backgroundColor: Colours.yellowcolor, 
        colorText: Colors.white, 
        snackPosition: SnackPosition.TOP,
        titleText: Text(
          'Success',
          style: TextStyle(
            fontSize: 22, 
                color: Colours.CardColour,
            fontWeight: FontWeight.bold, 
          ),
        ),
        messageText: Text(
          'Payment successful',
          style: TextStyle(
            fontSize: 20, 
                color: Colours.CardColour,
            fontWeight: FontWeight.normal, 
          ),
        ),
      );
      
      return {'status': '200', 'message': 'Payment successful'};
    } catch (e) {
      updateLoading(false);
      print("Error: $e");

      String errorMessage = e.toString();
      String message = 'Server error'; 
      if (errorMessage.contains('Recipient wallet not found')) {
        message = 'Recipient wallet not found';
      } else if (errorMessage.contains('Status ')) {
        String statusCode = errorMessage.split(' ')[1].replaceAll(':', '');
        switch (statusCode) {
          case '400':
            message = 'Missing required fields';
            break;
          case '401':
            message = 'User ID is not registered';
            break;
          case '403':
            message = 'Sender wallet not found';
            break;
          case '404':
            message = 'Insufficient funds';
            break;
          case '405':
            message = 'Invalid JSON format';
            break;
          case '406':
            message = 'Amount must be a number';
            break;
        }
      }

   
      Get.snackbar(
       'Transfer Failed',
        message,
        backgroundColor:Colours.yellowcolor, 
        colorText: Colors.white, 
        snackPosition: SnackPosition.TOP,
        titleText: Text(
          'Transfer Failed',
          style: TextStyle(
            fontSize: 18, 
            color: Colours.CardColour,
            fontWeight: FontWeight.bold, 
          ),
        ),
        messageText: Text(
          message,
          style: TextStyle(
            fontSize: 20, 
                color: Colours.CardColour,
            fontWeight: FontWeight.normal,
          ),
        ),
      );
      
      return {'status': 'Error', 'message': message};
    }
  }
}
