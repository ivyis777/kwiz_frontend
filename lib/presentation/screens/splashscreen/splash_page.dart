
import 'package:RiddleQing/core/colors.dart';
import 'package:RiddleQing/core/storage_manager/local_storage_constants.dart';
import 'package:RiddleQing/utils/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../onboarding/onboarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    navigationOnBoarding();
  }

  Future<void> navigationOnBoarding() async {
    // Add a small delay to show the splash screen for 2.5 seconds
    await Future.delayed(const Duration(milliseconds: 3500));

    // Ensure that GetStorage is properly initialized
    final box = GetStorage();
    bool isUserLoggedIn = box.read(LocalStorageConstants.sessionManager) ?? false;

    print("Session Manager Value: $isUserLoggedIn");

    // Use mounted check to avoid calling Get.offAll() after the widget is disposed
    if (mounted) {
      if (isUserLoggedIn) {
        // If user is logged in, navigate to the MainLayout
        Get.offAll(() => MainLayout());
      } else {
        // If not logged in, navigate to the OnBoardingPage
        Get.offAll(() => OnBoardingPage());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.CardColour,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
            child: Image.asset("assets/images/appicon.png"),

            ),
          ],
        ),
      ),
    );
  }
}
