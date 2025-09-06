import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'order_management_screen.dart';
import 'billing_screen.dart';
import 'menu_management_screen.dart';
import 'inventory_screen.dart';

class NavigationHelper {
  static void navigateToDashboard(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DashboardScreen()),
    );
  }

  static void navigateToOrders(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OrderManagementScreen()),
    );
  }

  static void navigateToBilling(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BillingScreen()),
    );
  }

  static void navigateToMenuManagement(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MenuManagementScreen()),
    );
  }

  static void navigateToInventory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const InventoryScreen()),
    );
  }
}
