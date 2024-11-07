class WalletTransferModel {
  String? message;
  double? walletBalance;
  String? status;

  WalletTransferModel({this.message, this.walletBalance, this.status});

  WalletTransferModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    walletBalance = json['wallet_balance'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['wallet_balance'] = this.walletBalance;
    data['status'] = this.status;
    return data;
  }
}
