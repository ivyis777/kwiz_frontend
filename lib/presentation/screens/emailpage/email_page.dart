import 'package:Kwiz/core/colors.dart';
import 'package:Kwiz/core/form_validation/form_validation.dart';
import 'package:Kwiz/gen/fonts.gen.dart';
import 'package:Kwiz/presentation/screens/controller/otp_controller.dart';
import 'package:Kwiz/presentation/screens/emailpage/emailpage_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({Key? key});

  @override
  State<EmailPage> createState() => _EmailPageState();
}
class _EmailPageState extends State<EmailPage> {
  bool _isProcessing = false;
  final _formKey1 = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phonenumberController = TextEditingController(); 
  final otpController = Get.put(OtpController());

  String? phoneValidation(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return 'Please enter your phone number';
    }
    if (phoneNumber.length != 10) {
      return 'Phone number must be 10 digits';
    }
    if (!phoneNumber.startsWith(RegExp(r'[0-9]'))) {
      return 'Phone number must contain only numeric digits';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          EmailConstraints.appBarTitle,
          style: TextStyle(
            color: Colours.CardColour,
            fontFamily: FontFamily.rubik,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        foregroundColor: Colours.CardColour,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colours.CardColour,
          size: 25,
        ),
        backgroundColor: Colours.primaryColor,
      ),
      backgroundColor: Colours.secondaryColour,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50),
                    Container(
                      child: Form(
                        key: _formKey1,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _nameController,
                              validator: FormValidation.nameValidation,
                              decoration: InputDecoration(
                                hintText: EmailConstraints.namehinttext,
                                hintStyle: TextStyle(color: Colours.formTextColour),
                                contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                                filled: true,
                                fillColor: Colours.CardColour,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: Colours.primaryColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: _emailController,
                              validator: FormValidation.emailValidation,
                              decoration: InputDecoration(
                                hintText: EmailConstraints.hinttext1,
                                hintStyle: TextStyle(color: Colours.formTextColour),
                                contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                                filled: true,
                                fillColor: Colours.CardColour,
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
                            SizedBox(height: 20),
                            IntlPhoneField(
                              controller: _phonenumberController,
                              decoration: InputDecoration(
                                hintText: 'Phone Number',
                                hintStyle: TextStyle(color: Colours.formTextColour),
                                contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                                filled: true,
                                fillColor: Colours.CardColour,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: Colours.primaryColor,
                                ),
                              ),
                              initialCountryCode: 'IN',
                              validator: (phoneNumber) => phoneValidation(phoneNumber?.completeNumber),
                              onChanged: (phone) {
                               
                                print(phone.completeNumber);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                   Container(
  margin: EdgeInsets.fromLTRB(90, 10, 40, 20),
  child: ElevatedButton(
    onPressed: _isProcessing
        ? null
        : () async {
            if (_formKey1.currentState!.validate()) {
              setState(() {
                _isProcessing = true;
              });

              try {
                final otpController = Get.find<OtpController>();
                await otpController.getOtpUser(
                  context: context,
                  username: _nameController.text,
                  mobile: _phonenumberController.text,
                  email: _emailController.text,
                );
              } finally {
                setState(() {
                  _isProcessing = false; 
                });
              }
            }
          },
    child: _isProcessing
        ? CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colours.CardColour),
          )
        : Text(
            EmailConstraints.GetOtp,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: FontFamily.rubik,
              color: Colours.CardColour,
            ),
          ),
    style: ElevatedButton.styleFrom(
      fixedSize: Size(150, 60),
      backgroundColor: Colours.buttonColour,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  ),
),

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
