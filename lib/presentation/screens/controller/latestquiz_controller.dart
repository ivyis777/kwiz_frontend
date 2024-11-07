import 'package:Kwiz/data/api_service.dart';
import 'package:Kwiz/data/models/latestquiz_model.dart';
import 'package:get/get.dart';



class Latestquizcontroller extends GetxController {
  var LatestquizClass = LatestKwiizzesModel().obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }
Future<void> LatestKwiizzesAPI() async {
    updateLoader(true);
    var response = await ApiService.LatestKwiizzesAPI();
    LatestquizClass.value = response;
    updateLoader(false);
  }

  updateLoader(bool loader) {
    this.isLoading.value = loader;
  }
}