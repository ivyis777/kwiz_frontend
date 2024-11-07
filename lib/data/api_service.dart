import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:Kwiz/core/storage_manager/local_storage_constants.dart';
import 'package:Kwiz/data/app_url.dart';
import 'package:Kwiz/data/models/QuizSubscription.dart';
import 'package:Kwiz/data/models/Subscribed_quizes.dart';
import 'package:Kwiz/data/models/TypesOfCategeries.dart';
import 'package:Kwiz/data/models/Unsubscribe_model.dart';
import 'package:Kwiz/data/models/categaries_model.dart';
import 'package:Kwiz/data/models/completed_quiz_model.dart';
import 'package:Kwiz/data/models/couponcode_model.dart';
import 'package:Kwiz/data/models/creator_quiz_model.dart';
import 'package:Kwiz/data/models/latestQuialist_model.dart';
import 'package:Kwiz/data/models/latestquiz_model.dart';
import 'package:Kwiz/data/models/leaderboardall_model.dart';
import 'package:Kwiz/data/models/login_model.dart';
import 'package:Kwiz/data/models/loginotp_model.dart';
import 'package:Kwiz/data/models/otp_model.dart';
import 'package:Kwiz/data/models/payfromwallet_model.dart';
import 'package:Kwiz/data/models/profile_model.dart';
import 'package:Kwiz/data/models/promotion_model.dart';
import 'package:Kwiz/data/models/promotioncardlist_model.dart';
import 'package:Kwiz/data/models/promotionsecond_model.dart';
import 'package:Kwiz/data/models/question_models.dart';
import 'package:Kwiz/data/models/quiz_give.dart';
import 'package:Kwiz/data/models/quiz_result_model.dart';
import 'package:Kwiz/data/models/quiz_submit_model.dart';
import 'package:Kwiz/data/models/quiz_take.dart';
import 'package:Kwiz/data/models/quiz_take_mata.dart';
import 'package:Kwiz/data/models/quiznotifications.dart';
import 'package:Kwiz/data/models/quizzeslist_model.dart';
import 'package:Kwiz/data/models/resendotp_model.dart';
import 'package:Kwiz/data/models/search_model.dart';
import 'package:Kwiz/data/models/signup_models.dart';
import 'package:Kwiz/data/models/subcategaries_model.dart';
import 'package:Kwiz/data/models/subscribequizes_model.dart';
import 'package:Kwiz/data/models/unsubsribelist_model.dart';
import 'package:Kwiz/data/models/upcomingquiz.dart';
import 'package:Kwiz/data/models/user_details.dart';
import 'package:Kwiz/data/models/wallet_balance_model.dart';
import 'package:Kwiz/data/models/wallet_transfer_model.dart';
import 'package:Kwiz/data/models/weeklyleader_model.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as path;
import 'package:get_storage/get_storage.dart';

import 'package:http/http.dart' as http;

import 'models/live_quizes_Model.dart';
import 'models/quiz_recent_class.dart';



class ApiService {
  
  static Future<LoginModel?> loginAPI({
    required String email,
    required String otp,
    required bool through_google,
  }) async {
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({"email": email, "otp": otp, "through_google": through_google.toString()});
    print(body);

    var response = await http.post(Uri.parse(AppUrl.loginURL), body: body, headers: headers);
 var json = jsonDecode(response.body);
    if (response.statusCode == 200) {
     print('Request: ${response.body}');
      
      return LoginModel.fromJson(json);
    }else{
      return LoginModel.fromJson(json);
      
    }
  }

static Future<OtpModel> OtpApi({
  required String username,
  required String mobile,
  required String email,

  
}) async {
  var headers = {'Content-Type': 'application/json'};
  var body = jsonEncode(
    {
      // "username": '$username',
      // "password": "$password",
      "email": "$email"
    }
  );

  print('Request Body: $body');

  var response = await http.post(
    Uri.parse(AppUrl.otpURL),
    body: body,
    headers: headers,
  );

  print('Request: ${response.body}');

  var json = jsonDecode(response.body);
  if (response.statusCode == "200") {
    return OtpModel.fromJson(json);
  } else {
    return OtpModel.fromJson(json);
  }
}

static Future<LoginOtp> LoginotpURL({
  required String email,
}) async {
  var headers = {'Content-Type': 'application/json'};
  var body = jsonEncode(
    {
      "email": "$email"
    }
  );
  print('Request Body: $body');

  var response = await http.post(
    Uri.parse(AppUrl.LoginotpURL),
    body: body,
    headers: headers,
  );
  print('Request: $response');
  var json = jsonDecode(response.body);
  if (response.statusCode == 200) {
    
    return LoginOtp.fromJson(json);
    
  } else {
    return LoginOtp.fromJson(json);
  }
}

static Future<ResendOtp>ResendotpURL({
 
  required String email,

  
}) async {
  var headers = {'Content-Type': 'application/json'};
  var body = jsonEncode(
    {
     
      "email": "$email"
    }
  );

  print('Request Body: $body');

  var response = await http.post(
    Uri.parse(AppUrl.ResendotpURL),
    body: body,
    headers: headers,
  );

  print('Request: ${response.body}');

  var json = jsonDecode(response.body);
  if (response.statusCode == "200") {
    return ResendOtp.fromJson(json);
  } else {
    return ResendOtp.fromJson(json);
  }
}


static Future<SignupModel> signupApi({
  required String username,
  required String mobile,
  required String email,
  required String otp,
  required String fcmToken, 
}) async {
  var headers = {'Content-Type': 'application/json'};
  var body = jsonEncode(
    {
      "username": '$username',
      "mobile": "$mobile",
      "email": "$email",
      "otp"  : "$otp",
      "fcm_token" : "$fcmToken", 
    }
  );

  print('Request Body: $body');

  var response = await http.post(
    Uri.parse(AppUrl.signUpURL),
    body: body,
    headers: headers,
  );

   print('Request: ${response.body}');

  var json = jsonDecode(response.body);
  if (response.statusCode == 200) {
    return SignupModel.fromJson(json);
  } else {
    return SignupModel.fromJson(json);
  }
}
static Future<List<QuizGetClass>> quizGetAPI() async {
    final box = GetStorage();
     var fetchedID = box.read(LocalStorageConstants.userId).toString();
    var fetchedToken = box.read(LocalStorageConstants.token);  // Retrieve token from storage
    print('Fetched Token: $fetchedToken');  // Debug line to verify token

    var headers = {
      "Authorization": "Bearer $fetchedToken",  // Ensure correct format
      'Content-Type': 'application/json'
    };

    var response = await http.get(Uri.parse(AppUrl.quizGet + "${fetchedID}/"), headers: headers);
    print('Response: ${response.body}');
    
    if (response.statusCode == 200) {
      Iterable list = jsonDecode(response.body);
      return list.map((model) => QuizGetClass.fromJson(model)).toList();
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      return [];
    }}
  
 static Future<QuizRecentClass> QuizRecentapi({
    required String user_id,
  }) async {
    final box = GetStorage();
    final fetchedToken = box.read(LocalStorageConstants.token);
     print('Fetched Token: $fetchedToken'); 
    final headers = {
      "Authorization": "jwt $fetchedToken",
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      "user_id": user_id,
    });

    try {
      final response = await http.post(
        Uri.parse(AppUrl.quizRecentQuiz),
        headers: headers,
        body: body,
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return QuizRecentClass.fromJson(json);
      } else {
        throw Exception('Error: ${response.statusCode} - ${jsonDecode(response.body)['error'] ?? 'Unknown error'}');
      }
    } catch (e) {
      print('Request failed: $e');
      throw Exception('Error: $e');
    }
  }



static Future<UpcomingKwiizzesModel> upcomingKwizzesAPI() async {
  final  box = GetStorage();
    var fetchedtoken = box.read(LocalStorageConstants.token);
       var headers = {
    "Authorization": "Bearer $fetchedtoken",
    'Content-Type': 'application/json'
  };
  var response = await http.get(Uri.parse(AppUrl.upcomingKwiizzesURL), headers: headers  );
  var json = jsonDecode(response.body);
  print(response.body);
    if (response.statusCode == 200) {
      return UpcomingKwiizzesModel.fromJson(json);
    } else {
      return UpcomingKwiizzesModel.fromJson(json);
    }
  }

  static Future<LatestKwiizzesModel > LatestKwiizzesAPI() async {
  final  box = GetStorage();
    var fetchedtoken = box.read(LocalStorageConstants.token);
        var headers = {
    "Authorization": "Bearer $fetchedtoken",
    'Content-Type': 'application/json'
  };
  var response = await http.get(Uri.parse(AppUrl.LatestQuizURL), headers: headers);
  var json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return LatestKwiizzesModel .fromJson(json);
    } else {
      return LatestKwiizzesModel .fromJson(json);
    }
  }

  static Future<SubscribtionsKwizzesModel> SubscribedKwiizzesAPI() async {
 final  box = GetStorage();
    var fetchedtoken = box.read(LocalStorageConstants.token);
       var headers = {
    "Authorization": "Bearer $fetchedtoken",
    'Content-Type': 'application/json'
  };
  var response = await http.get(Uri.parse(AppUrl.SubscriptionKwizzeURL), headers: headers);
  var json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return SubscribtionsKwizzesModel.fromJson(json);
    } else {
      return SubscribtionsKwizzesModel.fromJson(json);
    }
  }



 static Future<ProfileModel> profileApi({
  required BuildContext context,
  required String user_id,
  required String name,
  required String gender,
  required String age,
  required String email,
  required String mobile,
  required String address,
  required String city,
  required String country,
  required String state,
  required String pincode,
  
  
}) async {
  var uri = Uri.parse(AppUrl.profileURL,);
  var request = http.MultipartRequest('POST', uri);
   final  box = GetStorage();
   
    var fetchedtoken = box.read(LocalStorageConstants.token);
       var headers = {
    "Authorization": "Bearer $fetchedtoken",
    'Content-Type': 'application/json'
  };
 request.headers.addAll(headers);

  request.fields.addAll({
    'data': '{\n    "name": "$name",\n    "gender": "$gender",\n  "age": "$age",\n   "email": "$email",\n    "mobile": "$mobile",\n    "address": "$address",\n    "city": "$city",\n    "country": "$country",\n    "state": "$state",\n    "pincode": $pincode,\n    "user_id":$user_id\n}'
  });

 
  var response = await request.send();
  print(response);

  if (response.statusCode == 200) {
    var responseBody = await response.stream.bytesToString();
    var jsonData = jsonDecode(responseBody);
    print('Decoded JSON: $jsonData');
    return ProfileModel.fromJson(jsonData);
  } else {
    var responseBody = await response.stream.bytesToString();
    print('Error Body: $responseBody');
    throw Exception('Failed to update profile: ${response.reasonPhrase}');
  }
}


 static Future<UserDetailsModel> userDetailsURL() async {
    
    final  box = GetStorage();
     var fetchedID = box.read(LocalStorageConstants.userId).toString();
   
    var fetchedtoken = box.read(LocalStorageConstants.token);
        var headers = {
    "Authorization": "Bearer $fetchedtoken",
    'Content-Type': 'application/json'
  };

    var response =
        await http.get(Uri.parse(AppUrl.userDetailURL + '${fetchedID}/'), headers: headers);
    var json = jsonDecode(response.body);
    if (response.statusCode == 200) {
print(response);
      return UserDetailsModel.fromJson(json);
    } else {
      return UserDetailsModel.fromJson(json);
    }
    
  }
  // partial save response ki
  static Future<QuizRecentClass> partialQuizData(String quizTakeID) async {
  final  box = GetStorage();
    var fetchedtoken = box.read(LocalStorageConstants.token);
     var headers = {
    "Authorization": "Bearer $fetchedtoken",
    'Content-Type': 'application/json'
  };
    var body = jsonEncode({"quiz_take_id": '$quizTakeID'});
    var response = await http.post(Uri.parse(AppUrl.partialQuizData,),
        headers: headers, body: body);
    var json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return QuizRecentClass.fromJson(json);
    } else {
      return QuizRecentClass.fromJson(json);
    }
  }

  //1
  static Future<QuizTakeMeta> quizTakeMeta(
      {required String user_id,
        required String quiz_id,
        required String status}) async {
   final  box = GetStorage();
    var fetchedtoken = box.read(LocalStorageConstants.token);
       var headers = {
    "Authorization": "Bearer $fetchedtoken",
    'Content-Type': 'application/json'
  };
    var body = jsonEncode({
      "user_id": "$user_id",
      "quiz_id": "$quiz_id",
      "status": "$status",
    });
    var response = await http.post(Uri.parse(AppUrl.quizTakeMeta),
        headers: headers, body: body);
    var json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return QuizTakeMeta.fromJson(json);
    } else {
      return QuizTakeMeta.fromJson(json);
    }
  }


  // {
  // "user_id":147,
  // "quiz_take_id": 16,
  // "quiz_id":22,
  // "ques_id":79,
  // "ans_id":["303","304"]
  // }

  //2
 static Future<QuizTake> questionSave(
    {
      required String quiz_take_id,
    required String user_id,
    required String quiz_id,
    required String ques_id,
    required List<dynamic> ans_id}) async {
    final  box = GetStorage();
    var fetchedtoken = box.read(LocalStorageConstants.token);
       var headers = {
    "Authorization": "Bearer $fetchedtoken",
    'Content-Type': 'application/json'
  };
  var body = jsonEncode({
    "quiz_take_id": quiz_take_id,
    "user_id": user_id,
    "quiz_id": quiz_id,
    "ques_id": ques_id,
    "ans_id": ans_id,
  });
  var response = await http.post(Uri.parse(AppUrl.quizTake,),
      headers: headers, body: body);
  var json = jsonDecode(response.body);
  if (response.statusCode == 200) {
    return QuizTake.fromJson(json);
  } else {
    return QuizTake.fromJson(json);
  }
}



  

  Future<List<QuestionClass>> questionAPI() async {
final  box = GetStorage();
    var fetchedtoken = box.read(LocalStorageConstants.token);
       var headers = {
    "Authorization": "Bearer $fetchedtoken",
    'Content-Type': 'application/json'
  };

    // Sending a GET request to the specified URL
    var response =
        await http.get(Uri.parse(AppUrl.questionURL), headers: headers);

    if (response.statusCode == 200) {
      // Parsing the JSON response
      var json = jsonDecode(response.body);
      print('iam in api_service : var json $json');

      // Extracting the 'Basic', 'Question', and 'Answer' lists
      var basicList = json['Basic'] as List?;
      var questionList = json['Question'] as List?;
      var answerList = json['Answer'] as List?;

      print('iam in api_service : var basicList $basicList');
      print('iam in api_service : var questionList $questionList');
      print('iam in api_service : var answerList $answerList');

      // Checking if the lists are not null and are lists
      if (basicList != null && questionList != null && answerList != null) {
        // Determine the maximum length among all lists
        int maxLength = [
          basicList.length,
          questionList.length,
          answerList.length,
        ].reduce((value, element) => value > element ? value : element);

        List<QuestionClass> resultList = [];
        // Loop through the maximum length
        for (var i = 0; i < maxLength; i++) {
          var basic =
              i < basicList.length ? Basic.fromJson(basicList[i]) : Basic();
          var question = i < questionList.length
              ? Question.fromJson(questionList[i])
              : Question();
          var answer =
              i < answerList.length ? Answer.fromJson(answerList[i]) : Answer();

          // Add the QuestionClass object to the resultList
          resultList.add(QuestionClass(
              basic: [basic], question: [question], answer: [answer]));
        }
        return resultList;
      } else {
        print('No data found');
        // Returning an empty list as there is no data
        return [];
      }
    } else {
      // Returning an empty list if the request fails
      print('Request failed with status: ${response.statusCode}');
      return [];
    }
  }

  static Future<QuizGive> quizGiveAPI({
    required String quiz_id,
    required String user_id
  }) async {
    final  box = GetStorage();
    var fetchedtoken = box.read(LocalStorageConstants.token);
       var headers = {
    "Authorization": "Bearer $fetchedtoken",
    'Content-Type': 'application/json'
  };
    var body = jsonEncode({"quiz_id": '$quiz_id', "user_id": user_id,});

    var response = await http.post(Uri.parse(AppUrl.quizGive),
        body: body, headers: headers);

    if (response.statusCode == 200) {
      var d = jsonDecode(response.body);
      return QuizGive.fromJson(d);
    } else {
      var d = jsonDecode(response.body);
      return QuizGive.fromJson(d);
    }
  }
 static Future<WalletBalanceModel> walletBalanceApi({
    required String user_id,
  }) async {
      final  box = GetStorage();
    var fetchedtoken = box.read(LocalStorageConstants.token);
       var headers = {
    "Authorization": "Bearer $fetchedtoken",
    'Content-Type': 'application/json'
  };
    var body = jsonEncode({"user_id": "$user_id"});

    try {
      var response = await http.post(Uri.parse(AppUrl.walletbalanceURL),
          body: body, headers: headers);

      if (response.statusCode == 200) {
        var d = jsonDecode(response.body);
        return WalletBalanceModel.fromJson(d);
      } else {
        // If the response status code is not 200, throw an exception
        throw Exception('Failed to fetch wallet balance');
      }
    } catch (e) {
      // Catch any exceptions and handle them
      throw Exception('Failed to fetch wallet balance: $e');
    }
  }
static Future<WalletTransferModel> walletTransferApi({
  required String user_id,
  required String to_email,
  required double amount,
}) async {
    final  box = GetStorage();
    var fetchedtoken = box.read(LocalStorageConstants.token);
       var headers = {
    "Authorization": "Bearer $fetchedtoken",
    'Content-Type': 'application/json'
  };
  var body = jsonEncode({"user_id": user_id, "to_email": to_email, "amount": amount});

  try {
    var response = await http.post(Uri.parse(AppUrl.walletTransferURL), body: body, headers: headers);

    var responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return WalletTransferModel.fromJson(responseData);
    } else if (response.statusCode == 402) {
      throw Exception('${responseData['error'] ?? 'Recipient wallet not found'}');
    } else {
      throw Exception('Status ${response.statusCode}: ${responseData['error'] ?? 'Unexpected error occurred'}');
    }
  } catch (e) {
    throw Exception('Error: ${e.toString()}');
  }
}


 static Future<QuizSubmit> quizsubmitapi(
    {required String quiz_take_id,
    required String user_id,
    required String quiz_id,
    required String ques_id,
    required List<dynamic> ans_id
    }) async {
    final  box = GetStorage();
    var fetchedtoken = box.read(LocalStorageConstants.token);
       var headers = {
    "Authorization": "Bearer $fetchedtoken",
    'Content-Type': 'application/json'
  };
  var body = jsonEncode({
    "quiz_take_id": quiz_take_id,
    "user_id": user_id,
    "quiz_id": quiz_id,
    "ques_id": ques_id,
    "ans_id": ans_id,
  });
  var response = await http.post(Uri.parse(AppUrl.QuizSubmitURL),
      headers: headers, body: body);
  var json = jsonDecode(response.body);
  if (response.statusCode == 200) {
      print('Response from backend: ${response.body}');
    return QuizSubmit.fromJson(json);
  } else {
    return QuizSubmit.fromJson(json);
  }
}  

static Future<PayWalletModel> PayWalletapi({
  required String user_id,
  required String quiz_id,
  required double amount,
  required String coupon_code,
  required bool coupon_applied,
  required double amount_deducted,


}) async {
  final  box = GetStorage();
    var fetchedtoken = box.read(LocalStorageConstants.token);
       var headers = {
    "Authorization": "Bearer $fetchedtoken",
    'Content-Type': 'application/json'
  };
  var body = jsonEncode({
    "user_id": user_id,
    "quiz_id": quiz_id,
    "amount": amount,
    "coupon_code" : coupon_code,
    "coupon_applied": coupon_applied,
    "amount_deducted":amount_deducted,   
    
  });
  var response = await http.post(Uri.parse(AppUrl.PayFRomWalletURL),
      headers: headers, body: body);

  var json = jsonDecode(response.body);
  print('Response from backend: ${response.body}');

  if (response.statusCode == 200) {
    return PayWalletModel.fromJson(json);
  } else {
    return PayWalletModel.fromJson(json);
  }
}


static Future<QuizSubscriptionModel> QuizSubscriptionapi({
  required String user_id,
  required String quiz_id,


}) async {
   final  box = GetStorage();
    var fetchedtoken = box.read(LocalStorageConstants.token);
       var headers = {
    "Authorization": "Bearer $fetchedtoken",
    'Content-Type': 'application/json'
  };
  var body = jsonEncode({
    "user_id": user_id,
    "quiz_id": quiz_id,
   
    
 
  });

  var response = await http.post(Uri.parse(AppUrl.QuizSubscriptionURL),
      headers: headers, body: body);
  
  var json = jsonDecode(response.body);
  
  // Print the response body from backend
  print('Response from backend: ${response.body}');

  if (response.statusCode == 200) {
    return QuizSubscriptionModel.fromJson(json);
  } else {
    // Optionally, you might want to handle different status codes here
    return QuizSubscriptionModel.fromJson(json);
  }
}
 static Future<QuizResultModel> QuizResultapi({
    required String quiz_take_id,
    required String user_id,
    required bool isSubmit
    
  }) async {
   final  box = GetStorage();
    var fetchedtoken = box.read(LocalStorageConstants.token);
       var headers = {
    "Authorization": "Bearer $fetchedtoken",
    'Content-Type': 'application/json'
  };
    var body = jsonEncode({
      "quiz_take_id": quiz_take_id,
      "user_id": user_id,
      "isSubmit":isSubmit
      // end_time: end_time.toIso8601String(),
    });

    var response = await http.post(Uri.parse(AppUrl.QuizResultURL),
        headers: headers, body: body);
    
    var json = jsonDecode(response.body);
    
    // Print the response body from backend
    print('Response from backend: ${response.body}');

    if (response.statusCode == 200) {
      return QuizResultModel.fromJson(json);
    } else {
      // Optionally, you might want to handle different status codes here
      return QuizResultModel.fromJson(json);
    }
  }

  
static Future<SubscribedQuizModel> SubscriptedQuizapi({
  required String user_id,

}) async {
    final  box = GetStorage();
    var fetchedtoken = box.read(LocalStorageConstants.token);
       var headers = {
    "Authorization": "Bearer $fetchedtoken",
    'Content-Type': 'application/json'
  };
  var body = jsonEncode({
    "user_id": user_id,
  });

  var response = await http.post(Uri.parse(AppUrl.SubscribedQuizURL),
      headers: headers, body: body);
  
  var json = jsonDecode(response.body);
  print('Response from backend: ${response.body}');

  if (response.statusCode == 200) {
    return SubscribedQuizModel.fromJson(json);
  } else {
    return SubscribedQuizModel.fromJson(json);
  }
}
static Future<CompletedQuizModel> CompletedQuizapi({
  required String user_id,

}) async {
   final  box = GetStorage();
    var fetchedtoken = box.read(LocalStorageConstants.token);
       var headers = {
    "Authorization": "Bearer $fetchedtoken",
    'Content-Type': 'application/json'
  };
  var body = jsonEncode({
    "user_id": user_id,
  });

  var response = await http.post(Uri.parse(AppUrl.CompletedQuizURL),
      headers: headers, body: body);
  
  var json = jsonDecode(response.body);
  
  // Print the response body from backend
  print('Response from backend: ${response.body}');

  if (response.statusCode == 200) {
    return CompletedQuizModel.fromJson(json);
  } else {
    // Optionally, you might want to handle different status codes here
    return CompletedQuizModel.fromJson(json);
  }

  
}
static Future<UnsubscribeModel> Unsubscribedapi({
  required String user_id,
  required String quiz_id
}) async {
    final  box = GetStorage();
    var fetchedtoken = box.read(LocalStorageConstants.token);
       var headers = {
    "Authorization": "Bearer $fetchedtoken",
    'Content-Type': 'application/json'
  };
  var body = jsonEncode({
    "user_id": user_id,
     "quiz_id": quiz_id,
  });
  var response = await http.delete(Uri.parse(AppUrl.UnsubscribeURL),
      headers: headers, body: body);
  var json = jsonDecode(response.body);
  // Print the response body from backend
  print('Response from backend: ${response.body}');
  if (response.statusCode == 200) {
    return UnsubscribeModel.fromJson(json);
  } else {
    // Optionally, you might want to handle different status codes here
    return UnsubscribeModel.fromJson(json);
  }  
}
static Future<CreatorQuizModel> CreatorQuizapi({
  required String user_id,
  
}) async {
  final  box = GetStorage();
    var fetchedtoken = box.read(LocalStorageConstants.token);
       var headers = {
    "Authorization": "Bearer $fetchedtoken",
    'Content-Type': 'application/json'
  };
  var body = jsonEncode({
    "user_id": user_id,
  });
  var response = await http.post(Uri.parse(AppUrl.CreatorQuizURL),
      headers: headers, body: body);
  var json = jsonDecode(response.body);
  // Print the response body from backend
  print('Response from backend: ${response.body}');
  if (response.statusCode == 200) {
    return CreatorQuizModel.fromJson(json);
  } else {
    // Optionally, you might want to handle different status codes here
    return CreatorQuizModel.fromJson(json);
  }
}  

static Future<List<QuizNotificationsModel>> QuizNotificationsAPI() async {
   final  box = GetStorage();
     var fetchedID = box.read(LocalStorageConstants.userId).toString();

    var fetchedtoken = box.read(LocalStorageConstants.token);
       var headers = {
    "Authorization": "Bearer $fetchedtoken",
    'Content-Type': 'application/json'
  };
  var response = await http.get(Uri.parse(AppUrl.QuizNotifications+'${fetchedID}/'), headers: headers);
  print(response);
  var json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Iterable list = jsonDecode(response.body);
      print(response.body);
      return list.map((model) => QuizNotificationsModel.fromJson(model)).toList();
    } else {
      return [];
    }
  }
  
 static Future<List<TypesOfCategariesModel>> TypeCatGetAPI() async {
    final box = GetStorage();
    final fetchedToken = box.read(LocalStorageConstants.token);

    final headers = {
      "Authorization": "Bearer $fetchedToken",
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(
        Uri.parse(AppUrl.TypesOfCatURL),
        headers: headers,
      );

      if (response.statusCode == 200) {
        print('Response body: ${response.body}');
        final List<dynamic> json = jsonDecode(response.body);

        // Convert the list of JSON objects to a list of model objects
        return json
            .map((model) => TypesOfCategariesModel.fromJson(model))
            .toList();
      } else {
        print('Error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Request failed: $e');
      return [];
    }
  }

  static Future<List<CategariesModel>> CatagariesGetAPI(int quizTypeId) async {
   final  box = GetStorage();
    var fetchedtoken = box.read(LocalStorageConstants.token);
       var headers = {
    "Authorization": "Bearer $fetchedtoken",
    'Content-Type': 'application/json'
  };
  var url = '${AppUrl.CategariesURL}$quizTypeId/';
  print('Requesting URL: $url');
    final response = await http.get(Uri.parse(url));
  try {

    var response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      List<CategariesModel> categoriesList = jsonList.map((model) => CategariesModel.fromJson(model)).toList();
      return categoriesList;
    } else {
      print('Failed to load categories: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('Error loading categories: $e');
    return [];
  }
}


 static Future<List<SubCategariesModel>> SubCatagariesGetAPI(int  quizCategoryId) async {
  final  box = GetStorage();
    var fetchedtoken = box.read(LocalStorageConstants.token);
       var headers = {
    "Authorization": "Bearer $fetchedtoken",
    'Content-Type': 'application/json'
  };
  var url = '${AppUrl.SubCategariesURL}$quizCategoryId/';
  print('Requesting URL: $url');
    final response = await http.get(Uri.parse(url));
  try {

    var response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      List<SubCategariesModel> SubcategoriesList = jsonList.map((model) => SubCategariesModel.fromJson(model)).toList();
      return SubcategoriesList;
    } else {
      print('Failed to load categories: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('Error loading categories: $e');
    return [];
  }
}
static Future<List<QuizzesListModel>> QuizzesListGetAPI(int quizSubCategoryId) async {
  final box = GetStorage();
   var fetchedID = box.read(LocalStorageConstants.userId).toString();
  var fetchedtoken = box.read(LocalStorageConstants.token);
       var headers = {
    "Authorization": "Bearer $fetchedtoken",
    'Content-Type': 'application/json'
  };
  var url = '${AppUrl.QuizListURL}$quizSubCategoryId/$fetchedID';
  print('Requesting URL: $url');
    final response = await http.get(Uri.parse(url));
  try {

    var response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      List<QuizzesListModel> QuizList = jsonList.map((model) => QuizzesListModel.fromJson(model)).toList();
      return QuizList;
    } else {
      print('Failed to load categories: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('Error loading categories: $e');
    return [];
  }
}
 

Future<List<SearchModel>> searchQuizzes({
  String? query,
  String? category,
  String? subCategory,
}) async {
  final box = GetStorage();
  var fetchedtoken = box.read(LocalStorageConstants.token);
  
  var headers = {
    "Authorization": "Bearer $fetchedtoken",
    'Content-Type': 'application/json',
  };

  final response = await http.get(
    Uri.parse('${AppUrl.SearchPageURL}?query=$query&category=$category&subCategory=$subCategory'),
    headers: headers,
  );

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((item) => SearchModel.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load quizzes');
  }
}


  Future<List<SearchModel>> fetchQuizzes() async {
     final box = GetStorage();
     var fetchedtoken = box.read(LocalStorageConstants.token);
       var headers = {
    "Authorization": "Bearer $fetchedtoken",
    'Content-Type': 'application/json'
  };
  final response = await http.get(Uri.parse(AppUrl.SearchPageURL), headers: headers,);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => SearchModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load quizzes');
    }
  }

   static Future<LeaderBoardAllModel> LeaderBoardAll({required String quiz_id}) async {
     final box = GetStorage();
     var fetchedtoken = box.read(LocalStorageConstants.token);
       var headers = {
    "Authorization": "Bearer $fetchedtoken",
    'Content-Type': 'application/json'
  };
    var body = jsonEncode({"quiz_id": quiz_id});
    
    var response = await http.post(Uri.parse(AppUrl.LeaderBoardAllURL), headers: headers, body: body);
    var json = jsonDecode(response.body);
    
    if (response.statusCode == 200) {
      return LeaderBoardAllModel.fromJson(json);
    } else {
      
      throw Exception('Failed to load leaderboard data');
    }
  }
  static Future<weeklyLeaderBoardModel> WeeklyLeaderBoard({required String user_id }) async {
    final box = GetStorage();
     var fetchedtoken = box.read(LocalStorageConstants.token);
       var headers = {
    "Authorization": "Bearer $fetchedtoken",
    'Content-Type': 'application/json'
  };
    var body = jsonEncode({ "user_id": user_id});
    
    var response = await http.post(Uri.parse(AppUrl.WeeklyLeaderBoardURL), headers: headers, body: body);
    var json = jsonDecode(response.body);
    
    if (response.statusCode == 200) {
      return weeklyLeaderBoardModel.fromJson(json);
    } else {
      
      throw Exception('Failed to load leaderboard data');
    }
  }
   static Future<List<LatestQuizListModel>> LatestQuizListApi() async {
 final box = GetStorage();
     var fetchedtoken = box.read(LocalStorageConstants.token);
       var headers = {
    "Authorization": "Bearer $fetchedtoken",
    'Content-Type': 'application/json'
  };
  var response = await http.get(Uri.parse(AppUrl.LatestquizlistURL), headers: headers);
    var json = jsonDecode(response.body);
    // print(json);
    if (response.statusCode == 200) {
      Iterable list = jsonDecode(response.body);
      print(response.body);
      return list.map((model) => LatestQuizListModel.fromJson(model)).toList();
    } else {
      return [];
    }
  
  }
static Future<UnsubscribeListModel > UnsubscribeListApi() async {
  final  box = GetStorage();
 
     var fetchedID = box.read(LocalStorageConstants.userId); 
     print(fetchedID);

     var fetchedtoken = box.read(LocalStorageConstants.token);
       var headers = {
    "Authorization": "Bearer $fetchedtoken",
    'Content-Type': 'application/json'
  };
  var response = await http.get(Uri.parse(AppUrl.UnsubscribeListURL +"${fetchedID}/"), headers: headers);
  var json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return UnsubscribeListModel .fromJson(json);
    } else {
      return UnsubscribeListModel.fromJson(json);
    }
  }
  static Future <PromotionsModel> PromotionsListApi() async {
  final box = GetStorage();
     var fetchedtoken = box.read(LocalStorageConstants.token);
       var headers = {
    "Authorization": "Bearer $fetchedtoken",
    'Content-Type': 'application/json'
  };
  var response = await http.get(Uri.parse(AppUrl.PromotionsURL), headers: headers);
  var json = jsonDecode(response.body);
    if (response.statusCode == "200") {
      return PromotionsModel .fromJson(json);
    } else {
      return PromotionsModel .fromJson(json);
    }
  }
   static Future <PromotionsecondModel> PromotionsecondListApi() async {
 final box = GetStorage();
     var fetchedtoken = box.read(LocalStorageConstants.token);
       var headers = {
    "Authorization": "Bearer $fetchedtoken",
    'Content-Type': 'application/json'
  };
  var response = await http.get(Uri.parse(AppUrl.PromotionSecondURL), headers: headers);
  var json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return PromotionsecondModel .fromJson(json);
    } else {
      return PromotionsecondModel .fromJson(json);
    }
  }
  static Future<CouponCodeModel> CouponCodeApi({
    required double amount,
    required String coupon_code,
  }) async {
   final box = GetStorage();
     var fetchedtoken = box.read(LocalStorageConstants.token);
       var headers = {
    "Authorization": "Bearer $fetchedtoken",
    'Content-Type': 'application/json'
  };
    var body = jsonEncode({
      "amount": amount,
      "coupon_code": coupon_code,
    });
    
    var response = await http.post(Uri.parse(AppUrl.CouponCodeURL), headers: headers, body: body);
    var jsonResponse = jsonDecode(response.body);
    
    print('Response from backend: ${response.body}');
    
    if (response.statusCode == 200) { 
      return CouponCodeModel.fromJson(jsonResponse);
    } else {
         return CouponCodeModel.fromJson(jsonResponse);
    }
  }
  static Future<PromotioncardlistModel> promotionCardListApi({
  required String quiz_id,
  
}) async {
  final  box = GetStorage();
    var fetchedtoken = box.read(LocalStorageConstants.token);
       var headers = {
    "Authorization": "Bearer $fetchedtoken",
    'Content-Type': 'application/json'
  };
  var body = jsonEncode({
    "quiz_id":quiz_id,
  });
  var response = await http.post(Uri.parse(AppUrl.PromotionCardListURL),
      headers: headers, body: body);
  var json = jsonDecode(response.body);
  // Print the response body from backend
  print('Response from backend: ${response.body}');
  if (response.statusCode == 200) {
    return PromotioncardlistModel.fromJson(json);
  } else {
    // Optionally, you might want to handle different status codes here
    return PromotioncardlistModel.fromJson(json);
  }
}  
}
class ApiException implements Exception {
  final int statusCode;
  final String message;

  ApiException(this.statusCode, this.message);
}






