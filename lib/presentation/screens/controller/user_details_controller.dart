import 'package:Kwiz/core/storage_manager/local_storage_constants.dart';
import 'package:Kwiz/data/api_service.dart';
import 'package:Kwiz/data/models/user_details.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class UserDetailsController extends GetxController {
  var userDetailsClass = UserDetailsModel().obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void>  userDetailURL() async {
    updateLoader(true);
    final box = GetStorage();
    final userId = box.read(LocalStorageConstants.userId).toString();
    var response = await ApiService.userDetailsURL();
    userDetailsClass.value = response;
    updateLoader(false);
  }
    
  void updateLoader(bool loader) {
    isLoading.value = loader;
  }
}