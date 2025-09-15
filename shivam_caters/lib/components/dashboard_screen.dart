import 'package:flutter/material.dart';
import 'navigation_helper.dart';
import '../utils/responsive_helper.dart';
import 'main_layout.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
   
    return MainLayout(
      onPressed: (){},
      title: ResponsiveHelper.isMobile(context) 
        ? 'Dashboard' 
        : 'Shivam Caters - Management Dashboard',
      currentScreen: 'dashboard',
      statusMessage: 'System running smoothly',
      totalOrders: 127,
      pendingOrders: 8,
      completedOrders: 119,
      child: SingleChildScrollView(
        padding: ResponsiveHelper.getResponsivePadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Container(
              width: double.infinity,
              padding: ResponsiveHelper.getResponsivePadding(context),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF8A8AFF), Color(0xFFB8B8FF)],
                ),
                borderRadius: BorderRadius.circular(ResponsiveHelper.isMobile(context) ? 12 : 16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ResponsiveHelper.isMobile(context) 
                      ? 'Welcome to Dashboard' 
                      : 'Welcome to Management Dashboard',
                    style: TextStyle(
                      fontSize: ResponsiveHelper.getResponsiveFontSize(
                        context,
                        mobile: 22.0,
                        tablet: 28.0,
                        desktop: 32.0,
                      ),
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF000047),
                    ),
                  ),
                  SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
                    context,
                    mobile: 6.0,
                    tablet: 8.0,
                    desktop: 10.0,
                  )),
                  Text(
                    'Manage your catering business efficiently',
                    style: TextStyle(
                      fontSize: ResponsiveHelper.getResponsiveFontSize(
                        context,
                        mobile: 14.0,
                        tablet: 16.0,
                        desktop: 18.0,
                      ),
                      color: const Color(0xFF000047),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
              context,
              mobile: 20.0,
              tablet: 30.0,
              desktop: 40.0,
            )),
            
            // Quick Stats
            Text(
              'Quick Overview',
              style: TextStyle(
                fontSize: ResponsiveHelper.getResponsiveFontSize(
                  context,
                  mobile: 20.0,
                  tablet: 24.0,
                  desktop: 28.0,
                ),
                fontWeight: FontWeight.bold,
                color: const Color(0xFF000047),
              ),
            ),
            SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
              context,
              mobile: 12.0,
              tablet: 16.0,
              desktop: 20.0,
            )),
            
            // Responsive stats grid
            ResponsiveHelper.getResponsiveLayout(
              context,
              mobile: _buildMobileStatsGrid(context),
              tablet: _buildTabletStatsGrid(context),
              desktop: _buildDesktopStatsGrid(context),
            ),
            
            SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
              context,
              mobile: 20.0,
              tablet: 30.0,
              desktop: 40.0,
            )),
            
            // Management Sections
            // Text(
            //   'Management Tools',
            //   style: TextStyle(
            //     fontSize: ResponsiveHelper.getResponsiveFontSize(
            //       context,
            //       mobile: 20.0,
            //       tablet: 24.0,
            //       desktop: 28.0,
            //     ),
            //     fontWeight: FontWeight.bold,
            //     color: const Color(0xFF000047),
            //   ),
            // ),
            // SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
            //   context,
            //   mobile: 12.0,
            //   tablet: 16.0,
            //   desktop: 20.0,
            // )),
            
            // Responsive management cards
            // ResponsiveHelper.getResponsiveLayout(
            //   context,
            //   mobile: _buildMobileManagementCards(context),
            //   tablet: _buildTabletManagementCards(context),
            //   desktop: _buildDesktopManagementCards(context),
            // ),
          ],
        ),
      ),
    );
  }

  // Responsive grid layouts
  Widget _buildMobileStatsGrid(BuildContext context) {
    return Column(
      children: [
        _buildStatCard(
          context,
          'Pending Orders',
          '12',
          Icons.pending_actions,
          const Color(0xFF8A8AFF),
        ),
        const SizedBox(height: 12),
        _buildStatCard(
          context,
          'Today\'s Revenue',
          '₹25,406',
          Icons.currency_rupee_outlined,
          const Color(0xFF4CAF50),
        ),
        const SizedBox(height: 12),
        _buildStatCard(
          context,
          'Menu Items',
          '45',
          Icons.restaurant_menu,
          const Color(0xFFFF9800),
        ),
        const SizedBox(height: 12),
        _buildStatCard(
          context,
          'Low Stock Items',
          '3',
          Icons.warning,
          const Color(0xFFF44336),
        ),
      ],
    );
  }

  Widget _buildTabletStatsGrid(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                context,
                'Pending Orders',
                '12',
                Icons.pending_actions,
                const Color(0xFF8A8AFF),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                context,
                'Today\'s Revenue',
                '₹25,400',
                Icons.attach_money,
                const Color(0xFF4CAF50),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                context,
                'Menu Items',
                '45',
                Icons.restaurant_menu,
                const Color(0xFFFF9800),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                context,
                'Low Stock Items',
                '3',
                Icons.warning,
                const Color(0xFFF44336),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopStatsGrid(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context,
            'Pending Orders',
            '12',
            Icons.pending_actions,
            const Color(0xFF8A8AFF),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            context,
            'Today\'s Revenue',
            '₹25,400',
            Icons.currency_rupee_outlined,
            const Color(0xFF4CAF50),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            context,
            'Menu Items',
            '10',
            Icons.restaurant_menu,
            const Color(0xFFFF9800),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            context,
            'Low Stock Items',
            '3',
            Icons.warning,
            const Color(0xFFF44336),
          ),
        ),
      ],
    );
  }

  // Responsive management cards
  Widget _buildMobileManagementCards(BuildContext context) {
    return Column(
      children: [
        _buildManagementCard(
          context,
          'Order Management',
          'Track and manage all customer orders',
          Icons.shopping_cart,
          () => NavigationHelper.navigateToOrders(context),
        ),
        const SizedBox(height: 12),
        _buildManagementCard(
          context,
          'Billing & Invoices',
          'Generate invoices and track payments',
          Icons.receipt_long,
          () => NavigationHelper.navigateToBilling(context),
        ),
        const SizedBox(height: 12),
        _buildManagementCard(
          context,
          'Menu Management',
          'Add, edit, and organize menu items',
          Icons.restaurant,
          () => NavigationHelper.navigateToMenuManagement(context),
        ),
        const SizedBox(height: 12),
        _buildManagementCard(
          context,
          'Inventory Management',
          'Track stock levels and manage supplies',
          Icons.inventory,
          () => NavigationHelper.navigateToInventory(context),
        ),
      ],
    );
  }

  // ignore: unused_element
  Widget _buildTabletManagementCards(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildManagementCard(
                context,
                'Order Management',
                'Track and manage all customer orders',
                Icons.shopping_cart,
                () => NavigationHelper.navigateToOrders(context),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildManagementCard(
                context,
                'Billing & Invoices',
                'Generate invoices and track payments',
                Icons.receipt_long,
                () => NavigationHelper.navigateToBilling(context),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildManagementCard(
                context,
                'Menu Management',
                'Add, edit, and organize menu items',
                Icons.restaurant,
                () => NavigationHelper.navigateToMenuManagement(context),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildManagementCard(
                context,
                'Inventory Management',
                'Track stock levels and manage supplies',
                Icons.inventory,
                () => NavigationHelper.navigateToInventory(context),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ignore: unused_element
  Widget _buildDesktopManagementCards(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildManagementCard(
            context,
            'Order Management',
            'Track and manage all customer orders',
            Icons.shopping_cart,
            () => NavigationHelper.navigateToOrders(context),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildManagementCard(
            context,
            'Billing & Invoices',
            'Generate invoices and track payments',
            Icons.receipt_long,
            () => NavigationHelper.navigateToBilling(context),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildManagementCard(
            context,
            'Menu Management',
            'Add, edit, and organize menu items',
            Icons.restaurant,
            () => NavigationHelper.navigateToMenuManagement(context),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildManagementCard(
            context,
            'Inventory Management',
            'Track stock levels and manage supplies',
            Icons.inventory,
            () => NavigationHelper.navigateToInventory(context),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon, Color color) {
    return Container(
      padding: ResponsiveHelper.getResponsivePadding(context),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ResponsiveHelper.isMobile(context) ? 8 : 12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon, 
            size: ResponsiveHelper.getResponsiveValue(
              context,
              mobile: 24.0,
              tablet: 32.0,
              desktop: 40.0,
            ), 
            color: color,
          ),
          SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
            context,
            mobile: 8.0,
            tablet: 12.0,
            desktop: 16.0,
          )),
          Text(
            value,
            style: TextStyle(
              fontSize: ResponsiveHelper.getResponsiveFontSize(
                context,
                mobile: 18.0,
                tablet: 24.0,
                desktop: 28.0,
              ),
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
            context,
            mobile: 4.0,
            tablet: 6.0,
            desktop: 8.0,
          )),
          Text(
            title,
            style: TextStyle(
              fontSize: ResponsiveHelper.getResponsiveFontSize(
                context,
                mobile: 10.0,
                tablet: 12.0,
                desktop: 14.0,
              ),
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildManagementCard(BuildContext context, String title, String description, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: ResponsiveHelper.getResponsivePadding(context),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ResponsiveHelper.isMobile(context) ? 8 : 12),
          border: Border.all(
            color: const Color(0xFF8A8AFF).withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ResponsiveHelper.isMobile(context) 
          ? Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8A8AFF).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: const Color(0xFF8A8AFF),
                    size: ResponsiveHelper.getResponsiveValue(
                      context,
                      mobile: 20.0,
                      tablet: 24.0,
                      desktop: 28.0,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: ResponsiveHelper.getResponsiveFontSize(
                      context,
                      mobile: 16.0,
                      tablet: 18.0,
                      desktop: 20.0,
                    ),
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF000047),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: ResponsiveHelper.getResponsiveFontSize(
                      context,
                      mobile: 12.0,
                      tablet: 14.0,
                      desktop: 16.0,
                    ),
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            )
          : Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8A8AFF).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: const Color(0xFF8A8AFF),
                    size: ResponsiveHelper.getResponsiveValue(
                      context,
                      mobile: 20.0,
                      tablet: 24.0,
                      desktop: 28.0,
                    ),
                  ),
                ),
                SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
                  context,
                  mobile: 12.0,
                  tablet: 16.0,
                  desktop: 20.0,
                )),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: ResponsiveHelper.getResponsiveFontSize(
                            context,
                            mobile: 16.0,
                            tablet: 18.0,
                            desktop: 20.0,
                          ),
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF000047),
                        ),
                      ),
                      SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
                        context,
                        mobile: 4.0,
                        tablet: 6.0,
                        desktop: 8.0,
                      )),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: ResponsiveHelper.getResponsiveFontSize(
                            context,
                            mobile: 12.0,
                            tablet: 14.0,
                            desktop: 16.0,
                          ),
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: const Color(0xFF8A8AFF),
                  size: ResponsiveHelper.getResponsiveValue(
                    context,
                    mobile: 14.0,
                    tablet: 16.0,
                    desktop: 18.0,
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
