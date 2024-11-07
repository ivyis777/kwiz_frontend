import 'package:Kwiz/gen/fonts.gen.dart';
import 'package:Kwiz/presentation/screens/controller/wallet_balance_controller.dart';
import 'package:Kwiz/presentation/screens/help_and_support/help_support_constrants.dart';
import 'package:Kwiz/presentation/widgets/common_ui_bg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/colors.dart';


class HelpSupport extends StatefulWidget {
  const HelpSupport({Key ?key}) : super(key: key);


  
  @override
  State<HelpSupport> createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {
     final walletBalanceController = Get.put<WalletBalanceController>(WalletBalanceController());
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          HelpSupportConstraints.appBarTitle,
          style: TextStyle(
            color: Colours.cardTextColour,
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
        backgroundColor: Colours.secondaryColour,
      ),
      backgroundColor: Colours.secondaryColour,
      body: Expanded(
        child: CommonUIBG( 
          widget: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 327,
                  height: 56,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(55),
                      side: BorderSide(color: Colours.secondaryColour, width: 2),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: HelpSupportConstraints.searchHintText,
                        hintStyle: TextStyle(
                          color: Colours.formTextColour,
                          fontSize: 16,
                          fontFamily: FontFamily.rubik,
                          fontWeight: FontWeight.w400,
                        ),
                        fillColor: Colours.secondaryColour,
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colours.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20), 
                Text(HelpSupportConstraints.text1,style: TextStyle(fontFamily: FontFamily.rubik,fontSize:14,fontWeight:FontWeight.w500,color: Colours.formTextColour),),
                Divider(color: Colours.dividercolor),
                  SizedBox(height: 20),
                 Text(HelpSupportConstraints.text2,style: TextStyle(fontFamily: FontFamily.rubik,fontSize:16,fontWeight:FontWeight.w500,color:  Colours.primaryColor ),),
                Divider(color: Colours.dividercolor),
  //               GestureDetector(
  // onTap: () {
    
  // }),
    SizedBox(height: 20),
                 Text(HelpSupportConstraints.text3,style: TextStyle(fontFamily: FontFamily.rubik,fontSize:16,fontWeight:FontWeight.w500 ,color: Colours.primaryColor,),),
                Divider(color: Colours.dividercolor),
  //               GestureDetector(
  // onTap: () {
  //   // Add your onTap functionality here for Text 1
  // }),
    SizedBox(height: 20),
                 Text(HelpSupportConstraints.text4,style: TextStyle(fontFamily: FontFamily.rubik,fontSize:14,fontWeight:FontWeight.w500 ,color: Colours.formTextColour,),),
                Divider(color: Colours.dividercolor),
  //               GestureDetector(
  // onTap: () {
  //   // Add your onTap functionality here for Text 1
  // },),
    SizedBox(height: 20),
                 Text(HelpSupportConstraints.Text5,style: TextStyle(fontFamily: FontFamily.rubik,fontSize:16,fontWeight:FontWeight.w500 ,color: Colours.primaryColor,),),
                Divider(color: Colours.dividercolor),
  //               GestureDetector(
  // onTap: () {
  //   // Add your onTap functionality here for Text 1
  // },),
                       SizedBox(height: 20),
                 Text(HelpSupportConstraints.text6,style: TextStyle(fontFamily: FontFamily.rubik,fontSize:16,fontWeight:FontWeight.w500,color: Colours.primaryColor ),),
                Divider(color: Colours.dividercolor),
  //               GestureDetector(
  // onTap: () {
  //   // Add your onTap functionality here for Text 1
  // },),  
  SizedBox(height: 20),
                 Text(HelpSupportConstraints.text7,style: TextStyle(fontFamily: FontFamily.rubik,fontSize:16,fontWeight:FontWeight.w500,color: Colours.primaryColor),),
                Divider(color: Colours.dividercolor),
  //               GestureDetector(
  // onTap: () {
  //   // Add your onTap functionality here for Text 1
  // },),
                 SizedBox(height: 20),
                 Text(HelpSupportConstraints.text8,style: TextStyle(fontFamily: FontFamily.rubik,fontSize:16,fontWeight:FontWeight.w500,color: Colours.primaryColor ),),
  //              GestureDetector(
  // onTap: () {
  //   // Add your onTap functionality here for Text 1
  // },),
              ],
            ),
          ),
        ),
      ),
  
    );
  }
}
