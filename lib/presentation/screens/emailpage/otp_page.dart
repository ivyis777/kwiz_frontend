import 'dart:async';
import 'package:Kwiz/core/colors.dart';
import 'package:Kwiz/gen/fonts.gen.dart';
import 'package:Kwiz/presentation/screens/controller/resendotp_controller.dart';
import 'package:Kwiz/presentation/screens/controller/signup_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class OTPPage extends StatefulWidget {
  final String email;
  final String username;
  final String mobile;

  OTPPage({required this.email, required this.username, required this.mobile});

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  bool _isProcessing = false;
  final _formKey1 = GlobalKey<FormState>();
  List<TextEditingController> otpControllers = List.generate(4, (_) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());
  final signupController = Get.put(SignupController());
  final resendotpController = Get.put(ResendOtpController());
  String? fcmToken;
  Timer? _timer;
  int _start = 30;

  @override
  void initState() {
    super.initState();
    focusNodes[0].requestFocus();
    fetchFcmToken();
    startTimer();
  }

  Future<void> fetchFcmToken() async {
    fcmToken = await FirebaseMessaging.instance.getToken();
    print('FCM Token: $fcmToken');
  }

  void startTimer() {
    _start = 30;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
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
    _timer?.cancel();
    otpControllers.forEach((controller) => controller.dispose());
    focusNodes.forEach((focusNode) => focusNode.dispose());
    super.dispose();
  }

  static String? otpValidation(String? text) {
    if (text == null || text.isEmpty) {
      return 'Please enter your OTP';
    } else if (text.length != 4 || int.tryParse(text) == null) {
      return 'OTP must be a 4-digit number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: TextStyle(
            color: Colours.CardColour,
            fontFamily: FontFamily.rubik,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        foregroundColor: Colours.CardColour,
        centerTitle: true,
        backgroundColor: Colours.primaryColor,
      ),
      backgroundColor: Colours.secondaryColour,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'OTP Verification',
                style: TextStyle(
                  fontSize: 25,
                  color: Colours.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Enter the code from the email we have sent to ',
                style: TextStyle(
                  fontSize: 14,
                  color: Colours.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 5),
              Center(
                child: Text(
                  '${widget.email}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colours.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(height: 20),
              _buildOTPInputGrid(),
              SizedBox(height: 20),
              Text(
                '00:${_start.toString().padLeft(2, '0')}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colours.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Did't receive the OTP?",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colours.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextButton(
                    onPressed: _start == 0
                        ? () {
                            final resendotpController = Get.find<ResendOtpController>();
                            resendotpController.getResendOtpUser(
                              context: context,
                              email: widget.email,
                            );
                            startTimer();
                          }
                        : null,
                    child: Text(
                      'Resend',
                      style: TextStyle(
                        fontSize: 15,
                        color: _start == 0 ? Colours.primaryColor : Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
             ElevatedButton(
  onPressed: _isProcessing
      ? null
      : () async {
          setState(() {
            _isProcessing = true;
          });

          try {
            final otp = otpControllers.map((controller) => controller.text).join();
            final validationMsg = otpValidation(otp);

            if (validationMsg != null) {
              Get.snackbar(
                '',
                '',
                backgroundColor: Colours.yellowcolor,
                colorText: Colours.CardColour,
                snackPosition: SnackPosition.TOP,
                messageText: Center(
                  child: Text(
                    validationMsg,
                    style: TextStyle(
                      color: Colours.CardColour,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            } else {
              final signupController = Get.find<SignupController>();
              await signupController.getSignupUser(
                context: context,
                username: widget.username,
                mobile: widget.mobile,
                email: widget.email,
                otp: otp,
                fcmToken: fcmToken!,
              );
            }
          } finally {
            setState(() {
              _isProcessing = false; 
            });
          }
        },
  child: _isProcessing
      ? CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colours.CardColour),
        )
      : Text(
          'Submit',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: FontFamily.rubik,
            color: Colours.CardColour,
          ),
        ),
  style: ElevatedButton.styleFrom(
    fixedSize: Size(150, 50),
    backgroundColor: Colours.buttonColour,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  ),
),

            ],
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
              if (value.isNotEmpty && index < 3 && otpControllers[index + 1].text.isEmpty) {
                FocusScope.of(context).requestFocus(focusNodes[index + 1]);
              } else if (value.isEmpty && index > 0 && otpControllers[index - 1].text.isNotEmpty) {
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
