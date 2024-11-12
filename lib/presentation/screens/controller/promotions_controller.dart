
import 'package:RiddleQing/data/api_service.dart';
import 'package:RiddleQing/data/models/promotion_model.dart';
import 'package:get/get.dart';




class PromotionsController extends GetxController {
  var promotionsClass = PromotionsModel().obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }
  Future<void> PromotionsListApi() async {
    updateLoader(true);
    var response = await ApiService.PromotionsListApi();
  promotionsClass .value = response;
    updateLoader(false);
  }

  updateLoader(bool loader) {
    this.isLoading.value = loader;
  }
}