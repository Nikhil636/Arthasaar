import 'package:arthasaar/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> transactions = [
      {
        'id': 'TX12345',
        'payer': 'Alice',
        'receiver': 'Bob',
        'description': 'Payment for services',
        'amount': '\$150.00',
        'time': '10:30 AM'
      },
      {
        'id': 'TX12346',
        'payer': 'Charlie',
        'receiver': 'Daisy',
        'description': 'Refund for item',
        'amount': '\$50.00',
        'time': '11:15 AM'
      },
      // Add more transactions here
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions',
            style: Theme.of(context).textTheme.displaySmall),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            return TransactionContainer(
              transactionId: transaction['id']!,
              payer: transaction['payer']!,
              receiver: transaction['receiver']!,
              description: transaction['description']!,
              amount: transaction['amount']!,
              time: transaction['time']!,
            );
          },
        ),
      ),
    );
  }
}
