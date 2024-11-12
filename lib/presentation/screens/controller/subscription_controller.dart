
import 'package:RiddleQing/data/api_service.dart';
import 'package:RiddleQing/data/models/subscribequizes_model.dart';
import 'package:get/get.dart';


class SubscriptionKwizzescontroller extends GetxController {
  var SubscribedkwizzesClass = SubscribtionsKwizzesModel().obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }
Future<void> SubscribedKwiizzesAPI() async {
    updateLoader(true);
    var response = await ApiService.SubscribedKwiizzesAPI();
    SubscribedkwizzesClass.value = response;
    updateLoader(false);
  }

  updateLoader(bool loader) {
    this.isLoading.value = loader;
  }
}