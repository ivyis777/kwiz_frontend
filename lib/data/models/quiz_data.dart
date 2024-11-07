class QuizData {
  int? id;
  int? userId;
  int? quizId;
  int? quesId;
  int? ansId;
  bool? result;
  String? submittedAt;
  bool? skip;
  int? quizTakeId;

  QuizData(
      {this.id,
        this.userId,
        this.quizId,
        this.quesId,
        this.ansId,
        this.result,
        this.submittedAt,
        this.skip,
        this.quizTakeId});

  QuizData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    quizId = json['quiz_id'];
    quesId = json['ques_id'];
    ansId = json['ans_id'];
    result = json['result'];
    submittedAt = json['submitted_at'];
    skip = json['skip'];
    quizTakeId = json['quiz_take_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['quiz_id'] = this.quizId;
    data['ques_id'] = this.quesId;
    data['ans_id'] = this.ansId;
    data['result'] = this.result;
    data['submitted_at'] = this.submittedAt;
    data['skip'] = this.skip;
    data['quiz_take_id'] = this.quizTakeId;
    return data;
  }
}