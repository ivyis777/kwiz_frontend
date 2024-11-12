
import 'package:RiddleQing/data/api_service.dart';
import 'package:RiddleQing/data/models/upcomingquiz.dart';
import 'package:get/get.dart';

class upcomingKwiizzesController extends GetxController {
  var upcomingKwizzesClass = UpcomingKwiizzesModel().obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }
  Future<void> upcomingKwizzesAPI() async {
    updateLoader(true);
    var response = await ApiService.upcomingKwizzesAPI();
    upcomingKwizzesClass.value = response;
    updateLoader(false);
  }

  updateLoader(bool loader) {
    this.isLoading.value = loader;
  }
}
