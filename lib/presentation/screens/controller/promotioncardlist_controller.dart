import 'package:Kwiz/data/api_service.dart';
import 'package:Kwiz/data/models/promotioncardlist_model.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';


class PromotioncardlistController extends GetxController {
  var PromotionCardList = PromotioncardlistModel().obs;
  var isLoading = false.obs;

  void updateLoading(bool load) {
    isLoading.value = load;
  }

  Future<void> getPromotionCardList({required String quiz_id}) async {
    try {
      updateLoading(true);
      var response = await ApiService.promotionCardListApi(quiz_id: quiz_id);
      PromotionCardList.value = response;

      // Debugging log
      print("Fetched promotion card data: ${PromotionCardList.value.toJson()}");
    } catch (e) {
      print("Error fetching promotion card list: $e");
    } finally {
      updateLoading(false);
    }
  }
}
