import 'package:arthasaar/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:arthasaar/constants/theme.dart'; // Ensure your theme file is imported

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedPoolName;

  final List<String> _poolNames = [
    'Pool A',
    'Pool B',
    'Pool C',
    // Add more pool names as needed
  ];

  void _pay() {
    if (_formKey.currentState!.validate()) {
      final amount = _amountController.text;
      final description = _descriptionController.text;

      print('Amount: $amount');
      print('Description: $description');
      print('Selected Pool: $_selectedPoolName');

      // Reset fields
      _amountController.clear();
      _descriptionController.clear();
      setState(() {
        _selectedPoolName = null; // Reset dropdown
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment', style: textTheme.headlineMedium),
        backgroundColor: AppTheme.primaryColorLight,
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
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Amount Field
                    paypagefield(
                      controller: _amountController,
                      label: 'Enter Amount',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an amount';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid amount';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),

                    // Description Field
                    paypagefield(
                      controller: _descriptionController,
                      label: 'Description',
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),

                    // Pool Name Dropdown
                    DropdownButtonFormField<String>(
                      value: _selectedPoolName,
                      decoration: InputDecoration(
                        labelText: 'Select Pool',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      items: _poolNames.map((String poolName) {
                        return DropdownMenuItem<String>(
                          value: poolName,
                          child: Text(poolName),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedPoolName = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a pool';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24.0),

                    // Pay Button
                    Center(
                      child: ElevatedButton(
                        onPressed: _pay,
                        child: const Text('Pay'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 32.0),
                          backgroundColor: AppTheme.primaryColorLight,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
