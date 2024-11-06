// pool_list_screen.dart
import 'package:arthasaar/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PoolListScreen extends StatefulWidget {
  @override
  State<PoolListScreen> createState() => _PoolListScreenState();
}

class _PoolListScreenState extends State<PoolListScreen> {
  final List<Map<String, dynamic>> pools = [
    {
      'poolName': 'Vacation Fund',
      'description': 'A pool to save for our next beach vacation!',
      'admin': 'Alice',
      'poolBalance': '\$1,200',
      'poolMembers': 5,
    },
    {
      'poolName': 'Birthday Party',
      'description': 'Funds for organizing a surprise birthday party.',
      'admin': 'Bob',
      'poolBalance': '\$500',
      'poolMembers': 8,
    },
    {
      'poolName': 'Team Outing',
      'description': 'Contributions for the team outing next month.',
      'admin': 'Carol',
      'poolBalance': '\$900',
      'poolMembers': 10,
    },
    // Add more pools here if needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pool List'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.builder(
        itemCount: pools.length,
        itemBuilder: (context, index) {
          final pool = pools[index];
          return PoolContainer(
            poolName: pool['poolName'],
            description: pool['description'],
            admin: pool['admin'],
            poolBalance: pool['poolBalance'],
            poolMembers: pool['poolMembers'],
          );
        },
      ),
    );
  }
}
