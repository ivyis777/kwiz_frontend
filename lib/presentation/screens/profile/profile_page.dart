import 'dart:io';

import 'package:RiddleQing/core/colors.dart';
import 'package:RiddleQing/core/form_validation/form_validation.dart';
import 'package:RiddleQing/core/storage_manager/local_storage_constants.dart';
import 'package:RiddleQing/data/models/user_details.dart';
import 'package:RiddleQing/gen/assets.gen.dart';
import 'package:RiddleQing/gen/fonts.gen.dart';
import 'package:RiddleQing/presentation/screens/controller/profile_controller.dart';
import 'package:RiddleQing/presentation/screens/controller/user_controller.dart';
import 'package:RiddleQing/presentation/screens/controller/user_details_controller.dart';
import 'package:RiddleQing/presentation/screens/controller/wallet_balance_controller.dart';
import 'package:RiddleQing/presentation/screens/profile/profile_constants.dart';
import 'package:RiddleQing/presentation/widgets/custum_space.dart';
import 'package:RiddleQing/presentation/widgets/input_decoration_helper.dart';
import 'package:RiddleQing/presentation/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl_phone_field/intl_phone_field.dart';


class ProfilePage extends StatefulWidget {
 

  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isProcessing = false;
  final userDetailsController =
      Get.put<UserDetailsController>(UserDetailsController());
  final walletBalanceController =
      Get.put<WalletBalanceController>(WalletBalanceController());
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _pinCodeController = TextEditingController();
  int _selectedIndex = 0;
  final _formKey = GlobalKey<FormState>();
   String? _selectedGender;
   File? imageFile;
    String? imageUrl; 
  final ProfileController _profileController = Get.put(ProfileController());
    final UserController userController = Get.find<UserController>();
 
  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }
void fetchUserDetails() async {
  await userDetailsController.userDetail();
  final UserDetailsModel userDetails = userDetailsController.userDetailsClass.value;

  if (userDetails.userId != null && userDetails.userId!.isNotEmpty) {
    final UserId firstUser = userDetails.userId![0];
    setState(() {
      _nameController.text = firstUser.name ?? '';
      _selectedGender = firstUser.gender ?? 'Male';
      _ageController.text = firstUser.age != null ? firstUser.age.toString() : '';
      _emailController.text = firstUser.email ?? '';
      _phoneNumberController.text = firstUser.mobile ?? '';
      _addressController.text = firstUser.address ?? '';
      _cityController.text = firstUser.city ?? '';
      _stateController.text = firstUser.state ?? '';
      _countryController.text = firstUser.country ?? '';
      _pinCodeController.text = firstUser.pincode != null ? firstUser.pincode.toString() : '';

        _updateProfileImage(); 
      
    });
  }
}
void _updateProfileImage() {
  String newImageUrl;

  if (_selectedGender == 'Male') {
    newImageUrl = Assets.images.boyicon.path;
  } else if (_selectedGender == 'Female') {
    newImageUrl = Assets.images.profile.path;
  } else {
    newImageUrl = Assets.images.profile.path;
  }

  _profileController.updateProfileImage(newImageUrl);
  _profileController.profileImageUrl.refresh();
}

  
@override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _pinCodeController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
     double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            ProfileConstants.AppBar,
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
        body: Container(
        color: Colours.primaryColor,
        width: double.infinity,
        child: Card(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Obx(() {
                String? imageUrl = _profileController.profileImageUrl.value;

                return imageUrl != null && imageUrl.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(300),
                        child: Image.asset(
                          imageUrl,
                          height: screenHeight * 0.15,
                          width: screenWidth * 0.3,
                          fit: BoxFit.fill,
                        ),
                      )
                    : Image.asset(
                        Assets.images.boyicon.path,
                        fit: BoxFit.contain,
                        height: screenHeight * 0.15,
                        width: screenWidth * 0.3,
                      );
              }),
                Expanded(
                  child: SingleChildScrollView(
                 
                    child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.05), 
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                           TextFormField(
  validator: FormValidation.nameValidation,
  controller: _nameController,
  decoration: InputDecorationHelper.textFieldNewStyle(
    labelText: 'Name*',
    hintText: 'Name',
  ).copyWith(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colours.yellowcolor, width: 2.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colours.primaryColor, width: 1.0),
    ),
    
  ),
  
),
CustomSpace(height: 10),
Row(
  children: [
    Text(
      'Gender',
      style: TextStyle(fontSize: 17, fontFamily: 'Rubik'),
    ),
  ],
),
// SizedBox(height: screenHeight * 0.02), 
DropdownButtonFormField<String>(
  value: _selectedGender,  // Make sure this has a valid initial value or null
  onChanged: (String? newValue) {
    setState(() {
      // Null check before updating the value
      if (newValue != null) {
        _selectedGender = newValue;
      }
    });
  },
  validator: (value) {
    if (value == null) {
      return 'Please select gender';
    }
    return null;
  },
  items: <String>['Male', 'Female', 'Other'] // Capitalize the items
      .map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList(),
  decoration: InputDecorationHelper.textFieldNewStyle(
    hintText: 'Select Gender',
  ).copyWith(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colours.yellowcolor, width: 2.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colours.primaryColor, width: 1.0),
    ),
  ),
),

                     
     SizedBox(height: screenHeight * 0.02),                     
TextFormField(
  validator: FormValidation.ageValidation,
  controller: _ageController,
  decoration: InputDecorationHelper.textFieldNewStyle(
    labelText: 'Age*',
    hintText: 'Age',
  ).copyWith(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colours.yellowcolor, width: 2.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colours.primaryColor, width: 1.0),
    ),
  ),
),
SizedBox(height: screenHeight * 0.02),
IgnorePointer(
  ignoring: true,
  child: TextFormField(
    controller: _emailController,
    readOnly: true,
    autovalidateMode: AutovalidateMode.disabled, 
    enabled: true,
    decoration: InputDecorationHelper.textFieldNewStyle(
      labelText: 'Email*',
      hintText: 'Email',
    ).copyWith(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colours.textColour, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colours.textColour, width: 1.0),
      ),
    ),
  ),
),

SizedBox(height: screenHeight * 0.02),
GestureDetector(
  onTap: () {
    
  },
  child: IgnorePointer(
    ignoring: true,
    child: IntlPhoneField(
      controller: _phoneNumberController,
      readOnly: true,
      decoration: InputDecorationHelper.textFieldNewStyle(
        labelText: 'Phone Number*',
        hintText: 'Phone Number',
      ).copyWith(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colours.textColour, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colours.textColour, width: 1.0),
        ),
      ),
      initialCountryCode: 'IN',
      autovalidateMode: AutovalidateMode.disabled,
      onChanged: (phone) {},
    ),
  ),
),

 SizedBox(height: screenHeight * 0.02), 
TextFormField(
  validator: FormValidation.addressValidation,
  controller: _addressController,
  decoration: InputDecorationHelper.textFieldNewStyle(
    labelText: 'Address *',
    hintText: 'Address ',
  ).copyWith(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colours.yellowcolor, width: 2.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colours.primaryColor, width: 1.0),
    ),
  ),
),
 SizedBox(height: screenHeight * 0.02), 
TextFormField(
  validator: FormValidation.cityValidation,
  controller: _cityController,
  decoration: InputDecorationHelper.textFieldNewStyle(
    labelText: 'City*',
    hintText: 'City',
  ).copyWith(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colours.yellowcolor, width: 2.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colours.primaryColor, width: 1.0),
    ),
  ),
),
 SizedBox(height: screenHeight * 0.02), 
TextFormField(
  validator: FormValidation.stateValidation,
  controller: _stateController,
  decoration: InputDecorationHelper.textFieldNewStyle(
    labelText: 'State*',
    hintText: 'State',
  ).copyWith(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colours.yellowcolor, width: 2.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colours.primaryColor, width: 1.0),
    ),
  ),
),
 SizedBox(height: screenHeight * 0.02), 
TextFormField(
  validator: FormValidation.countryValidation,
  controller: _countryController,
  decoration: InputDecorationHelper.textFieldNewStyle(
    labelText: 'Country*',
    hintText: 'Country*',
  ).copyWith(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colours.yellowcolor, width: 2.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colours.primaryColor, width: 1.0),
    ),
  ),
),
 SizedBox(height: screenHeight * 0.02), 
TextFormField(
  validator: FormValidation.pinCodeValidation,
  controller: _pinCodeController,
  decoration: InputDecorationHelper.textFieldNewStyle(
    labelText: 'Pin Code*',
    hintText: 'Pin Code*',
  ).copyWith(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colours.yellowcolor, width: 2.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colours.primaryColor, width: 1.0),
    ),
  ),
),
SizedBox(height: screenHeight * 0.02), 
Center(
  child: SaveButton(
    title: _isProcessing ? 'Updating...' : 'Update Profile',
    onPress: _isProcessing
        ? null
        : () async {
            setState(() {
              _isProcessing = true; 
            });

            try {
              await _updateUserProfile(context);
             
            } catch (e) {
              print('Error occurred: $e');
              
            } finally {
              setState(() {
                _isProcessing = false; 
              });
            }
          },
    circularRadius: 32,
    isButtonPressed: _isProcessing,
    loadingActionRequired: _isProcessing,
     textStyle: TextStyle(
      color: _isProcessing ? Colours.CardColour : Colours.CardColour, 
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
  ),
),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
       
        );
        // );
  }
Future<void> _updateUserProfile(BuildContext context) async {
  if (_formKey.currentState?.validate() == true) {
    final box = GetStorage();
    var fetchedID = box.read(LocalStorageConstants.userId);
    await _profileController.updateUserProfile(
      context: context,
      userId: fetchedID.toString(),
      name: _nameController.text,
      gender: _selectedGender!,
      age: _ageController.text,
      email: _emailController.text,
      mobile: _phoneNumberController.text,
      address: _addressController.text,
      city: _cityController.text,
      country: _countryController.text,
      state: _stateController.text,
      pincode: _pinCodeController.text,
    );
       String newImageUrl = Assets.images.boyicon.path; 
                  _profileController.updateProfileImage(newImageUrl);
                
  final userController = Get.find<UserController>();
    userController.updateProfile(_nameController.text);
    box.write(LocalStorageConstants.displayName, _nameController.text);
  }
  }

}