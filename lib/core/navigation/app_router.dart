import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ribaru_v2/features/auth/presentation/screens/login_screen.dart';
import 'package:ribaru_v2/features/auth/presentation/screens/register_screen.dart';
import 'package:ribaru_v2/features/auth/presentation/screens/splash_screen.dart';
import 'package:ribaru_v2/features/inventory/presentation/screens/add_stock_screen.dart';
import 'package:ribaru_v2/features/inventory/presentation/screens/stock_details_screen.dart';
import 'package:ribaru_v2/features/inventory/presentation/screens/stock_list_screen.dart';
import 'package:ribaru_v2/features/pos/presentation/screens/cart_screen.dart';
import 'package:ribaru_v2/features/pos/presentation/screens/checkout_screen.dart';
import 'package:ribaru_v2/features/pos/presentation/screens/pos_screen.dart';
import 'package:ribaru_v2/features/reports/presentation/screens/reports_screen.dart';
import 'package:ribaru_v2/features/settings/presentation/screens/settings_screen.dart';
import 'package:ribaru_v2/features/shared/screens/dashboard_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    // Auth routes
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),

    // Main app shell
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return ScaffoldWithBottomNavBar(child: child);
      },
      routes: [
        // Dashboard
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => const DashboardScreen(),
          routes: [
            GoRoute(
              path: 'stock/:id',
              builder: (context, state) => StockDetailsScreen(
                stockId: state.pathParameters['id']!,
              ),
            ),
          ],
        ),

        // Inventory
        GoRoute(
          path: '/inventory',
          builder: (context, state) => const StockListScreen(),
          routes: [
            GoRoute(
              path: 'add',
              builder: (context, state) => const AddStockScreen(),
            ),
            GoRoute(
              path: ':id',
              builder: (context, state) => StockDetailsScreen(
                stockId: state.pathParameters['id']!,
              ),
            ),
          ],
        ),

        // POS
        GoRoute(
          path: '/pos',
          builder: (context, state) => const POSScreen(),
          routes: [
            GoRoute(
              path: 'cart',
              builder: (context, state) => const CartScreen(),
            ),
            GoRoute(
              path: 'checkout',
              builder: (context, state) => const CheckoutScreen(),
            ),
          ],
        ),

        // Reports
        GoRoute(
          path: '/reports',
          builder: (context, state) => const ReportsScreen(),
        ),

        // Settings
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],
);

class ScaffoldWithBottomNavBar extends StatelessWidget {
  final Widget child;

  const ScaffoldWithBottomNavBar({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            selectedIcon: Icon(Icons.inventory_2),
            label: 'Inventory',
          ),
          NavigationDestination(
            icon: Icon(Icons.point_of_sale_outlined),
            selectedIcon: Icon(Icons.point_of_sale),
            label: 'POS',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Reports',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              context.go('/dashboard');
              break;
            case 1:
              context.go('/inventory');
              break;
            case 2:
              context.go('/pos');
              break;
            case 3:
              context.go('/reports');
              break;
            case 4:
              context.go('/settings');
              break;
          }
        },
        selectedIndex: _calculateSelectedIndex(context),
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).location;
    if (location.startsWith('/dashboard')) return 0;
    if (location.startsWith('/inventory')) return 1;
    if (location.startsWith('/pos')) return 2;
    if (location.startsWith('/reports')) return 3;
    if (location.startsWith('/settings')) return 4;
    return 0;
  }
}
