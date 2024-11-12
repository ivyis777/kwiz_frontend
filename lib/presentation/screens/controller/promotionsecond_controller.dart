
import 'package:RiddleQing/data/api_service.dart';
import 'package:RiddleQing/data/models/promotionsecond_model.dart';
import 'package:get/get.dart';




class PromotionsecondController extends GetxController {
  var PromotionsecondClass = PromotionsecondModel().obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }
  Future<void> PromotionsecondListApi() async {
    updateLoader(true);
    var response = await ApiService.PromotionsecondListApi();
  PromotionsecondClass .value = response;
    updateLoader(false);
  }

  updateLoader(bool loader) {
    this.isLoading.value = loader;
  }
}