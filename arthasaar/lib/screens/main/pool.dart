import 'package:arthasaar/constants/theme.dart';
import 'package:flutter/material.dart';

class PoolScreen extends StatefulWidget {
  const PoolScreen({Key? key}) : super(key: key);

  @override
  _PoolScreenState createState() => _PoolScreenState();
}

class _PoolScreenState extends State<PoolScreen> {
  // Static data for demonstration; replace with API integration later
  String poolName = 'Vacation Fund';
  String poolBalance = '\$1,200';
  String poolDescription = 'A pool to save for our next beach vacation!';
  List<String> poolMembers = ['Alice', 'Bob', 'Carol', 'David'];

  void _showAddMoneyDialog() {
    final TextEditingController _amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Money'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Enter Amount'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Here, you can handle the amount addition logic
                String enteredAmount = _amountController.text;
                // For demonstration, we can print the amount
                print('Amount to add: $enteredAmount');
                // Update the pool balance as necessary
                // (You may want to validate the amount and update the state)

                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: Text(poolName,
            style: textTheme.displayMedium?.copyWith(color: Colors.white)),
        backgroundColor: AppTheme.primaryColorLight,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryColorLight,
                  AppTheme.secondaryColorLight,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pool Balance Card
                _buildInfoCard(
                  context,
                  icon: Icons.account_balance_wallet,
                  title: 'Balance',
                  content: poolBalance,
                  color: AppTheme.primaryColorLight,
                ),
                const SizedBox(height: 16.0),

                // Pool Description Card
                _buildInfoCard(
                  context,
                  icon: Icons.description,
                  title: 'Description',
                  content: poolDescription,
                  color: AppTheme.secondaryColorLight,
                ),
                const SizedBox(height: 16.0),

                // Pool Members Card
                _buildInfoCard(
                  context,
                  icon: Icons.group,
                  title: 'Members',
                  content: '',
                  color: AppTheme.secondaryColorDark,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: poolMembers
                        .map((member) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Row(
                                children: [
                                  Icon(Icons.person, color: theme.primaryColor),
                                  const SizedBox(width: 8.0),
                                  Text(member, style: textTheme.bodyMedium),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // Bottom Button Row
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Add Money Button
            ElevatedButton.icon(
              onPressed: _showAddMoneyDialog,
              icon: const Icon(Icons.add),
              label: const Text('Add Money'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                textStyle: textTheme.labelLarge,
              ),
            ),
            // Scan QR Code Button
            ElevatedButton.icon(
              onPressed: () {
                // Placeholder for QR code scanning action
              },
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text('Scan QR Code'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                textStyle: textTheme.labelLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to create information cards with icon, title, and content
  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String content,
    Color? color,
    Widget? child,
  }) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(width: 8.0),
              Text(
                title,
                style: textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold, color: color),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          child ??
              Text(
                content,
                style: textTheme.bodyLarge?.copyWith(color: Colors.black87),
              ),
        ],
      ),
    );
  }
}
