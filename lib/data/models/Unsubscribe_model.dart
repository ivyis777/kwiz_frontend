class UnsubscribeModel {
  String? message;
  String? status;
  String? walletBalance;

  UnsubscribeModel({this.message, this.status, this.walletBalance});

  UnsubscribeModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    walletBalance = json['wallet_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['wallet_balance'] = this.walletBalance;
    return data;
  }
}
