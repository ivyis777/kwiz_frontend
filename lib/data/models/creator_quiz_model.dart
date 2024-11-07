class CreatorQuizModel {
  List<Data>? data;
  String? status;

  CreatorQuizModel({this.data, this.status});

  CreatorQuizModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String? quizTitle;
  int? quizId;
  int? numberOfQuestions;
  String? quizSubCategory;

  Data(
      {this.quizTitle,
      this.quizId,
      this.numberOfQuestions,
      this.quizSubCategory});

  Data.fromJson(Map<String, dynamic> json) {
    quizTitle = json['quiz_title'];
    quizId = json['quiz_id'];
    numberOfQuestions = json['number_of_questions'];
    quizSubCategory = json['quiz_sub_category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quiz_title'] = this.quizTitle;
    data['quiz_id'] = this.quizId;
    data['number_of_questions'] = this.numberOfQuestions;
    data['quiz_sub_category'] = this.quizSubCategory;
    return data;
  }
}
