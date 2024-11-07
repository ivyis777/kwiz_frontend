import 'package:Kwiz/data/api_service.dart';
import 'package:Kwiz/data/models/quiznotifications.dart';
import 'package:get/get.dart';
 

class QuiznotificationsController extends GetxController {
  
  var notificationClass = <QuizNotificationsModel>[].obs;
  var isLoading = false.obs;
  Future<void> quizNotifications() async {
    try {
      updateLoader(true);
      var response = await ApiService.QuizNotificationsAPI();
      notificationClass.value = response;
      updateLoader(false);
    } catch (e) {
      print('Error fetching quiz notifications: $e');
     
    }
  }
 
  void updateLoader(bool loader) {
    isLoading.value = loader;
  }
}
