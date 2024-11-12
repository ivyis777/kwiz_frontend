import 'dart:convert';

import 'package:RiddleQing/core/colors.dart';
import 'package:RiddleQing/core/storage_manager/local_storage_constants.dart';
import 'package:RiddleQing/data/app_url.dart';
import 'package:RiddleQing/data/models/response_screen_model.dart';
import 'package:RiddleQing/gen/fonts.gen.dart';
import 'package:RiddleQing/presentation/screens/controller/wallet_balance_controller.dart';
import 'package:RiddleQing/utils/secrets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TopupPage extends StatefulWidget {
  final double? walletBalance;
  TopupPage({Key? key, this.walletBalance}) : super(key: key);

  @override
  State<TopupPage> createState() => _TopupPageState();
}

class _TopupPageState extends State<TopupPage> {
    bool _isProcessing = false;
  final TextEditingController _amountController = TextEditingController();
  late WalletBalanceController walletBalanceController;
   double? walletBalance;
  double _totalTransferredAmount = 0.0;
  int _selectedIndex = 0;
  Razorpay? _razorpay;

  @override
  void initState() {
    super.initState();
    walletBalance = widget.walletBalance;
    walletBalanceController = Get.find<WalletBalanceController>();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _razorpay?.clear(); 
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: "Payment Successful");
    print("RazorSuccess : ${response.toString()}");
    print("RazorSuccess : ${response.paymentId ?? 'Unknown Payment ID'} -- ${response.orderId ?? 'Unknown Order ID'}");
   
    if (response.orderId == null) {
      debugPrint("Warning: response.orderId is null");
    }
    if (response.signature == null) {
      debugPrint("Warning: response.signature is null");
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Payment Error: ${response.code} - ${response.message ?? 'Unknown Error'}");
    print("RazorError : ${response.code.toString()} -- ${response.message ?? 'Unknown Error'}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "External Wallet: ${response.walletName ?? 'Unknown Wallet'}");
    print("RazorSuccess : ${response.walletName ?? 'Unknown Wallet'}");
  }

  void openPaymentPortal(RazorpayOrderResponse data) async {
    final box = GetStorage();
    final userId = box.read(LocalStorageConstants.userId)?.toString() ?? 'Unknown User';
    final username = box.read(LocalStorageConstants.username)?.toString() ?? 'Unknown User';
    final mobile = box.read(LocalStorageConstants.mobile) ?? 'Unknown Mobile';
    final double amount = double.tryParse(_amountController.text) ?? 0.0;

    if (data.data != null && data.data!.id != null) {
      print('data 1 : ${data.data!.id !}');
      print('data 2 : ${data.data!.id!}');
      var options = {
        'key': 'rzp_live_AxDgDAFAzWHZ1r',
        'amount': (amount * 100).toInt().toString(), 
        'name': username,
        'description': 'Payment',
        'prefill': {
          'contact': '9398923599',
          'email': box.read(LocalStorageConstants.userEmail) ?? 'Unknown Email',
        },
        'external': {
          'wallets': ['Gpay'],
        },
        'notes': {
          'user_id': userId,
        },
      };

      print("Options: $options");
      try {
        _razorpay?.open(options);
      } catch (e) {
        debugPrint("Error opening Razorpay: $e");
        Fluttertoast.showToast(msg: "Failed to open payment portal: $e");
      }
    } else {
      debugPrint("Order ID is null or invalid.");
      Fluttertoast.showToast(msg: "Failed to start payment: Order ID is null or invalid.");
    }
  }

  Future<dynamic> createOrder() async {
    var mapHeader = <String, String>{};
    mapHeader['Authorization'] = 'Basic ' + base64Encode(utf8.encode('$keyId:$keySecret'));
    mapHeader['Accept'] = "application/json";
    mapHeader['Content-Type'] = "application/x-www-form-urlencoded";

    var map = <String, String>{};
    setState(() {
      map['amount'] = "${(double.tryParse(_amountController.text) ?? 0.0 * 100).toInt()}";
    });
    map['currency'] = "INR";

    print("Requesting order creation with parameters: $map");

    try {
      var response = await http.post(Uri.parse(AppUrl.orderCreationURL), body: map, headers: mapHeader);

      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final box = GetStorage();
        box.write(LocalStorageConstants.sessionManager, true);
        RazorpayOrderResponse data = RazorpayOrderResponse.fromJson(json.decode(response.body));
        openPaymentPortal(data);
        print(data);

        return data;
      } else {
        Fluttertoast.showToast(msg: "Failed to create order: ${response.statusCode}");
      }
    } catch (e) {
      print("Error creating order: $e");
      Fluttertoast.showToast(msg: "Failed to create order: $e");
    }

    return null;
  }

  void _validateAmount() {
    final double amount = double.tryParse(_amountController.text) ?? 0.0;
    if (amount < 10 || amount > 1000) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text("Invalid Amount"),
            content: Text("Can't able to Top-up as the amount range must be between ₹100 and ₹1000 per day."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } else {
      _totalTransferredAmount = amount;
      _transferMoney();
    }
  }

  void _transferMoney() {
    createOrder().then((orderData) {
      if (orderData != null) {
        openPaymentPortal(orderData);
      }
    });
  }
 Future<void> _refreshData() async {
    final box = GetStorage();
    final userId = box.read(LocalStorageConstants.userId).toString();
    await walletBalanceController.getWalletBalanceUser(
      context: context,
      user_id: userId,
    );
    setState(() {
      walletBalance = walletBalanceController.walletBalanceModel?.walletBalance;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            "Quiz Credit Top-UP",
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
        backgroundColor: Colours.primaryColor,
        body: RefreshIndicator(
          onRefresh: _refreshData,
        child:SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(10, 150, 10, 50),
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 10, 20, 10),
                    child: Card(
                      elevation: 5,
                      shadowColor: Colors.grey,
                      color: Colours.CardColour,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Available Balance:',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            Text(
                              "₹$walletBalance",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 20, 20, 20),
                    child: Card(
                      color: Colours.CardColour,
                      elevation: 5,
                      shadowColor: Colors.grey,
                      child: Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(30, 10, 10, 10),
                              child: TextFormField(
                                controller: _amountController,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  labelText: 'Enter amount',
                                  labelStyle: TextStyle(
                                    color: Colours.cardTextColour,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                  prefixText: '₹',
                                  prefixStyle: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  errorText: _amountController.text.isNotEmpty &&
                                          (double.tryParse(_amountController.text) ?? 0.0) < 10
                                      ? 'Min amount is ₹100'
                                      : (double.tryParse(_amountController.text) ?? 0.0) > 1000
                                          ? 'Max amount is ₹1000'
                                          : null,
                                ),
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 18.0,
                                  fontFamily: FontFamily.nunito,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              'Total amount to be topped up',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colours.primaryColor,
                                fontSize: 18.0,
                                fontFamily: FontFamily.nunito,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 30),
      child: ElevatedButton(
        onPressed: _isProcessing ? null : () async {
          setState(() {
            _isProcessing = true; 
          });

          try {
            var RazorpayOrderResponse = await createOrder();
            if (RazorpayOrderResponse != null) {
              openPaymentPortal(RazorpayOrderResponse); 
            } else {
              Fluttertoast.showToast(msg: "Failed to create order.");
            }
          } finally {
            setState(() {
              _isProcessing = false;
            });
          }
        },
        child: Text(
          "Top Up",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: FontFamily.rubik,
            color: Colours.CardColour,
          ),
        ),
        style: ElevatedButton.styleFrom(
          fixedSize: Size(340, 50),
          backgroundColor: _totalTransferredAmount == 0.0 ? Colours.primaryColor : Colours.buttonColour,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    )
                ],
              ),
            ),
          ),
        ),),
        
         
        
      );
  
  }
}
