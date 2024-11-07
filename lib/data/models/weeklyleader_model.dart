import 'package:intl/intl.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
class weeklyLeaderBoardModel {
  List<Data>? data;

  weeklyLeaderBoardModel({this.data});

  weeklyLeaderBoardModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? correctAnswers;
  int? incorrectAnswers;
  int? numberOfQuestions;
  DateTime? quizSubmission;
  String? quizName;
  int? earnedAmount;
  int? quizId;
  int? userId;
  String? startedAt;
  String? timeTaken;
  String? username;
  String? playStatus;
  int? quizTakeId;

  Data(
      {this.correctAnswers,
      this.incorrectAnswers,
      this.numberOfQuestions,
      this.quizSubmission,
      this.quizName,
      this.earnedAmount,
      this.quizId,
      this.userId,
      this.startedAt,
      this.timeTaken,
      this.username,
      this.playStatus,
      this.quizTakeId});

  Data.fromJson(Map<String, dynamic> json) {
    correctAnswers = json['correct_answers'];
    incorrectAnswers = json['incorrect_answers'];
    numberOfQuestions = json['number_of_questions'];
   quizSubmission = json['quiz_submission'] != null
        ? _parseDate(json['quiz_submission'])
        : null;
    quizName = json['quiz_name'];
    earnedAmount = json['earned_amount'];
    quizId = json['quiz_id'];
    userId = json['user_id'];
    startedAt = json['started_at'];
    timeTaken = json['time_taken'];
    username = json['username'];
    playStatus = json['play_status'];
    quizTakeId = json['quiz_take_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['correct_answers'] = this.correctAnswers;
    data['incorrect_answers'] = this.incorrectAnswers;
    data['number_of_questions'] = this.numberOfQuestions;
     data['quiz_submission'] = this.quizSubmission != null
        ? _formatDate(this.quizSubmission!)
        : null;
    data['quiz_name'] = this.quizName;
    data['earned_amount'] = this.earnedAmount;
    data['quiz_id'] = this.quizId;
    data['user_id'] = this.userId;
    data['started_at'] = this.startedAt;
    data['time_taken'] = this.timeTaken;
    data['username'] = this.username;
    data['play_status'] = this.playStatus;
    data['quiz_take_id'] = this.quizTakeId;
    return data;
  }

 // Helper method to parse date from string
  DateTime _parseDate(String dateString) {
    // Example format; adjust based on your actual date format
    return DateTime.parse(dateString).toUtc().add(Duration(hours: 5, minutes: 30)); // Convert to IST
  }

  // Helper method to format date to string
  String _formatDate(DateTime date) {
    // Format as ISO string; adjust based on your needs
    return DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(date.toUtc().subtract(Duration(hours: 5, minutes: 30))); // Convert to UTC
  }
}