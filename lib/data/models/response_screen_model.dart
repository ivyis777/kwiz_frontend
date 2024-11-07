class RazorpayOrderResponse {
  int? statusCode;
  String? message;
  Data? data;

  RazorpayOrderResponse({this.statusCode, this.message, this.data});

  RazorpayOrderResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? entity;
  int? amount;
  int? amountPaid;
  int? amountDue;
  String? currency;
  dynamic receipt;
  dynamic offerId;
  String? status;
  int? attempts;
  List<String>? notes; // Assuming notes are strings
  int? createdAt;

  Data({
    this.id,
    this.entity,
    this.amount,
    this.amountPaid,
    this.amountDue,
    this.currency,
    this.receipt,
    this.offerId,
    this.status,
    this.attempts,
    this.notes,
    this.createdAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entity = json['entity'];
    amount = json['amount'];
    amountPaid = json['amount_paid'];
    amountDue = json['amount_due'];
    currency = json['currency'];
    receipt = json['receipt'];
    offerId = json['offer_id'];
    status = json['status'];
    attempts = json['attempts'];
    if (json['notes'] != null) {
      notes = List<String>.from(json['notes']);
    }
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['entity'] = entity;
    data['amount'] = amount;
    data['amount_paid'] = amountPaid;
    data['amount_due'] = amountDue;
    data['currency'] = currency;
    data['receipt'] = receipt;
    data['offer_id'] = offerId;
    data['status'] = status;
    data['attempts'] = attempts;
    data['notes'] = notes;
    data['created_at'] = createdAt;
    return data;
  }
}
