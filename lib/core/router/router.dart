import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ribaru_v2/features/auth/presentation/screens/login_screen.dart';
import 'package:ribaru_v2/features/auth/presentation/screens/register_screen.dart';
import 'package:ribaru_v2/features/auth/presentation/screens/verify_email_screen.dart';
import 'package:ribaru_v2/features/auth/services/auth_service.dart';
import 'package:ribaru_v2/features/inventory/presentation/screens/add_product_screen.dart';
import 'package:ribaru_v2/features/inventory/presentation/screens/inventory_screen.dart';
import 'package:ribaru_v2/features/inventory/presentation/screens/product_details_screen.dart';
import 'package:ribaru_v2/features/inventory/presentation/screens/stock_adjustment_screen.dart';
import 'package:ribaru_v2/features/user_management/presentation/screens/admin_dashboard_screen.dart';
import 'package:ribaru_v2/core/router/route_guard.dart';

final router = GoRouter(
  initialLocation: '/login',
  redirect: (context, state) async {
    return RouteGuard.guard(context, state);
  },
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/verify',
      builder: (context, state) => VerifyEmailScreen(
        token: state.uri.queryParameters['token'],
      ),
    ),
    GoRoute(
      path: '/inventory',
      builder: (context, state) => const InventoryScreen(),
      routes: [
        GoRoute(
          path: 'add',
          builder: (context, state) => const AddProductScreen(),
        ),
        GoRoute(
          path: 'product/:id',
          builder: (context, state) => ProductDetailsScreen(
            productId: state.pathParameters['id']!,
          ),
          routes: [
            GoRoute(
              path: 'stock',
              builder: (context, state) => StockAdjustmentScreen(
                productId: state.pathParameters['id']!,
              ),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/admin/dashboard',
      builder: (context, state) => const AdminDashboardScreen(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Page not found: ${state.error}'),
    ),
  ),
);
