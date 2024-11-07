import 'package:Kwiz/core/storage_manager/local_storage_constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class UserController extends GetxController {
  var displayName = ''.obs;  
  var username = ''.obs;   

  @override
  void onInit() {
    super.onInit();
    final box = GetStorage();
    username.value = box.read(LocalStorageConstants.username) ?? 'Default Username';
    displayName.value = box.read(LocalStorageConstants.displayName) ?? ''; 
  }

  void updateProfile(String name) {
    displayName.value = name;
    final box = GetStorage();
    box.write(LocalStorageConstants.displayName, displayName.value); 
  }
}
