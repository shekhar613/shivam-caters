import 'package:flutter/material.dart';
import 'package:shivam_caters/database/dao/order_dao.dart';
import 'package:shivam_caters/database/db_instance.dart';
import 'dashboard_screen.dart';
import 'order_management_screen.dart';
import 'add_order_screen.dart';
import 'billing_screen.dart';
import 'menu_management_screen.dart';
import 'inventory_screen.dart';

class NavigationHelper {
  static Future<dynamic> navigateToDashboard(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DashboardScreen()),
    );
  }

  // static Future<dynamic> navigateToOrders(BuildContext context) {
  //   return Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) =>  Ordertest()),
  //   );
  // }
  static Future<dynamic> navigateToOrders(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OrderManagementScreen()),
    );
  }

  static Future<dynamic> navigateToAddOrder(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddOrderScreen()),
    );
  }

   static void navigateToBilling(BuildContext context) {
     Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BillingScreen()),
    );

 
  }
   

   static Future<dynamic> navigateToMenuManagement(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MenuManagementScreen()),
    );
  }

  static  Future<dynamic> navigateToInventory(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const InventoryScreen()),
    );
  }
}
