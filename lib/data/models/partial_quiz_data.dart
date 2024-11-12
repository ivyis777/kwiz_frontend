



import 'package:RiddleQing/data/models/quiz_data.dart';

class PartialQuizData {
  List<QuizData>? quizData;
  String? status;

  PartialQuizData({this.quizData, this.status});

  PartialQuizData.fromJson(Map<String, dynamic> json) {
    if (json['quiz data'] != null) {
      quizData = <QuizData>[];
      json['quiz data'].forEach((v) {
        quizData!.add(new QuizData.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.quizData != null) {
      data['quiz data'] = this.quizData!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}


