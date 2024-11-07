class QuizResultModel {
  int? correctAnswers;
  int? incorrectAnswers;
  int? totalNoOfQuestions;
  String? status;

  QuizResultModel(
      {this.correctAnswers,
      this.incorrectAnswers,
      this.totalNoOfQuestions,
      this.status});

  QuizResultModel.fromJson(Map<String, dynamic> json) {
    correctAnswers = json['Correct_answers'];
    incorrectAnswers = json['incorrect_answers'];
    totalNoOfQuestions = json['Total_no_of_questions'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Correct_answers'] = this.correctAnswers;
    data['incorrect_answers'] = this.incorrectAnswers;
    data['Total_no_of_questions'] = this.totalNoOfQuestions;
    data['status'] = this.status;
    return data;
  }
}
