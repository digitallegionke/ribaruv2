import 'package:flutter/material.dart';

class UserSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final VoidCallback onClear;
  final String? selectedRole;
  final Function(String?) onRoleFilterChanged;
  final bool showVerifiedOnly;
  final Function(bool) onVerifiedFilterChanged;

  const UserSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
    required this.selectedRole,
    required this.onRoleFilterChanged,
    required this.showVerifiedOnly,
    required this.onVerifiedFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    hintText: 'Search users by name, email, or business',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: controller.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: onClear,
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: selectedRole,
                  decoration: InputDecoration(
                    labelText: 'Role',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: null,
                      child: Text('All Roles'),
                    ),
                    DropdownMenuItem(
                      value: 'user',
                      child: Text('User'),
                    ),
                    DropdownMenuItem(
                      value: 'manager',
                      child: Text('Manager'),
                    ),
                    DropdownMenuItem(
                      value: 'admin',
                      child: Text('Admin'),
                    ),
                  ],
                  onChanged: onRoleFilterChanged,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CheckboxListTile(
                  title: const Text('Verified Only'),
                  value: showVerifiedOnly,
                  onChanged: (value) => onVerifiedFilterChanged(value ?? false),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
