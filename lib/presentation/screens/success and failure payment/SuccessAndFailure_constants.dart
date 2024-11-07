import 'package:Kwiz/core/colors.dart';
import 'package:Kwiz/presentation/screens/live_quizes/live_quizes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentResult extends StatelessWidget {
  final bool isSuccess;
  final String transactionId;
  final DateTime subtime;
  final amount;

  const PaymentResult({
    Key? key,
    required this.isSuccess,
    required this.transactionId,
    required this.subtime,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(amount);
    final formattedDate = DateFormat('dd MMM yyyy, hh:mm a').format(subtime);
    final double parsedAmount = double.tryParse(amount) ?? 0.0;
    final formattedAmount = NumberFormat.currency(symbol: '₹').format(parsedAmount);
  print('Amount passed: $amount');
    print('Parsed amount: $parsedAmount');
    return Scaffold(
      appBar: AppBar(
         
        foregroundColor: Colours.CardColour,
        
        backgroundColor: Colours.primaryColor,
        iconTheme: IconThemeData(
          color: Colours.CardColour,
        ),
        actions: [
          IconButton(
            onPressed: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LiveQuizPage()),
            ); 
              });
            },
            icon: Icon(Icons.cancel),
            color: Colours.CardColour,
          ),
        ],
      ),
      backgroundColor: Colours.CardColour,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Text(
            isSuccess ? 'Payment Successful' : 'Payment Failed',
            style: TextStyle(
              color: isSuccess ? Colors.green : Colors.red,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 60),
          Expanded(
            child: Card(
              color: Colours.CardColour,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 100),
                    Center(
                      child: Text(
                        'Payment Details',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Colours.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    _buildDetailRow('Transaction ID', transactionId),
                    _buildDivider(),
                    _buildDetailRow('Amount', formattedAmount),
                    _buildDivider(),
                    _buildDetailRow('Time', formattedDate),
                    _buildDivider(),
                    _buildDetailRow('Payment Method', 'Wallet'),
                    _buildDivider(),
                  ],
                ),
              ),
            ),
          ),
          if (!isSuccess)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); 
                },
                child: Text(
                  'Retry',
                  style: TextStyle(color: Colours.CardColour),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colours.primaryColor,
                  minimumSize: Size(200, 50),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colours.textColour,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colours.black,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Column(
      children: [
        SizedBox(height: 10),
        Container(
          height: 0.8,
          color: Colours.textColour,
          width: double.infinity,
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
