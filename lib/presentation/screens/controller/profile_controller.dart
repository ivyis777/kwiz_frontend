
import 'package:Kwiz/core/storage_manager/local_storage_constants.dart';
import 'package:Kwiz/data/api_service.dart';
import 'package:Kwiz/presentation/screens/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';




class ProfileController extends GetxController {
  var isLoading = false.obs;
  var profileImageUrl = ''.obs;

  // Method to update the profile image URL and save it to GetStorage
  void updateProfileImage(String newImageUrl) {
    profileImageUrl.value = newImageUrl;
    final box = GetStorage();
    box.write(LocalStorageConstants.profileImageUrl, newImageUrl);
  }

  void updateLoading(bool load) {
    isLoading.value = load; // No need for update() since isLoading is an observable.
  }

  Future<void> updateUserProfile({
    required BuildContext context,
    required String name,
    required String userId,
    required String gender,
    required String email,
    required String mobile,
    required String address,
    required String city,
    required String country,
    required String state,
    required String pincode,
    required String age,
  }) async {
    // Set isLoading to true when starting the profile update process
    updateLoading(true);

    try {
      final response = await ApiService.profileApi(
        context: context,
        user_id: userId,
        name: name,
        gender: gender,
        email: email,
        mobile: mobile,
        address: address,
        city: city,
        country: country,
        state: state,
        pincode: pincode,
        age: age,
      );

      if (response.status == "200") {
        // Use WidgetsBinding to navigate after the build completes
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SettingsPage()),
          );
        });
      } else {
        Get.snackbar('Error', 'Failed to update profile: ${response.message}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      // Set isLoading to false after the profile update process is complete
      updateLoading(false);
    }
  }
}
