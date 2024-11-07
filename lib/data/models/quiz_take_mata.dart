class QuizTakeMeta {
  String? message;
  String? status;
  int? quizTakeId;
  int? quizDuration;

  QuizTakeMeta({this.message, this.status, this.quizTakeId,this.quizDuration});

  QuizTakeMeta.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    quizTakeId = json['quiz_take_id'];
    quizDuration = json['quiz_duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['quiz_take_id'] = this.quizTakeId;
    data['quiz_duration'] = quizDuration;
    return data;
  }
}
