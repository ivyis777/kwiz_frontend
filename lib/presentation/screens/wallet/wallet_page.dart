import 'package:Kwiz/core/colors.dart';
import 'package:Kwiz/data/models/wallet_balance_model.dart';
import 'package:Kwiz/gen/fonts.gen.dart';
import 'package:Kwiz/presentation/screens/controller/filter_button_controller.dart';
import 'package:Kwiz/presentation/screens/controller/wallet_balance_controller.dart';
import 'package:Kwiz/presentation/screens/wallet/banktransfer_page.dart';
import 'package:Kwiz/presentation/screens/wallet/topup_page.dart';
import 'package:Kwiz/presentation/screens/wallet/wallet_to_wallet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';




class WalletPage extends StatefulWidget {
  final String userId;
  final double? walletBalance;
  const WalletPage({Key? key, required this.userId, this.walletBalance}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
 late  double? walletBalance;
  late WalletBalanceController walletBalanceController;
  int _selectedIndex = 0;
  String selectedFilter = 'All';
  @override
  void initState() {
    super.initState();
    walletBalance = widget.walletBalance;
    walletBalanceController = Get.find<WalletBalanceController>();
  }

     Future<void> updateWalletBalance() async {
    try {
      await walletBalanceController.getWalletBalanceUser(
        context: context,
        user_id: widget.userId,
      );

      final updatedBalance = walletBalanceController.walletBalanceModel?.walletBalance;
      setState(() {
        walletBalance = updatedBalance as double?;
      });
    } catch (e) {
      print('Error updating wallet balance: $e');
    }
  }

  void transferFunds() {
    updateWalletBalance();
  }

  
   void _setFilter(String filter) {
    setState(() {
      selectedFilter = filter;
    });
  }



Map<String, List<dynamic>> getFilteredTransactions() {
  final walletBalanceModel = walletBalanceController.walletBalanceModel;
  if (walletBalanceModel == null) {
    return {};
  }

  List<dynamic> allTransactions = [];
  if (selectedFilter == 'All') {
    if (walletBalanceModel.debits != null) {
      allTransactions.addAll(walletBalanceModel.debits!);
    }
    if (walletBalanceModel.credits != null) {
      allTransactions.addAll(walletBalanceModel.credits!);
    }
  } else if (selectedFilter == 'Credited') {
    if (walletBalanceModel.credits != null) {
      allTransactions.addAll(walletBalanceModel.credits!);
    }
  } else if (selectedFilter == 'Debited') {
    if (walletBalanceModel.debits != null) {
      allTransactions.addAll(walletBalanceModel.debits!);
    }
  }

  allTransactions.sort((a, b) => b.dateTime!.compareTo(a.dateTime!));

  Map<String, List<dynamic>> bifurcatedTransactions = {
    'Today': [],
    'Yesterday': [],
  };

  final now = DateTime.now();
  final DateFormat monthFormat = DateFormat('MMMM yyyy');
  for (var transaction in allTransactions) {
    final transactionDate = transaction.dateTime;
    if (transactionDate != null) {
      if (transactionDate.year == now.year &&
          transactionDate.month == now.month &&
          transactionDate.day == now.day) {
        bifurcatedTransactions['Today']?.add(transaction);
      } else if (transactionDate.year == now.year &&
          transactionDate.month == now.month &&
          transactionDate.day == now.day - 1) {
        bifurcatedTransactions['Yesterday']?.add(transaction);
      } else {
        String monthName = monthFormat.format(transactionDate);
        if (!bifurcatedTransactions.containsKey(monthName)) {
          bifurcatedTransactions[monthName] = [];
        }
        bifurcatedTransactions[monthName]?.add(transaction);
      }
    }
  }

  return bifurcatedTransactions;
}


@override
Widget build(BuildContext context) {
  
  return Scaffold(
    
    appBar: AppBar(
      title: Text(
    
        "My Wallet",
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
    body:  RefreshIndicator(
        onRefresh: () async {
        print("Refresh triggered"); // Add a print to check if this is being called
        await updateWalletBalance();
        print("Wallet balance updated"); // Check if balance update is completing
      },
       
    child:Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 34, vertical: 38),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "₹$walletBalance",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 16),
                        ],
                      ),
                    ),
                  ],
                ),
                Text(
                  "Wallet Balance",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.blue[100],
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WalletTransferPage(walletBalance: walletBalance, )),
            );
                    
                      },
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(243, 245, 248, 1),
                                borderRadius: BorderRadius.all(Radius.circular(18)),
                              ),
                              child: Icon(Icons.compare_arrows_sharp, color: Colors.blue[900], size: 30),
                              padding: EdgeInsets.all(12),
                            ),
                            SizedBox(height: 4),
                            Text("Transfer", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.blue[100])),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                         Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>BankTransferPage(walletBalance: walletBalance)),
            );
                      },
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(243, 245, 248, 1),
                                borderRadius: BorderRadius.all(Radius.circular(18)),
                              ),
                              child: Icon(Icons.payment, color: Colors.blue[900], size: 30),
                              padding: EdgeInsets.all(12),
                            ),
                            SizedBox(height: 4),
                            Text("Payment", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.blue[100])),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                           Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>TopupPage(walletBalance: walletBalance)),
            );
                      
                      },
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(243, 245, 248, 1),
                                borderRadius: BorderRadius.all(Radius.circular(16)),
                              ),
                              child: Icon(Icons.add, color: Colors.blue[900], size: 30),
                              padding: EdgeInsets.all(12),
                            ),
                            SizedBox(height: 4),
                            Text("Top Up", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.blue[100])),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: DraggableScrollableSheet(
              initialChildSize: 0.65,
              minChildSize: 0.65,
              maxChildSize: 1,
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(243, 245, 248, 1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 24),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Recent Transactions",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 24,
                                color: Colors.black,
                              ),
                            ),
                           
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => _setFilter('All'),
                              child: FilterButton(
                                label: "All",
                                selected: selectedFilter == 'All',
                              ),
                            ),
                            SizedBox(width: 18),
                            GestureDetector(
                              onTap: () => _setFilter('Credited'),
                              child: FilterButton(
                                label: "Credited",
                                selected: selectedFilter == 'Credited',
                                iconColor: Colors.green,
                              ),
                            ),
                            SizedBox(width: 18),
                            GestureDetector(
                              onTap: () => _setFilter('Debited'),
                              child: FilterButton(
                                label: "Debited",
                                selected: selectedFilter == 'Debited',
                                iconColor: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                     SizedBox(height: 24),
Expanded(
  child: Obx(() {
    final bifurcatedTransactions = getFilteredTransactions();
    if (bifurcatedTransactions.isEmpty) {
      return Center(
        child: Text(
          "No transactions available",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.grey[800],
          ),
        ),
      );
    } else {
      return ListView.builder(
        controller: scrollController,
        itemCount: bifurcatedTransactions.length,
        itemBuilder: (context, index) {
          String period = bifurcatedTransactions.keys.elementAt(index);
          List<dynamic> transactions = bifurcatedTransactions[period]!;
             bool hasTransactions = transactions.isNotEmpty;
           return hasTransactions ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: Text(
                  period,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              Column(
                children: transactions.map((transaction) {
                  String formattedDate = 'Unknown Date';
                  String formattedTime = 'Unknown Time';
                  if (transaction.dateTime != null) {
                    formattedDate = DateFormat('dd/MM/yyyy').format(transaction.dateTime!);
                    formattedTime = DateFormat('hh:mm a').format(transaction.dateTime!);
                  }
                  String transactionType = transaction is Credits ? '+' : '-';
                  Color transactionColor = transaction is Credits ? Colors.green : Colors.red;
                  String orderID = '';
                  if (transaction is Debits) {
                    orderID = "Order_${transaction.transactionId}";
                  } else if (transaction is Credits) {
                    orderID = "Order_${transaction.transactionId}";
                  }
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.date_range,
                                color: Colours.primaryColor,
                                size: 16,
                              ),
                              SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    orderID,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.grey[900],
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  Text(
                                    transaction is Credits ? transaction.fromUsername ?? "Unknown" : transaction.to ?? "Unknown",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                  Text(
                                    "$formattedDate $formattedTime",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            "$transactionType ₹${transaction.amount}",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: transactionColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
            
           ) : Container(); 
          
        },
      );
    }
  }),
),



                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    )),

    );
  }
}
