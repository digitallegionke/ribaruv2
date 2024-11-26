import 'package:flutter/material.dart';
import 'package:ribaru_v2/core/theme/app_theme.dart';
import 'package:ribaru_v2/features/auth/models/user.dart';

class UserListItem extends StatelessWidget {
  final User user;
  final Function(String) onRoleChanged;
  final VoidCallback onDelete;

  const UserListItem({
    super.key,
    required this.user,
    required this.onRoleChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.email,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  color: AppColors.error,
                  onPressed: onDelete,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildStatusChip(),
                const SizedBox(width: 8),
                _buildRoleDropdown(),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Business: ${user.businessName}',
              style: const TextStyle(fontSize: 14),
            ),
            Text(
              'Joined: ${_formatDate(user.createdAt)}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip() {
    return Chip(
      label: Text(
        user.isVerified ? 'Verified' : 'Unverified',
        style: TextStyle(
          color: user.isVerified ? AppColors.success : AppColors.error,
        ),
      ),
      backgroundColor: user.isVerified
          ? AppColors.success.withOpacity(0.1)
          : AppColors.error.withOpacity(0.1),
    );
  }

  Widget _buildRoleDropdown() {
    return DropdownButton<String>(
      value: user.role,
      items: const [
        DropdownMenuItem(
          value: 'user',
          child: Text('User'),
        ),
        DropdownMenuItem(
          value: 'admin',
          child: Text('Admin'),
        ),
        DropdownMenuItem(
          value: 'manager',
          child: Text('Manager'),
        ),
      ],
      onChanged: (value) {
        if (value != null) {
          onRoleChanged(value);
        }
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
