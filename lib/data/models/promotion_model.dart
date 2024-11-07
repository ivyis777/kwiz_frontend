class PromotionsModel {
  int? promotionId;
  String? description;
  int? quizId; 

  PromotionsModel({this.promotionId, this.description, this.quizId});

  PromotionsModel.fromJson(Map<String, dynamic> json) {
    promotionId = json['promotion_id'];
    description = json['description'];
    quizId = json['quiz_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['promotion_id'] = this.promotionId;
    data['description'] = this.description;
    data['quiz_id'] = this.quizId;
    return data;
  }
}
