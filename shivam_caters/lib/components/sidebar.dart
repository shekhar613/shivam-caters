import 'package:flutter/material.dart';
import 'navigation_helper.dart';
import '../utils/responsive_helper.dart';

class Sidebar extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onToggle;
  final String currentScreen;

  const Sidebar({
    super.key,
    required this.isExpanded,
    required this.onToggle,
    required this.currentScreen,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    
    // Responsive sidebar width - Only shown when expanded
    double sidebarWidth;
    if (isMobile) {
      sidebarWidth = screenWidth * 0.8; // 80% of screen width on mobile
    } else if (isTablet) {
      sidebarWidth = 200;
    } else {
      sidebarWidth = 250;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: sidebarWidth,
      decoration: BoxDecoration(
        color: const Color(0xFF8A8AFF),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header - Only show when expanded
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.restaurant,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'Shivam Caters',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: onToggle,
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 20,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
          
          // Navigation items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _buildNavItem(
                  context,
                  icon: Icons.dashboard,
                  title: 'Dashboard',
                  screenName: 'dashboard',
                  onTap: () => NavigationHelper.navigateToDashboard(context),
                ),
                _buildNavItem(
                  context,
                  icon: Icons.shopping_cart,
                  title: 'Orders',
                  screenName: 'orders',
                  onTap: () => NavigationHelper.navigateToOrders(context),
                ),
                _buildNavItem(
                  context,
                  icon: Icons.receipt_long,
                  title: 'Billing',
                  screenName: 'billing',
                  onTap: () => NavigationHelper.navigateToBilling(context),
                ),
                _buildNavItem(
                  context,
                  icon: Icons.restaurant,
                  title: 'Menu',
                  screenName: 'menu',
                  onTap: () => NavigationHelper.navigateToMenuManagement(context),
                ),
                _buildNavItem(
                  context,
                  icon: Icons.inventory,
                  title: 'Inventory',
                  screenName: 'inventory',
                  onTap: () => NavigationHelper.navigateToInventory(context),
                ),
                const SizedBox(height: 20),
                _buildNavItem(
                  context,
                  icon: Icons.settings,
                  title: 'Settings',
                  screenName: 'settings',
                  onTap: () {
                    // TODO: Implement settings navigation
                  },
                ),
                _buildNavItem(
                  context,
                  icon: Icons.help_outline,
                  title: 'Help',
                  screenName: 'help',
                  onTap: () {
                    // TODO: Implement help navigation
                  },
                ),
              ],
            ),
          ),
          
          // User profile section - Only show when expanded
          Container(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: isMobile ? 24 : 20,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: isMobile ? 24 : 20,
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Admin User',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: isMobile ? 16 : 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'admin@shivamcaters.com',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: isMobile ? 12 : 10,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String screenName,
    required VoidCallback onTap,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isSelected = currentScreen == screenName;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: Material(
        color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: isSelected ? Colors.white : Colors.white70,
                  size: isMobile ? 24 : 20,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                      fontSize: isMobile ? 16 : 14,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (isSelected) ...[
                  const SizedBox(width: 8),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
