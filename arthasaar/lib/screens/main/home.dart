import 'package:arthasaar/config.dart';
import 'package:arthasaar/constants/theme.dart';
import 'package:arthasaar/services/logout_services.dart';
import 'package:arthasaar/services/user_services.dart';
import 'package:arthasaar/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String balance = "Loading...";
  final UserService userService = UserService(); // Initialize UserService
  String userId = '';
  @override
  void initState() {
    super.initState();
    _getUserBalance();
    _getUserId();
  }

  Future<void> _getUserBalance() async {
    final fetchedBalance = await userService.fetchUserBalance();
    setState(() {
      balance = fetchedBalance;
    });
  }

  Future<void> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('user_id') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.red,
            ),
            onPressed: () => logoutUser(context), // Trigger logout when tapped
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            // Balance and qr containers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height / 6,
                  width: MediaQuery.sizeOf(context).width / 2.3,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                      color: AppTheme.primaryColorLight,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image(
                        image: AssetImage('assets/wallet.png'),
                        height: MediaQuery.sizeOf(context).height / 16,
                      ),
                      Text('Balance',
                          style: AppTheme.lightTextTheme.displaySmall),
                      Text(balance, style: AppTheme.lightTextTheme.bodyLarge)
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Show the QR code in a dialog when clicked
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("QR Code"),
                          content: Container(
                            width: 200.0,
                            height: 200.0,
                            child: QrImageView(
                              data: userId,
                              version: QrVersions.auto,
                              size: 200.0,
                              gapless: false,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Close'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    height: MediaQuery.sizeOf(context).height / 6,
                    width: MediaQuery.sizeOf(context).width / 2.3,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColorLight,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image(
                          image: AssetImage('assets/qr.png'),
                          height: MediaQuery.sizeOf(context).height / 16,
                        ),
                        Text('QR code'),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            // // Invite container
            // Container(
            //   height: MediaQuery.sizeOf(context).height / 8,
            //   width: MediaQuery.sizeOf(context).width,
            //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            //   decoration: BoxDecoration(
            //       color: AppTheme.secondaryColorDark,
            //       borderRadius: BorderRadius.circular(8)),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text('Pool Invites',
            //           style: AppTheme.lightTextTheme.displaySmall),
            //       Center(
            //         child: Text('You have no Invites',
            //             style: AppTheme.lightTextTheme.bodyLarge),
            //       ),
            //     ],
            //   ),
            // ),

            // SizedBox(height: 16),

            // Transactions container
            Container(
              height: MediaQuery.sizeOf(context).height / 3.5,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                color: AppTheme.secondaryColorDark,
                borderRadius: BorderRadius.circular(8),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                      context, '/transactions'); // Ensure this route exists
                },
                child: Column(
                  children: [
                    TransactionListTile(
                      icon: Icons.account_balance_wallet,
                      recipient: 'John Doe',
                      pool: 'Travel Fund',
                      date: '22 Oct 2024, 12:30 PM',
                      amount: '₹1500',
                    ),
                    Divider(color: Colors.white38),
                    TransactionListTile(
                      icon: Icons.account_balance_wallet,
                      recipient: 'Alice Smith',
                      pool: 'Grocery Fund',
                      date: '21 Oct 2024, 10:00 AM',
                      amount: '₹500',
                    ),
                    Divider(color: Colors.white38),
                    TransactionListTile(
                      icon: Icons.account_balance_wallet,
                      recipient: 'Bob Johnson',
                      pool: 'Party Fund',
                      date: '20 Oct 2024, 5:30 PM',
                      amount: '₹1200',
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),

            // Pools container
            Container(
              height: MediaQuery.sizeOf(context).height / 4.5,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                color: AppTheme.secondaryColorDark,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  PoolListTile(
                    poolName: 'Travel Fund',
                    poolBalance: '₹5000',
                    membersCount: 10,
                    poolOwner: 'Alice Smith',
                  ),
                  Divider(color: Colors.white38), // Divider between rows
                  PoolListTile(
                    poolName: 'Grocery Fund',
                    poolBalance: '₹3000',
                    membersCount: 5,
                    poolOwner: 'John Doe',
                  ),
                  Divider(color: Colors.white38),
                  PoolListTile(
                    poolName: 'Party Fund',
                    poolBalance: '₹1500',
                    membersCount: 3,
                    poolOwner: 'Bob Johnson',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
