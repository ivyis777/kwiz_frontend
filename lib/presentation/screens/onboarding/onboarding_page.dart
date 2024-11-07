import 'dart:async';
import 'package:Kwiz/core/colors.dart';
import 'package:Kwiz/data/models/user_models.dart';
import 'package:Kwiz/gen/assets.gen.dart';
import 'package:Kwiz/gen/fonts.gen.dart';
import 'package:Kwiz/presentation/screens/controller/loginotp_controller.dart';
import 'package:Kwiz/presentation/screens/controller/onboarding_controller.dart';
import 'package:Kwiz/presentation/screens/controller/resendotp_controller.dart';
import 'package:Kwiz/presentation/screens/onboarding/onboarding_constants.dart';
import 'package:Kwiz/presentation/screens/signup/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';


class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  bool _isProcessing = false;
  final _formKey4 = GlobalKey<FormState>();
  List<TextEditingController> otpControllers = List.generate(4, (_) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());
  var userList = <UserModel>[].obs;
  var isLoading = true.obs;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  OnboardingController controller = Get.put(OnboardingController());
  final loginotpController = Get.put(LoginOtpController());
  final resendotpController = Get.put(ResendOtpController());

  Timer? _timer;
  int _start = 0;
  bool _isTimerVisible = false;
  bool _isGetOtpButtonDisabled = false;
  bool _isResendOtpButtonDisabled = false;
  bool _isInitialOtpRequest = true; 

  void _startTimer() {
    setState(() {
      _isTimerVisible = true;
      _isGetOtpButtonDisabled = true;
      _isResendOtpButtonDisabled = true;
      _start = 30; 
    });

    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_start == 0) {
        timer.cancel();
        setState(() {
          _isTimerVisible = false;
          _isGetOtpButtonDisabled = false;
          _isResendOtpButtonDisabled = false;
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }
  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    otpControllers.forEach((controller) => controller.dispose());
    focusNodes.forEach((node) => node.dispose());
      _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colours.primaryColor,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: size.height),
          child: Form(
            key: _formKey4,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * 0.01),
                    Image.asset(
                      Assets.images.illustration.path,
                      height: size.height * 0.25,
                    ),
                    SizedBox(height: size.height * 0.01),
                    Container(
                      width: size.width * 0.9,
                      child: Card(
                        color: Colours.secondaryColour,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                Assets.images.Appicon1.path,
                                height: size.height * 0.08,
                                // width: size.width* 0.9,
                              ),
                              SizedBox(height: 8),
                              Container(
                                width: size.width * 0.8,
                                child: Card(
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      validator: FormValidation.emailValidation,
                                      controller: _emailController,
                                      decoration: InputDecoration(
                                        hintText: OnboardingConstants.hinttext1,
                                        hintStyle: TextStyle(color: Colours.formTextColour),
                                        filled: true,
                                        fillColor: Colours.CardColour,
                                        contentPadding: EdgeInsets.zero,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(15)),
                                          borderSide: BorderSide.none,
                                        ),
                                        prefixIcon: Icon(
                                          Icons.email_outlined,
                                          color: Colours.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                                
                                Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  if (_isTimerVisible)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                                      child: Text(
                                        '00:${_start.toString().padLeft(2, '0')}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colours.primaryColor,
                                          fontFamily: FontFamily.rubik,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                              Container(
  margin: EdgeInsets.fromLTRB(size.width * 0.4, 5, 5, 10),
  child: TextButton(
    onPressed: _isGetOtpButtonDisabled
        ? null
        : () async {
            if (_formKey4.currentState!.validate()) {
              setState(() {
                _isGetOtpButtonDisabled = true; 
              });

            
              bool isOtpRequestSuccessful;
              if (_isInitialOtpRequest) {
              
                isOtpRequestSuccessful = await loginotpController.getLoginOtpUser(
                  context: context,
                  email: _emailController.text,
                );
              } else {
              
                isOtpRequestSuccessful = await resendotpController.getResendOtpUser(
                  context: context,
                  email: _emailController.text,
                );
              }

            
              if (isOtpRequestSuccessful) {
                _startTimer();
                setState(() {
                  _isInitialOtpRequest = false; 
                
                });
              } else {
               
                setState(() {
                  _isGetOtpButtonDisabled = false;
                });
               
              }
            }
          },
    child: Text(
      _isInitialOtpRequest ? OnboardingConstants.text2 : 'Resend',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        fontFamily: FontFamily.rubik,
        color: _isGetOtpButtonDisabled ? Colors.grey : Colours.primaryColor,
      ),
    ),
  ),
),

                                ],
                              ),
                              SizedBox(height: 13),
                              _buildOTPInputGrid(),
                             
                              SizedBox(height: 15),
                           Container(
  width: size.width * 0.6,
  child: ElevatedButton(
    onPressed: _isProcessing
        ? null
        : () async {
            if (_formKey4.currentState!.validate()) {
              setState(() {
                _isProcessing = true;
              });

              final otp = otpControllers.map((controller) => controller.text).join();
              final otpError = FormValidation.otpValidation(otp);

              if (otpError != null) {
                Get.snackbar(
                  "Login Failed",
                  otpError,
                  snackPosition: SnackPosition.TOP,
                  colorText: Colours.CardColour,
                  messageText: Center(
                    child: Text(
                      otpError,
                      style: TextStyle(
                        color: Colours.CardColour,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  backgroundColor: Colours.yellowcolor,
                );
                setState(() {
                  _isProcessing = false; // Re-enable the button after the error
                });
              } else {
                try {
                  await controller.login(
                    email: _emailController.text,
                    otp: otp,
                    through_google: false,
                  );
                } finally {
                  setState(() {
                    _isProcessing = false; 
                  });
                }
              }
            }
          },
    child: _isProcessing
        ? CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colours.CardColour),
          )
        : Text(
            OnboardingConstants.login,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: FontFamily.rubik,
              color: Colours.CardColour,
            ),
          ),
    style: ElevatedButton.styleFrom(
      fixedSize: Size(300, 56),
      backgroundColor: Colours.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  ),
),

                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    OnboardingConstants.text,
                                    style: TextStyle(
                                      color: Colours.textColour,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: FontFamily.rubik,
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.to(SignUpPage());
                                    },
                                    child: Text(
                                      OnboardingConstants.textbutton,
                                      style: TextStyle(
                                        color: Colours.primaryColor,
                                        fontFamily: FontFamily.rubik,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    OnboardingConstants.terms,
                                    style: TextStyle(
                                      color: Colours.primaryColor,
                                      fontFamily: FontFamily.rubik,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      launchUrl(Uri.parse("//kwiizz.com/Terms%20n%20conditions.html"));
                                    },
                                    child: Text(
                                      " Terms of use",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                        fontFamily: FontFamily.rubik,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    OnboardingConstants.and,
                                    style: TextStyle(
                                      color: Colours.primaryColor,
                                      fontFamily: FontFamily.rubik,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      launchUrl(Uri.parse("https://kwiizz.com/privacy.html"));
                                    },
                                    child: Text(
                                      " Privacy policy",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                        fontFamily: FontFamily.rubik,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOTPInputGrid() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        4,
        (index) => SizedBox(
          width: 40,
          height: 40,
          child: TextField(
            controller: otpControllers[index],
            focusNode: focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            onChanged: (value) {
              if (value.isNotEmpty && index < 3) {
                FocusScope.of(context).requestFocus(focusNodes[index + 1]);
              } else if (value.isEmpty && index > 0) {
                FocusScope.of(context).requestFocus(focusNodes[index - 1]);
              }
            },
            decoration: InputDecoration(
              counterText: '',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colours.primaryColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colours.yellowcolor),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colours.primaryColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FormValidation {
  static String? emailValidation(String? text) {
    if (text == null || text.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(text)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? otpValidation(String? text) {
    if (text == null || text.isEmpty) {
      return 'Please enter your OTP';
    } else if (text.length != 4 || int.tryParse(text) == null) {
      return 'OTP must be a 4-digit number';
    }
    return null;
  }
}
