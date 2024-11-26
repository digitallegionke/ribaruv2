import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ribaru_v2/features/auth/services/auth_service.dart';

class RouteGuard {
  static Future<String?> guard(BuildContext context, GoRouterState state) async {
    final user = await AuthService().getCurrentUser();
    
    // If not logged in, redirect to login
    if (user == null) {
      return '/login';
    }

    // If email not verified and not on verification page
    if (!user.isVerified && 
        !state.matchedLocation.startsWith('/verify-email')) {
      return '/verify-email';
    }

    // Admin routes protection
    if (state.matchedLocation.startsWith('/admin') && 
        user.role != 'admin') {
      return '/';
    }

    // Manager routes protection
    if (state.matchedLocation.startsWith('/manager') && 
        !['admin', 'manager'].contains(user.role)) {
      return '/';
    }

    // If trying to access auth pages while logged in
    if (['/login', '/register'].contains(state.matchedLocation)) {
      return '/';
    }

    return null;
  }

  static void redirectToLogin(BuildContext context) {
    context.go('/login');
  }

  static void redirectToHome(BuildContext context) {
    context.go('/');
  }

  static void redirectToVerification(BuildContext context) {
    context.go('/verify-email');
  }

  static bool isAdmin(String role) => role == 'admin';
  
  static bool isManager(String role) => 
      role == 'manager' || role == 'admin';
}
