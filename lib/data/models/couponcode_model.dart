class CouponCodeModel {
  String? message;
  String? amount;
  bool? couponApplied;
  String? amountDeducted;
  String? status;

  CouponCodeModel({
    this.message,
    this.amount,
    this.couponApplied,
    this.amountDeducted,
    this.status,
  });

  CouponCodeModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    amount = json['amount'];
    couponApplied = json['coupon_applied'] == true;  
    amountDeducted = json['amount_deducted'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['amount'] = this.amount;
    data['coupon_applied'] = this.couponApplied;
    data['amount_deducted'] = this.amountDeducted;
    data['status'] = this.status;
    return data;
  }
}
