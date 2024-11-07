import 'package:Kwiz/core/colors.dart';
import 'package:Kwiz/core/storage_manager/local_storage_constants.dart';
import 'package:Kwiz/gen/assets.gen.dart';
import 'package:Kwiz/gen/fonts.gen.dart';
import 'package:Kwiz/presentation/screens/controller/couponcode_controller.dart';
import 'package:Kwiz/presentation/screens/controller/payfromwallet_controller.dart';
import 'package:Kwiz/presentation/screens/controller/wallet_balance_controller.dart';
import 'package:Kwiz/presentation/screens/wallet/topup_page.dart';
import 'package:Kwiz/presentation/widgets/common_ui_bg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';


class PaymentPage extends StatefulWidget {
  final String keyID;
  final String keySecret;
  final double amount;
  final String? email;
  final String quizTitle;
  final String quizCategory;
  final DateTime quizSchedule;
  final String? quizSubCategory;
  final String? createdBy;
  final String? quizId;
  final bool isScheduled;

  const PaymentPage({
    Key? key,
    required this.keyID,
    required this.email,
    required this.quizId,
    required this.keySecret,
    required this.amount,
    this.quizTitle = '',
    this.quizCategory = '',
    required this.quizSchedule,
    this.quizSubCategory = '',
    this.createdBy = "",
    required this.isScheduled,
  }) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool payFromWallet = false;
  bool isProcessing = false; 

  int _selectedIndex = 0;
  final walletBalanceController = Get.put<WalletBalanceController>(WalletBalanceController());
  final payWalletController = Get.put<PayWalletController>(PayWalletController());
  late CouponcodeController couponController;
  TextEditingController couponControllerText = TextEditingController();
  double totalAmount = 0.0;

  @override
  void initState() {
    super.initState();
    couponController = Get.put(CouponcodeController(amount: widget.amount, coupon_code: '',));
  }

  void calculateTotalAmount() {
  setState(() {
    double discount = couponController.amountDeducted.value;
    double discountedAmount = widget.amount - discount;
    totalAmount = discountedAmount > 0 ? discountedAmount : widget.amount;
    
    if (payFromWallet && totalAmount < 0) {
      totalAmount = 0;
    }
  });
}



  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  DateTime convertToIST(DateTime dateTime) {
    return dateTime.add(Duration(hours: 0, minutes: 0));
  }

  @override
  Widget build(BuildContext context) {
    calculateTotalAmount(); 

    DateTime quizScheduleIST = convertToIST(widget.quizSchedule);
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pay To Play",
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
      backgroundColor: Colours.primaryColor,
      body: CommonUIBG(
        widget: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.03),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9.0),
                child: Card(
                  color: Colours.secondaryColour,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              Assets.images.cardimage4.path,
                              width: screenWidth * 0.12,
                              height: screenHeight * 0.12,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.07),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.quizTitle,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: Colours.primaryColor,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  widget.quizCategory,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colours.textColour,
                                  ),
                                ),
                                SizedBox(height: 4),
                                
                                Text(
                                  widget.quizSubCategory ?? '',
                                  
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colours.textColour,
                                  ),
                                  
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      'Created by :',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colours.black,
                                      ),
                                    ),
                                    SizedBox(width: screenWidth * 0.1),
                                    Text(
                                      widget.createdBy ?? '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colours.black,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                if (widget.isScheduled)
                                  Container(
                                    margin: EdgeInsets.only(right: 33),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Date & Time :',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colours.black,
                                          ),
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          DateFormat('dd/MM/yyyy \n hh:mm a').format(quizScheduleIST),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colours.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Subscription Fee:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colours.black,
                      ),
                    ),
                      Text(
                      '₹${couponController.amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colours.black,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Divider(
                height: 1,
                color: Colours.textColour,
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
              SizedBox(height: screenHeight * 0.02),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Any Coupon?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colours.black,
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal:5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colours.textColour),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          controller: couponControllerText,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Code',
                          ),
                          onChanged: (value) {
                           
                            calculateTotalAmount();
                          },
                        ),
                      ),
                    ),
                      SizedBox(width: 5),
                   Obx(() => ElevatedButton(
  onPressed: couponController.isLoading.value
      ? null
      : () async {
          couponController.couponCode.value = couponControllerText.text;
          await couponController.applyCouponCode();
          calculateTotalAmount();
        },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colours.primaryColor,
    minimumSize: Size(120, 45),
  ),
  child: Text(
    couponController.isLoading.value ? 'Wait..' : 'Apply',
    style: TextStyle(
      color: Colours.CardColour,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
  ),
)),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: payFromWallet,
                          onChanged: (bool? value) {
                            setState(() {
                              payFromWallet = value!;
                            });
                            calculateTotalAmount(); 
                          },
                          activeColor: Colours.primaryColor,
                        ),
                        Text(
                          'Pay from wallet',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colours.black,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '₹${totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colours.black,
                      ),
                    )
                  ],
                ),
              ),
               SizedBox(height: screenHeight * 0.02),
              Divider(
                height: 1,
                color: Colours.textColour,
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
              SizedBox(height: screenHeight * 0.02),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total amount to pay',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colours.black,
                      ),
                    ),
                   Text(
                      '₹${totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colours.black,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.08),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Center(
                  child: ElevatedButton(
                onPressed: isProcessing || !payFromWallet
                        ? null
                        : () async {
                            setState(() {
                              isProcessing = true;
                            });
                       
                            final box = GetStorage();
                            final userId = box.read(LocalStorageConstants.userId).toString();
                            await walletBalanceController.getWalletBalanceUser(
                              context: context,
                              user_id: userId,
                            );
                            final walletBalance = walletBalanceController.walletBalanceModel?.walletBalance ?? 0.0;

                            if (walletBalance < totalAmount) {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colours.CardColour,
                                    title: Text(
                                      "Insufficient Balance",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colours.primaryColor,
                                      ),
                                    ),
                                    content: Text(
                                      "Your wallet balance is insufficient to complete this transaction.",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colours.primaryColor,
                                      ),
                                    ),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        child: Text(
                                          "Top Up",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colours.CardColour,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colours.primaryColor,
                                          minimumSize: Size(90, 40),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                           Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TopupPage(walletBalance: walletBalance),
            ));
                                        
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              final payWalletController = Get.find<PayWalletController>();
                              await payWalletController.getPayWalletUser(
                                context: context,
                                user_id: userId,
                                amount: totalAmount,
                                quiz_id: widget.quizId ?? '',
                                coupon_code: couponControllerText.text, 
              coupon_applied: couponControllerText.text.isNotEmpty, 
              amount_deducted: couponController.amountDeducted.value, 
                              );
                            setState(() {
                                isProcessing = false;
                              });
                            }
                          },
                          
                    style: ElevatedButton.styleFrom(
                      backgroundColor: payFromWallet ? Colours.primaryColor : Colors.grey,
                      minimumSize: Size(200, 50),
                    ),
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        color: Colours.CardColour,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
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
  }
}
