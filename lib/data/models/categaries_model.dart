class CategariesModel {
  int? quizCategoryId;
  String? quizCategory;
  int? quizTypeId;

  CategariesModel({this.quizCategoryId, this.quizCategory, this.quizTypeId});

  CategariesModel.fromJson(Map<String, dynamic> json) {
    quizCategoryId = json['quiz_category_id'];
    quizCategory = json['quiz_category'];
    quizTypeId = json['quiz_type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quiz_category_id'] = this.quizCategoryId;
    data['quiz_category'] = this.quizCategory;
    data['quiz_type_id'] = this.quizTypeId;
    return data;
  }
}
