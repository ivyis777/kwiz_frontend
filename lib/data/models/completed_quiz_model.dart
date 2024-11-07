import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

class CompletedQuizModel {
  List<PlayedQuizze>? playedQuizzes;
  String? status;

  CompletedQuizModel({this.playedQuizzes, this.status});

  CompletedQuizModel.fromJson(Map<String, dynamic> json) {
    if (json['Played_Quizzes'] != null) {
      playedQuizzes = <PlayedQuizze>[];
      json['Played_Quizzes'].forEach((v) {
        playedQuizzes!.add(PlayedQuizze.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.playedQuizzes != null) {
      data['Played_Quizzes'] =
          this.playedQuizzes!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class PlayedQuizze {
  int? resultId;
  int? correctAnswers;
  int? incorrectAnswers;
  int? numberOfQuestions;
  DateTime? quizSubmission;
  String? quizName;
  int? earnedAmount;
  int? quizId;
  int? userId;
  String? playStatus;
  int? quizTakeId;

  PlayedQuizze({
    this.resultId,
    this.correctAnswers,
    this.incorrectAnswers,
    this.numberOfQuestions,
    this.quizSubmission,
    this.quizName,
    this.earnedAmount,
    this.quizId,
    this.userId,
    this.playStatus,
    this.quizTakeId,
  });

  PlayedQuizze.fromJson(Map<String, dynamic> json) {
    tzdata.initializeTimeZones();
    final indianTimeZone = tz.getLocation('Asia/Kolkata');
    
    resultId = json['result_id'];
    correctAnswers = json['correct_answers'];
    incorrectAnswers = json['incorrect_answers'];
    numberOfQuestions = json['number_of_questions'];
    quizName = json['quiz_name'];
    earnedAmount = json['earned_amount'];
    quizId = json['quiz_id'];
    userId = json['user_id'];
    playStatus = json['play_status'];
    quizTakeId = json['quiz_take_id'];
    
    // Parse the quiz submission time and convert to IST
    quizSubmission = DateTime.parse(json['quiz_submission']).toUtc();
    final tz.TZDateTime quizScheduleInIST = tz.TZDateTime.from(quizSubmission!, indianTimeZone);
    quizSubmission = quizScheduleInIST;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['result_id'] = this.resultId;
    data['correct_answers'] = this.correctAnswers;
    data['incorrect_answers'] = this.incorrectAnswers;
    data['number_of_questions'] = this.numberOfQuestions;
    data['quiz_submission'] = quizSubmission?.toUtc().toIso8601String();
    data['quiz_name'] = this.quizName;
    data['earned_amount'] = this.earnedAmount;
    data['quiz_id'] = this.quizId;
    data['user_id'] = this.userId;
    data['play_status'] = this.playStatus;
    data['quiz_take_id'] = this.quizTakeId;
    return data;
  }
}
