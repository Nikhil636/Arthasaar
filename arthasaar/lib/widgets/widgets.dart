import 'package:arthasaar/constants/theme.dart';
import 'package:flutter/material.dart';

Widget TransactionListTile({
  required IconData icon,
  required String recipient,
  required String pool,
  required String date,
  required String amount,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(
        vertical: 4, horizontal: 12.0), // Padding to give some space
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 32,
            ),
            SizedBox(width: 16), // Space between icon and text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Paid to: $recipient',
                  style: AppTheme.lightTextTheme.bodyLarge,
                ),
                Text(
                  'From pool: $pool',
                  style: AppTheme.lightTextTheme.bodySmall,
                ),
                Text(
                  'Date: $date',
                  style: AppTheme.lightTextTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
        Text(
          amount,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    ),
  );
}

Widget PoolListTile({
  required String poolName,
  required String poolBalance,
  required int membersCount,
  required String poolOwner,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Fixed size for Pool Name
        Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          width: 100,
          child: Text(
            poolName,
            style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis, // Handle overflow if needed
          ),
        ),

        // Members and Admin Columns
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Members Column
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Members',
                    style: AppTheme.lightTextTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4), // Space between heading and value
                  Text(
                    '$membersCount',
                    style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16), // Space between columns
              // Admin Column
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Admin',
                    style: AppTheme.lightTextTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4), // Space between heading and value
                  Text(
                    poolOwner,
                    style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Pool Balance
        SizedBox(
          child: Text(
            poolBalance,
            style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    ),
  );
}

class TransactionContainer extends StatelessWidget {
  final String transactionId;
  final String payer;
  final String receiver;
  final String description;
  final String amount;
  final String time;

  const TransactionContainer({
    Key? key,
    required this.transactionId,
    required this.payer,
    required this.receiver,
    required this.description,
    required this.amount,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? AppTheme.secondaryColorLight
            : AppTheme.primaryColorDark,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Transaction ID
          Row(
            children: [
              Icon(Icons.receipt, color: theme.primaryColor),
              SizedBox(width: 8.0),
              Text(
                'Transaction ID: ',
                style:
                    textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(transactionId, style: textTheme.bodyLarge),
            ],
          ),
          SizedBox(height: 8.0),

          // Payer and Receiver
          Row(
            children: [
              Icon(Icons.person, color: theme.primaryColor),
              SizedBox(width: 8.0),
              Text(
                'Payer: ',
                style:
                    textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              Expanded(child: Text(payer, style: textTheme.bodyMedium)),
            ],
          ),
          Row(
            children: [
              Icon(Icons.person_outline, color: theme.primaryColor),
              SizedBox(width: 8.0),
              Text(
                'Receiver: ',
                style:
                    textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              Expanded(child: Text(receiver, style: textTheme.bodyMedium)),
            ],
          ),
          SizedBox(height: 8.0),

          // Description
          Row(
            children: [
              Icon(Icons.description, color: theme.primaryColor),
              SizedBox(width: 8.0),
              Text(
                'Description: ',
                style:
                    textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              Expanded(child: Text(description, style: textTheme.bodySmall)),
            ],
          ),
          SizedBox(height: 8.0),

          // Amount
          Row(
            children: [
              Icon(Icons.attach_money, color: theme.primaryColor),
              SizedBox(width: 8.0),
              Text(
                'Amount: ',
                style: textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(amount,
                  style: textTheme.titleMedium
                      ?.copyWith(color: theme.primaryColor)),
            ],
          ),
          SizedBox(height: 8.0),

          // Time
          Row(
            children: [
              Icon(Icons.access_time, color: theme.primaryColor),
              SizedBox(width: 8.0),
              Text(
                'Time: ',
                style:
                    textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(time, style: textTheme.bodySmall),
            ],
          ),
        ],
      ),
    );
  }
}

class PoolContainer extends StatelessWidget {
  final String poolName;
  final String description;
  final String admin;
  final String poolBalance;
  final int poolMembers;

  const PoolContainer({
    Key? key,
    required this.poolName,
    required this.description,
    required this.admin,
    required this.poolBalance,
    required this.poolMembers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? AppTheme.secondaryColorLight
            : AppTheme.primaryColorDark,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pool Name
          Row(
            children: [
              Icon(Icons.pool, color: theme.primaryColor),
              SizedBox(width: 8.0),
              Text(
                poolName,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),

          // Description
          Row(
            children: [
              Icon(Icons.description, color: theme.primaryColor),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  description,
                  style: textTheme.bodySmall,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),

          // Admin
          Row(
            children: [
              Icon(Icons.person, color: theme.primaryColor),
              SizedBox(width: 8.0),
              Text(
                'Admin: ',
                style:
                    textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(admin, style: textTheme.bodyMedium),
            ],
          ),
          SizedBox(height: 8.0),

          // Pool Balance
          Row(
            children: [
              Icon(Icons.account_balance_wallet, color: theme.primaryColor),
              SizedBox(width: 8.0),
              Text(
                'Balance: ',
                style:
                    textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                poolBalance,
                style:
                    textTheme.bodyMedium?.copyWith(color: theme.primaryColor),
              ),
            ],
          ),
          SizedBox(height: 8.0),

          // Pool Members
          Row(
            children: [
              Icon(Icons.group, color: theme.primaryColor),
              SizedBox(width: 8.0),
              Text(
                'Members: ',
                style:
                    textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                '$poolMembers',
                style: textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget InputField({
  required TextEditingController controller,
  required String label,
  int maxLines = 1,
  String? Function(String?)? validator,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.9),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 6,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      ),
      validator: validator,
    ),
  );
}

// Helper method to build input fields with consistent styling
Widget paypagefield({
  required TextEditingController controller,
  required String label,
  int maxLines = 1,
  String? Function(String?)? validator,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.9),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 6,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      ),
      validator: validator,
    ),
  );
}
