import 'package:arthasaar/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:arthasaar/constants/theme.dart'; // Make sure to import your theme file

class PoolCreationScreen extends StatefulWidget {
  const PoolCreationScreen({Key? key}) : super(key: key);

  @override
  _PoolCreationScreenState createState() => _PoolCreationScreenState();
}

class _PoolCreationScreenState extends State<PoolCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _poolNameController = TextEditingController();
  final TextEditingController _poolDescriptionController =
      TextEditingController();
  final List<TextEditingController> _memberControllers = [
    TextEditingController()
  ];
  // Method to add a new member text field
  void _addMemberField() {
    setState(() {
      _memberControllers.add(TextEditingController());
    });
  }

  // Method to save the pool data
  void _savePool() {
    if (_formKey.currentState!.validate()) {
      final poolName = _poolNameController.text;
      final poolDescription = _poolDescriptionController.text;
      final poolMembers =
          _memberControllers.map((controller) => controller.text).toList();

      print('Pool Name: $poolName');
      print('Pool Description: $poolDescription');
      print('Pool Members: $poolMembers');

      _poolNameController.clear();
      _poolDescriptionController.clear();
      _memberControllers.forEach((controller) => controller.clear());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Pool', style: textTheme.headlineMedium),
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
                    // Pool Name Field
                    InputField(
                      controller: _poolNameController,
                      label: 'Pool Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a pool name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),

                    // Pool Description Field
                    InputField(
                      controller: _poolDescriptionController,
                      label: 'Pool Description',
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),

                    // Pool Members Section
                    Text(
                      'Pool Members',
                      style: textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),

                    // Member Email Fields
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _memberControllers.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: InputField(
                            controller: _memberControllers[index],
                            label: 'Member ${index + 1} Email',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an email';
                              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                  .hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8.0),

                    // Add Member Button
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton.icon(
                        onPressed: _addMemberField,
                        icon: const Icon(Icons.add),
                        label: const Text('Add Member'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColorLight,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),

                    // Save Pool Button
                    Center(
                      child: ElevatedButton(
                        onPressed: _savePool,
                        child: const Text('Save Pool'),
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
