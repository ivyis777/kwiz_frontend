import 'package:Kwiz/data/api_service.dart';
import 'package:Kwiz/data/models/wallet_balance_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';




class WalletBalanceController extends GetxController {
  var _walletBalanceModel = Rxn<WalletBalanceModel>();

  WalletBalanceModel? get walletBalanceModel => _walletBalanceModel.value;

  Future<void> getWalletBalanceUser({
    required BuildContext context,
    required String user_id,
  }) async {
    try {
      final walletBalance = await ApiService.walletBalanceApi(user_id: user_id);
      _walletBalanceModel.value = walletBalance;
    } catch (e) {
      print('Error fetching wallet balance: $e');
    }
  }
}