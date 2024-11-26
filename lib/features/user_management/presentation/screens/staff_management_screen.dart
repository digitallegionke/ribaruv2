import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ribaru_v2/features/user_management/domain/models/staff_member.dart';

class StaffManagementScreen extends StatefulWidget {
  const StaffManagementScreen({super.key});

  @override
  State<StaffManagementScreen> createState() => _StaffManagementScreenState();
}

class _StaffManagementScreenState extends State<StaffManagementScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  StaffRole _selectedRole = StaffRole.cashier;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _showAddStaffDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Staff Member'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  hintText: '254XXXXXXXXX',
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  if (!value.startsWith('254') || value.length != 12) {
                    return 'Invalid phone number format';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  if (!value.contains('@')) {
                    return 'Invalid email format';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<StaffRole>(
                value: _selectedRole,
                decoration: const InputDecoration(labelText: 'Role'),
                items: StaffRole.values.map((role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role.name.toUpperCase()),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedRole = value);
                  }
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                // TODO: Implement staff creation
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddStaffDialog,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Active Staff Section
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Active Staff',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                // TODO: Replace with actual staff list
                ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: const Text('John Doe'),
                  subtitle: const Text('Cashier'),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                      const PopupMenuItem(
                        value: 'deactivate',
                        child: Text('Deactivate'),
                      ),
                    ],
                    onSelected: (value) {
                      // TODO: Implement staff actions
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Inactive Staff Section
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Inactive Staff',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                // TODO: Replace with actual inactive staff list
                const ListTile(
                  leading: CircleAvatar(child: Icon(Icons.person_off)),
                  title: Text('Jane Smith'),
                  subtitle: Text('Manager (Inactive)'),
                  trailing: Icon(Icons.restore),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
