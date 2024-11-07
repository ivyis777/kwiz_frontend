class LeaderBoardAllModel {
  List<Data>? data;
  String? status;

  LeaderBoardAllModel({this.data, this.status});

  LeaderBoardAllModel.fromJson(Map<String, dynamic> json) {
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
  String? username;
  int? correctAnswers;
  int? incorrectAnswers;
  int? numberOfQuestions;
  String? quizSubmission;
  String? quizName;
  int? earnedAmount;
  int? quizId;
  int? userId;
  String? startedAt;
  String? timeTaken;
  int? quizTakeId;

  Data(
      {this.username,
      this.correctAnswers,
      this.incorrectAnswers,
      this.numberOfQuestions,
      this.quizSubmission,
      this.quizName,
      this.earnedAmount,
      this.quizId,
      this.userId,
      this.startedAt,
      this.timeTaken,
      this.quizTakeId});

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    correctAnswers = json['correct_answers'];
    incorrectAnswers = json['incorrect_answers'];
    numberOfQuestions = json['number_of_questions'];
    quizSubmission = json['quiz_submission'];
    quizName = json['quiz_name'];
    earnedAmount = json['earned_amount'];
    quizId = json['quiz_id'];
    userId = json['user_id'];
    startedAt = json['started_at'];
    timeTaken = json['time_taken'];
    quizTakeId = json['quiz_take_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['correct_answers'] = this.correctAnswers;
    data['incorrect_answers'] = this.incorrectAnswers;
    data['number_of_questions'] = this.numberOfQuestions;
    data['quiz_submission'] = this.quizSubmission;
    data['quiz_name'] = this.quizName;
    data['earned_amount'] = this.earnedAmount;
    data['quiz_id'] = this.quizId;
    data['user_id'] = this.userId;
    data['started_at'] = this.startedAt;
    data['time_taken'] = this.timeTaken;
    data['quiz_take_id'] = this.quizTakeId;
    return data;
  }
}
