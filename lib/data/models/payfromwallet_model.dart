import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

class PayWalletModel {
  String? message;
  String? walletBal;
  int? transactionId;
  double? amount; 
  DateTime? subTime;
  String? status;

  PayWalletModel({
    this.message,
    this.walletBal,
    this.transactionId,
    this.amount,
    this.subTime,
    this.status,
  });

  PayWalletModel.fromJson(Map<String, dynamic> json) {
    tzdata.initializeTimeZones(); 
    final indianTimeZone = tz.getLocation('Asia/Kolkata'); 

    message = json['message'];
    walletBal = json['wallet_bal'];
    transactionId = json['Transaction_id'];

    // Convert amount to double
    if (json['amount'] != null) {
      amount = double.tryParse(json['amount'].toString());
    }

    if (json['sub_time'] != null) {
      final parsedDate = DateTime.parse(json['sub_time']);
      subTime = tz.TZDateTime.from(parsedDate, indianTimeZone); 
    }

    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['wallet_bal'] = this.walletBal;
    data['Transaction_id'] = this.transactionId;

    // Serialize amount as double
    if (this.amount != null) {
      data['amount'] = this.amount.toString();
    }

    if (this.subTime != null) {
      data['sub_time'] = tz.TZDateTime.from(this.subTime!, tz.UTC).toIso8601String();
    }

    data['status'] = this.status;
    return data;
  }
}
