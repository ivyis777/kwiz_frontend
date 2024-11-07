
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

class SubscribedQuizModel {
  List<SubscribedQuizzes>? subscribedQuizzes;
  String? status;

  SubscribedQuizModel({this.subscribedQuizzes, this.status});

  SubscribedQuizModel.fromJson(Map<String, dynamic> json) {
    if (json['Subscribed_Quizzes'] != null) {
      subscribedQuizzes = <SubscribedQuizzes>[];
      json['Subscribed_Quizzes'].forEach((v) {
        subscribedQuizzes!.add(new SubscribedQuizzes.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subscribedQuizzes != null) {
      data['Subscribed_Quizzes'] =
          this.subscribedQuizzes!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class SubscribedQuizzes {
  String? quizId;
  String? quizTitle;
  String? quizCategory;
  String? quizSubCategory;
  String? quizDescription;
  int? quizDuration;
  DateTime? quizSchedule;
  double? amount;
  String? difficultyLevel;
  int? numberOfQuestions;
  String? createdBy;

  SubscribedQuizzes({
    this.quizId,
    this.quizTitle,
    this.quizCategory,
    this.quizSubCategory,
    this.quizDescription,
    this.quizDuration,
    this.quizSchedule,
    this.amount,
    this.difficultyLevel,
    this.numberOfQuestions,
    this.createdBy,
  });

  SubscribedQuizzes.fromJson(Map<String, dynamic> json) {
    tzdata.initializeTimeZones();
    final indianTimeZone = tz.getLocation('Asia/Kolkata');
    quizId = json['quiz_id'];
    quizTitle = json['quiz_title'];
    quizCategory = json['quiz_category'];
    quizSubCategory = json['quiz_sub_category'];
    quizDescription = json['quiz_description'];
    quizDuration = json['quiz_duration']; /// Ensure this matches the JSON structure
    var quizScheduleString = json['quiz_schedule'];
    quizSchedule =
        quizScheduleString != null ? DateTime.parse(quizScheduleString) : null;

    amount = json['amount']; // Ensure this matches the JSON structure
    difficultyLevel = json['difficulty_level'];
    numberOfQuestions = json['number_of_questions'];
    createdBy = json['created_by'];

    // Convert the DateTime to Indian Standard Time
    if (quizSchedule != null) {
      final tz.TZDateTime quizScheduleInIST =
          tz.TZDateTime.from(quizSchedule!, indianTimeZone);
      quizSchedule = quizScheduleInIST;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quiz_id'] = this.quizId;
    data['quiz_title'] = this.quizTitle;
    data['quiz_category'] = this.quizCategory;
    data['quiz_sub_category'] = this.quizSubCategory;
    data['quiz_description'] = this.quizDescription;
    data['quiz_duration'] = this.quizDuration; // Ensure this matches the JSON structure
    data['quiz_schedule'] = quizSchedule?.toUtc().toIso8601String();
    data['amount'] = this.amount; // Ensure this matches the JSON structure
    data['difficulty_level'] = this.difficultyLevel;
    data['number_of_questions'] = this.numberOfQuestions;
    data['created_by'] = this.createdBy;
    return data;
  }

 
  }

