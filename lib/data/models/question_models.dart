class QuestionClass {
  List<Basic>? basic;
  List<Question>? question;
  List<Answer>? answer;

  QuestionClass({this.basic, this.question, this.answer});

  QuestionClass.fromJson(Map<String, dynamic> json) {
    if (json['Basic'] != null) {
      basic = <Basic>[];
      json['Basic'].forEach((v) {
        basic!.add(new Basic.fromJson(v));
      });
    }
    if (json['Question'] != null) {
      question = <Question>[];
      json['Question'].forEach((v) {
        question!.add(new Question.fromJson(v));
      });
    }
    if (json['Answer'] != null) {
      answer = <Answer>[];
      json['Answer'].forEach((v) {
        answer!.add(new Answer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.basic != null) {
      data['Basic'] = this.basic!.map((v) => v.toJson()).toList();
    }
    if (this.question != null) {
      data['Question'] = this.question!.map((v) => v.toJson()).toList();
    }
    if (this.answer != null) {
      data['Answer'] = this.answer!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Basic {
  int? id;
  int? qid;
  String? quizCategory;
  String? quizSubCategory;
  String? quizDescription;
  int? quizDuration;
  String? difficultyLevel;
  String? quizTitle;

  Basic(
      {this.id,
      this.qid,
      this.quizCategory,
      this.quizSubCategory,
      this.quizDescription,
      this.quizDuration,
      this.difficultyLevel,
      this.quizTitle});

  Basic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    qid = json['qid'];
    quizCategory = json['quiz_category'];
    quizSubCategory = json['quiz_sub_category'];
    quizDescription = json['quiz_description'];
    quizDuration = json['quiz_duration'];
    difficultyLevel = json['difficulty_level'];
    quizTitle = json['quiz_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['qid'] = this.qid;
    data['quiz_category'] = this.quizCategory;
    data['quiz_sub_category'] = this.quizSubCategory;
    data['quiz_description'] = this.quizDescription;
    data['quiz_duration'] = this.quizDuration;
    data['difficulty_level'] = this.difficultyLevel;
    data['quiz_title'] = this.quizTitle;
    return data;
  }
}

class Question {
  int? id;
  int? quizId;
  int? quesId;
  String? quesType;
  String? quesTitle;

  Question({this.id, this.quizId, this.quesId, this.quesType, this.quesTitle});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quizId = json['quiz_id'];
    quesId = json['ques_id'];
    quesType = json['ques_type'];
    quesTitle = json['ques_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quiz_id'] = this.quizId;
    data['ques_id'] = this.quesId;
    data['ques_type'] = this.quesType;
    data['ques_title'] = this.quesTitle;
    return data;
  }
}

class Answer {
  int? id;
  int? quizId;
  int? quesId;
  String? options;
  bool? isRight;

  Answer({this.id, this.quizId, this.quesId, this.options, this.isRight});

  Answer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quizId = json['quiz_id'];
    quesId = json['ques_id'];
    options = json['options'];
    isRight = json['is_right'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quiz_id'] = this.quizId;
    data['ques_id'] = this.quesId;
    data['options'] = this.options;
    data['is_right'] = this.isRight;
    return data;
  }
}
