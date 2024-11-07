
 import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

class QuizGetClass {
  String? quizId;
  bool? isSubscribed;
  bool? isCreator;
  String ? quizCategory;
  String ? quizSubCategory;
  int? noOfMarks;
  bool? isScheduled;
  String? quizTitle;
  String? quizDescription;
  int? quizDuration;
  DateTime? quizSchedule;
  double? amount;
  double? priceMoney;
  String? image;
  bool? isFree;
  bool? isLive;
  String? difficultyLevel;
  int? numberOfQuestions;
  String? quizType;
  String? createdBy;
  int? quizCategoryId;
  int? quizSubCategoryId;

  QuizGetClass(
      {this.quizId,
      this.isSubscribed,
      this.isCreator,
      this.quizCategory,
      this.quizSubCategory,
      this.noOfMarks,
      this.isScheduled,
      this.quizTitle,
      this.quizDescription,
      this.quizDuration,
      this.quizSchedule,
      this.amount,
      this.priceMoney,
      this.image,
      this.isFree,
      this.isLive,
      this.difficultyLevel,
      this.numberOfQuestions,
      this.quizType,
      this.createdBy,
      this.quizCategoryId,
      this.quizSubCategoryId});

  QuizGetClass.fromJson(Map<String, dynamic> json) {
     tzdata.initializeTimeZones(); // Initialize timezones data
    final indianTimeZone = tz.getLocation('Asia/Kolkata'); // Indian timezone

    quizId = json['quiz_id'];
    isSubscribed = json['is_subscribed'];
    isCreator = json['is_creator'];
    quizCategory = json['quiz_category'];
    quizSubCategory = json['quiz_sub_category'];
    noOfMarks = json['no_of_marks'];
    isScheduled = json['is_scheduled'];
    quizTitle = json['quiz_title'];
    quizDescription = json['quiz_description'];
    quizDuration = json['quiz_duration'];
    amount = json['amount']?.toDouble();
    priceMoney = json['price_money']?.toDouble();
    image = json['image'];
    isFree = json['is_free'];
    isLive = json['is_live'];
    difficultyLevel = json['difficulty_level'];
    numberOfQuestions = json['number_of_questions'];
    quizType = json['quiz_type'];
    createdBy = json['created_by'];
    quizCategoryId = json['quiz_category_id'];
    quizSubCategoryId = json['quiz_sub_category_id'];
     final quizScheduleString = json['quiz_schedule'];
    if (isScheduled == false) {
      quizSchedule = null; // Set quizSchedule to null if isScheduled is false
    } else {
      // Handle nullable case and convert to UTC
      quizSchedule = quizScheduleString != null
          ? DateTime.parse(quizScheduleString).toUtc()
          : null;
      // Convert quizSchedule to IST if it's not null
      if (quizSchedule != null) {
        final tz.TZDateTime quizScheduleInIST =
            tz.TZDateTime.from(quizSchedule!, indianTimeZone);
        quizSchedule = quizScheduleInIST;
      }
    
  }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quiz_id'] = this.quizId;
    data['is_subscribed'] = this.isSubscribed;
    data['is_creator'] = this.isCreator;
    data['quiz_category'] = this.quizCategory;
    data['quiz_sub_category'] = this.quizSubCategory;
    data['no_of_marks'] = this.noOfMarks;
    data['is_scheduled'] = this.isScheduled;
    data['quiz_title'] = this.quizTitle;
    data['quiz_description'] = this.quizDescription;
    data['quiz_duration'] = this.quizDuration;
    data['quiz_schedule'] = this.quizSchedule;
    data['amount'] = this.amount;
    data['price_money'] = this.priceMoney;
    data['image'] = this.image;
    data['is_free'] = this.isFree;
    data['is_live'] = this.isLive;
    data['difficulty_level'] = this.difficultyLevel;
    data['number_of_questions'] = this.numberOfQuestions;
    data['quiz_type'] = this.quizType;
    data['created_by'] = this.createdBy;
    data['quiz_category_id'] = this.quizCategoryId;
    data['quiz_sub_category_id'] = this.quizSubCategoryId;
    return data;
  }
}
