
import 'package:RiddleQing/core/colors.dart';
import 'package:RiddleQing/core/storage_manager/local_storage_constants.dart';
import 'package:RiddleQing/gen/fonts.gen.dart';
import 'package:RiddleQing/presentation/screens/controller/wallet_balance_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';


class BankTransferPage extends StatefulWidget {
  final double? walletBalance; 
    BankTransferPage({Key? key, this.walletBalance}) : super(key: key);
  @override
  State<BankTransferPage> createState() => _BankTransferPageState();
}

class _BankTransferPageState extends State<BankTransferPage> {
  final TextEditingController _amountController = TextEditingController();
  bool _isUpiIdVisible = false; 
  int? _selectedPaymentMethod; 
  double _totalTransferredAmount = 0.0;
   int _selectedIndex = 0;
    double? walletBalance;
       late WalletBalanceController walletBalanceController; 

  @override
  void initState() {
    super.initState();
    walletBalance = widget.walletBalance;
        walletBalanceController = Get.find<WalletBalanceController>();
  }
void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
  Future<void> _refreshData() async {
    
    await walletBalanceController.getWalletBalanceUser(
      context: context,
      user_id: GetStorage().read(LocalStorageConstants.userId).toString(),
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
    "Money Transfer",
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
          
          child:Container(
              margin: EdgeInsets.fromLTRB(10, 20, 10, 40),
            child: Card(
            //  color: Colours.CardColour,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Card showing available balance
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
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Deposit to',
                        style: TextStyle(
                          color: Colours.primaryColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(15, 10, 20, 10),
                  child: Card(
                    color: Colours.CardColour,
                    elevation: 5,
                    shadowColor: Colors.grey,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(30, 10, 10, 10),
                      child: Row(
                        children: [
                          Radio(
                            value: 0,
                            groupValue: _selectedPaymentMethod,
                            onChanged: (value) {
                              setState(() {
                                _selectedPaymentMethod = value;
                              });
                            },
                          ),
                          Expanded(
                            child: Stack(
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Enter UPI Id',
                                  ),
                                  obscureText: !_isUpiIdVisible, // Hide text if !_isUpiIdVisible
                                ),
                                Positioned(
                                  right: 0,
                                  child: IconButton(
                                    icon: Icon(
                                      color: Colours.primaryColor,
                                      _isUpiIdVisible ? Icons.visibility : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isUpiIdVisible = !_isUpiIdVisible; // Toggle visibility
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 15, 20, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Add New Payment Method',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colours.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedPaymentMethod = 1;
                        });
                      },
                      child: Card(
                        elevation: 5,
                        shadowColor: Colors.grey,
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Icon(Icons.account_balance, color: Colours.primaryColor),
                              SizedBox(height: 10.0),
                              Text(
                                'Bank Account',
                                style: TextStyle(
                                  color: Colours.primaryColor,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedPaymentMethod = 2;
                        });
                      },
                      child: Card(
                        color: Colours.CardColour,
                        elevation: 5,
                        shadowColor: Colors.grey,
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Icon(Icons.payment, color: Colours.primaryColor),
                              SizedBox(height: 10.0),
                              Text(
                                'UPI Account',
                                style: TextStyle(
                                  color: Colours.primaryColor,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
               Container(
                 margin: EdgeInsets.fromLTRB(10, 10, 10, 30),
                 child: ElevatedButton(
                               onPressed: () {
                  if (_amountController.text.isNotEmpty) {
                    final double amount = double.tryParse(_amountController.text) ?? 0.0;
                    if (amount < 10 || amount > 1000) {
                      // Show an error message if the amount is invalid
                      print("Invalid Amount: Can't able to transfer as the amount range must be between ₹10 and ₹1000 per day.");
                    } else {
                      // Proceed with the transfer process
                      _totalTransferredAmount = amount;
                      _transferMoney();
                    }
                  } else {
                    // Show an error message if the amount field is empty
                    print("Amount Required: Please enter the amount to transfer.");
                  }
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
      ),),
        
    );
  }

  void _transferMoney() {
   
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
              },
              child: Text("OK"),
            ),
          ],
        );
        
      },
      
    );
    
  }
}
