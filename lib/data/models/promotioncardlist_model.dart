import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

class PromotioncardlistModel {
  Data? data;
  String? status;

  PromotioncardlistModel({this.data, this.status});

  PromotioncardlistModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    if (data != null) {
      json['data'] = data!.toJson(); 
    }
    json['status'] = status;
    return json;
  }
}

class Data {
  String? quizId;
  bool? isSubscribed;
  bool? isCreator;
  String? quizCategory;
  String? quizSubCategory;
  int? noOfMarks;
  bool? isScheduled;
  String? quizTitle;
  String? quizDescription;
  int? quizDuration;  // Changed to int
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

  Data({
    this.quizId,
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
    this.quizSubCategoryId,
  });

  Data.fromJson(Map<String, dynamic> json) {
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
    amount = (json['amount'] as num).toDouble(); // Ensure correct conversion
    priceMoney = (json['price_money'] as num).toDouble(); // Ensure correct conversion
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
    data['quiz_id'] = quizId;
    data['is_subscribed'] = isSubscribed;
    data['is_creator'] = isCreator;
    data['quiz_category'] = quizCategory;
    data['quiz_sub_category'] = quizSubCategory;
    data['no_of_marks'] = noOfMarks;
    data['is_scheduled'] = isScheduled;
    data['quiz_title'] = quizTitle;
    data['quiz_description'] = quizDescription;
    data['quiz_duration'] = quizDuration; 
    data['quiz_schedule'] = quizSchedule?.toIso8601String();
    data['amount'] = amount;
    data['price_money'] = priceMoney;
    data['image'] = image;
    data['is_free'] = isFree;
    data['is_live'] = isLive;
    data['difficulty_level'] = difficultyLevel;
    data['number_of_questions'] = numberOfQuestions;
    data['quiz_type'] = quizType;
    data['created_by'] = createdBy;
    data['quiz_category_id'] = quizCategoryId;
    data['quiz_sub_category_id'] = quizSubCategoryId;
    return data;
  }
}
