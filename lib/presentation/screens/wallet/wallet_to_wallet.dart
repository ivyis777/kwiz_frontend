
import 'package:RiddleQing/core/colors.dart';
import 'package:RiddleQing/core/form_validation/form_validation.dart';
import 'package:RiddleQing/core/storage_manager/local_storage_constants.dart';
import 'package:RiddleQing/gen/fonts.gen.dart';
import 'package:RiddleQing/presentation/screens/controller/wallet_balance_controller.dart';
import 'package:RiddleQing/presentation/screens/controller/wallet_transfer_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';



class WalletTransferPage extends StatefulWidget {
  final double? walletBalance;

  WalletTransferPage({Key? key, this.walletBalance}) : super(key: key);

  @override
  State<WalletTransferPage> createState() => _WalletTransferPageState();
}

class _WalletTransferPageState extends State<WalletTransferPage> {
   bool _isTransferring = false;

  final _formKey1 = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  double _totalTransferredAmount = 0.0;
  double? walletBalance = 0;
  late WalletBalanceController walletBalanceController;
  late WalletTransferController walletTransferController;

  @override
  void initState() {
    super.initState();
    walletBalance = widget.walletBalance;
    walletBalanceController = Get.find<WalletBalanceController>();
    walletTransferController = Get.put(WalletTransferController());
  }

  int _selectedIndex = 0;

  @override
  void dispose() {
    _amountController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _transferMoney() async {
     setState(() {
      _isTransferring = true; // Disable button when transfer starts
    });
    final box = GetStorage();
    final userId = box.read(LocalStorageConstants.userId).toString();

    if (_formKey1.currentState!.validate()) {
      try {
        double amount = double.parse(_amountController.text);
        final result = await walletTransferController.getWalletTransferUser(
          context: context,
          user_id: userId,
          amount: amount,
          to_email: _emailController.text,
        );

        if (result['status'] == '200') {
          setState(() {
            _totalTransferredAmount = amount;
            walletBalance = walletBalance! - _totalTransferredAmount.toInt();
          });

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: Text("Transfer Successful"),
                content: Text("₹$_totalTransferredAmount has been transferred successfully!"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop(); 
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        } else {
    //       Get.snackbar(
    //         "Transfer Failed",
    //         result['message'],
            
    //         backgroundColor: Colours.yellowcolor,
    //         colorText: Colors.white,
    //         snackPosition: SnackPosition.TOP,
    //       );
    //        messageText: Text(
    // result['message'],
    // style: TextStyle(
    //   fontSize: 18, 
    //   fontWeight: FontWeight.w400, 
    // ),
    //        );
        }
      } catch (e) {
        print('Failed transferring money: $e');
        Get.snackbar(
          "Transfer Failed",
          e.toString().contains('Status') ? e.toString() : "Unexpected error occurred",
          backgroundColor: Colours.yellowcolor,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
           messageText: Text(
  e.toString().contains('Status') ? e.toString() : "Unexpected error occurred",
    style: TextStyle(
      fontSize: 18, 
      fontWeight: FontWeight.w400, 
    ),
           )
           
        );
      }
  
    
  finally {
      setState(() {
        _isTransferring = false; // Re-enable button when transfer is complete
      });
    }}
    }
  Future<void> refreshWalletBalance() async {
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
    return  Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            "Wallet to Wallet",
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
          
          onRefresh: refreshWalletBalance,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Form(
              key: _formKey1,
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 100, 10, 50),
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
                                  'Wallet Balance:',
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
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter amount';
                                      }
                                      double? amount = double.tryParse(value);
                                      if (amount == null || amount < 10 || amount > 1000) {
                                        return 'Amount must be between ₹10 and ₹1000';
                                      }
                                      return null;
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
                                          ? 'Min amount is ₹10'
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
                                  'Total amount to be transferred',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colours.primaryColor,
                                    fontSize: 18.0,
                                    fontFamily: FontFamily.nunito,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Container(
                                  margin: EdgeInsets.fromLTRB(30, 10, 10, 10),
                                  child: TextFormField(
                                    controller: _emailController,
                                    validator: (value) {
                                      return FormValidation.emailValidation(value);
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Enter Email',
                                      labelStyle: TextStyle(
                                        color: Colours.cardTextColour,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 18.0,
                                      fontFamily: FontFamily.nunito,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 30),
                       child: ElevatedButton(
        onPressed: _isTransferring ? null : () async {
          await _transferMoney();
        },
                          child: Text(
                            "Transfer",
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
}
