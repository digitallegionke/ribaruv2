import 'package:flutter/material.dart';
import 'package:ribaru_v2/core/theme/app_theme.dart';
import 'package:ribaru_v2/core/widgets/app_button.dart';
import 'package:ribaru_v2/features/auth/models/user.dart';
import 'package:ribaru_v2/features/auth/services/auth_service.dart';
import 'package:ribaru_v2/features/user_management/presentation/widgets/user_list_item.dart';
import 'package:ribaru_v2/features/user_management/presentation/widgets/user_search_bar.dart';
import 'package:ribaru_v2/features/user_management/services/audit_service.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  List<User> _users = [];
  List<User> _filteredUsers = [];
  bool _isLoading = true;
  String? _error;

  final _searchController = TextEditingController();
  String? _selectedRole;
  bool _showVerifiedOnly = false;

  final _auditService = AuditService();

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterUsers() {
    _filteredUsers = _users.where((user) {
      // Role filter
      if (_selectedRole != null && user.role != _selectedRole) {
        return false;
      }

      // Verification filter
      if (_showVerifiedOnly && !user.isVerified) {
        return false;
      }

      // Search text filter
      final searchText = _searchController.text.toLowerCase();
      if (searchText.isEmpty) {
        return true;
      }

      return user.name.toLowerCase().contains(searchText) ||
          user.email.toLowerCase().contains(searchText) ||
          user.businessName.toLowerCase().contains(searchText);
    }).toList();

    // Sort users by role importance and then by name
    _filteredUsers.sort((a, b) {
      final roleOrder = {'admin': 0, 'manager': 1, 'user': 2};
      final roleCompare = (roleOrder[a.role] ?? 2).compareTo(roleOrder[b.role] ?? 2);
      if (roleCompare != 0) return roleCompare;
      return a.name.compareTo(b.name);
    });

    setState(() {});
  }

  Future<void> _loadUsers() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final users = await AuthService().getAllUsers();
      setState(() {
        _users = users;
        _isLoading = false;
      });
      _filterUsers();
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _updateUserRole(User user, String newRole) async {
    try {
      await AuthService().updateUserRole(user.id, newRole);
      
      // Log the action
      final currentUser = await AuthService().getCurrentUser();
      await _auditService.logUserAction(
        action: 'role_updated',
        performedBy: currentUser!.id,
        targetUser: user.id,
        details: {
          'old_role': user.role,
          'new_role': newRole,
        },
      );
      
      await _loadUsers();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User role updated successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating user role: $e')),
        );
      }
    }
  }

  Future<void> _deleteUser(User user) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete User'),
        content: Text('Are you sure you want to delete ${user.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      await AuthService().deleteUser(user.id);
      
      // Log the action
      final currentUser = await AuthService().getCurrentUser();
      await _auditService.logUserAction(
        action: 'user_deleted',
        performedBy: currentUser!.id,
        targetUser: user.id,
        details: {
          'user_email': user.email,
          'user_role': user.role,
          'business_name': user.businessName,
        },
      );
      
      await _loadUsers();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User deleted successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting user: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _loadUsers,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _error!,
              style: const TextStyle(color: AppColors.error),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            AppButton(
              onPressed: _loadUsers,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        UserSearchBar(
          controller: _searchController,
          onChanged: (value) => _filterUsers(),
          onClear: () {
            _searchController.clear();
            _filterUsers();
          },
          selectedRole: _selectedRole,
          onRoleFilterChanged: (role) {
            setState(() => _selectedRole = role);
            _filterUsers();
          },
          showVerifiedOnly: _showVerifiedOnly,
          onVerifiedFilterChanged: (value) {
            setState(() => _showVerifiedOnly = value);
            _filterUsers();
          },
        ),
        Expanded(
          child: _filteredUsers.isEmpty
              ? const Center(
                  child: Text('No users found'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _filteredUsers.length,
                  itemBuilder: (context, index) {
                    final user = _filteredUsers[index];
                    return UserListItem(
                      user: user,
                      onRoleChanged: (role) => _updateUserRole(user, role),
                      onDelete: () => _deleteUser(user),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
