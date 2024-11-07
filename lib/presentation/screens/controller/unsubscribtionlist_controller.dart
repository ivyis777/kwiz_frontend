import 'package:Kwiz/data/api_service.dart';
import 'package:Kwiz/data/models/unsubsribelist_model.dart';
import 'package:get/get.dart';



class UnsubscribtionlistController extends GetxController {
  var unsubscriptionListClass = UnsubscribeListModel().obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }
  Future<void> UnsubscribeListApi() async {
    updateLoader(true);
    var response = await ApiService.UnsubscribeListApi();
    unsubscriptionListClass .value = response;
    updateLoader(false);
  }

  updateLoader(bool loader) {
    this.isLoading.value = loader;
  }
}