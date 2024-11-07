class SubCategariesModel {
  int? quizSubCategoryId;
  String? quizSubCategory;
  int? quizCategoryId;

  SubCategariesModel(
      {this.quizSubCategoryId, this.quizSubCategory, this.quizCategoryId});

  SubCategariesModel.fromJson(Map<String, dynamic> json) {
    quizSubCategoryId = json['quiz_sub_category_id'];
    quizSubCategory = json['quiz_sub_category'];
    quizCategoryId = json['quiz_category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quiz_sub_category_id'] = this.quizSubCategoryId;
    data['quiz_sub_category'] = this.quizSubCategory;
    data['quiz_category_id'] = this.quizCategoryId;
    return data;
  }
}
 