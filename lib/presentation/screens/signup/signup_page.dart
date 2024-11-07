
import 'package:Kwiz/core/colors.dart';
import 'package:Kwiz/gen/fonts.gen.dart';
import 'package:Kwiz/presentation/screens/emailpage/email_page.dart';
import 'package:Kwiz/presentation/screens/onboarding/onboarding_page.dart';
import 'package:Kwiz/presentation/screens/signup/signup_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:url_launcher/url_launcher.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  void initState() {
    super.initState();
   
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colours.primaryColor,
           automaticallyImplyLeading: false,
        title: Text(
          SignUpConstsant.appBar,
          style: TextStyle(
            color: Colours.CardColour,
            fontFamily: FontFamily.rubik,
            fontSize: 24,
            fontWeight: FontWeight.w500,
           
          ),
        ),
        foregroundColor: Colours.cardTextColour,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colours.cardTextColour,
          size: 25,
        ),
        
      ),
      backgroundColor: Colours.secondaryColour,
      body: LayoutBuilder(
        builder: (context, constraints) {
          double buttonWidth = constraints.maxWidth * 0.9;
          return SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 160, left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.to(EmailPage());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.email_outlined,
                          color: Colours.CardColour,
                        ),
                        SizedBox(width: 8),
                        Text(
                          SignUpConstsant.formText1,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: FontFamily.rubik,
                            color: Colours.CardColour,
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(buttonWidth, 60),
                      backgroundColor: Colours.buttonColour,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
               
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        SignUpConstsant.text1,
                        style: TextStyle(
                            color: Colours.textColour,
                            fontWeight: FontWeight.w400,
                            fontFamily: FontFamily.rubik,
                            fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(OnBoardingPage());
                        },
                        child: Text(
                          SignUpConstsant.textButton,
                          style: TextStyle(
                              color: Colours.primaryColor,
                              fontFamily: FontFamily.rubik,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Text(
                          SignUpConstsant.text4,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colours.textColour,
                              fontWeight: FontWeight.w400),
                        ),
                        GestureDetector(
                            onTap: () {
                                      launchUrl(Uri.parse("//kwiizz.com/Terms%20n%20conditions.html"));
                                    },
                          child: RichText(
                            text: TextSpan(
                              text: SignUpConstsant.richText2,
                              style: TextStyle(
                                  fontSize: 14,
                                   color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    margin: EdgeInsets.only(left: 150),
                    child: Column(
                      children: [
                        GestureDetector(
                           onTap: () {
                                      launchUrl(Uri.parse("https://kwiizz.com/privacy.html"));
                                    },
                          child: RichText(
                            text: TextSpan(
                              text: SignUpConstsant.richText3,
                              style: TextStyle(
                                  fontSize: 14,
                                   color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
