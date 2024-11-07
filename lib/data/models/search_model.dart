class SearchModel {
  int? quizId;
  String? quizCategory;
  String? quizSubCategory;
  String? quizTitle;

  SearchModel(
      {this.quizId, this.quizCategory, this.quizSubCategory, this.quizTitle});

  SearchModel.fromJson(Map<String, dynamic> json) {
    quizId = json['quiz_id'];
    quizCategory = json['quiz_category'];
    quizSubCategory = json['quiz_sub_category'];
    quizTitle = json['quiz_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quiz_id'] = this.quizId;
    data['quiz_category'] = this.quizCategory;
    data['quiz_sub_category'] = this.quizSubCategory;
    data['quiz_title'] = this.quizTitle;
    return data;
  }
}
