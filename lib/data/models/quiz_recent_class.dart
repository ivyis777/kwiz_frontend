class QuizRecentClass {
  String? quizTitle;
  int? result;
  String? status;

  QuizRecentClass({this.quizTitle, this.result, this.status});

  QuizRecentClass.fromJson(Map<String, dynamic> json) {
    quizTitle = json['quiz_title'];
    result = json['result'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quiz_title'] = this.quizTitle;
    data['result'] = this.result;
    data['status'] = this.status;
    return data;
  }
}
