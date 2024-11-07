import 'package:Kwiz/data/api_service.dart';
import 'package:Kwiz/data/models/latestQuialist_model.dart';
import 'package:get/get.dart';



class LatestquizlistController extends GetxController {
  var latestquizGetList = <LatestQuizListModel>[].obs;
  var isLoading = false.obs;

  void updateLoader(bool loader) {
    this.isLoading.value = loader;
  }

  Future<void> latestquizgetQuiz() async {
    updateLoader(true);
    final response = await ApiService.LatestQuizListApi();
    this.latestquizGetList.value = response;
    updateLoader(false);
  }
}