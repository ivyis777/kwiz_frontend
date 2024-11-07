import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

class WalletBalanceModel {
  double? walletBalance;  // Change int to double
  List<Debits>? debits;
  List<Credits>? credits;
  String? status;

  WalletBalanceModel({this.walletBalance, this.debits, this.credits, this.status});

  WalletBalanceModel.fromJson(Map<String, dynamic> json) {
    tzdata.initializeTimeZones();
    final indianTimeZone = tz.getLocation('Asia/Kolkata');

    walletBalance = json['Wallet balance'] as double?;  // Update to directly assign to double

    if (json['Debits'] != null) {
      debits = <Debits>[];
      json['Debits'].forEach((v) {
        debits!.add(Debits.fromJson(v, indianTimeZone));
      });
    }
    if (json['Credits'] != null) {
      credits = <Credits>[];
      json['Credits'].forEach((v) {
        credits!.add(Credits.fromJson(v, indianTimeZone));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['Wallet balance'] = this.walletBalance;  // No change needed here
    if (this.debits != null) {
      data['Debits'] = this.debits!.map((v) => v.toJson()).toList();
    }
    if (this.credits != null) {
      data['Credits'] = this.credits!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Debits {
  int? transactionId;
  DateTime? dateTime;
  String? amount;
  String? to;

  Debits({this.transactionId, this.dateTime, this.amount, this.to});

  Debits.fromJson(Map<String, dynamic> json, tz.Location indianTimeZone) {
    transactionId = json['transaction_id'];
    dateTime = DateTime.tryParse(json['date_time'])?.toUtc();
    if (dateTime != null) {
      dateTime = tz.TZDateTime.from(dateTime!, indianTimeZone);
    }
    amount = json['amount'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['transaction_id'] = this.transactionId;
    data['date_time'] = this.dateTime?.toUtc().toIso8601String();
    data['amount'] = this.amount;
    data['to'] = this.to;
    return data;
  }
}

class Credits {
  int? transactionId;
  DateTime? dateTime;
  String? amount;
  String? fromUsername;

  Credits({this.transactionId, this.dateTime, this.amount, this.fromUsername});

  Credits.fromJson(Map<String, dynamic> json, tz.Location indianTimeZone) {
    transactionId = json['transaction_id'];
    dateTime = DateTime.tryParse(json['date_time'])?.toUtc();
    if (dateTime != null) {
      dateTime = tz.TZDateTime.from(dateTime!, indianTimeZone);
    }
    amount = json['amount'];
    fromUsername = json['from_username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['transaction_id'] = this.transactionId;
    data['date_time'] = this.dateTime?.toUtc().toIso8601String();
    data['amount'] = this.amount;
    data['from_username'] = this.fromUsername;
    return data;
  }
}
