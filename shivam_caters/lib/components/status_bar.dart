import 'package:flutter/material.dart';
import '../utils/responsive_helper.dart';

class StatusBar extends StatelessWidget {
  final String? currentScreen;
  final String? statusMessage;
  final bool isLoading;
  final int? totalOrders;
  final int? pendingOrders;
  final int? completedOrders;

  const StatusBar({
    super.key,
    this.currentScreen,
    this.statusMessage,
    this.isLoading = false,
    this.totalOrders,
    this.pendingOrders,
    this.completedOrders,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ResponsiveHelper.getResponsiveValue(
        context,
        mobile: 24.0,
        tablet: 28.0,
        desktop: 32.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white, // White background
        border: Border(
          top: BorderSide(
            color: Colors.grey.withOpacity(0.3),
            width: 0.5,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left side - Screen info and status
          Expanded(
            child: Row(
              children: [
                // Current screen indicator
                if (currentScreen != null) ...[
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveHelper.getResponsiveValue(
                        context,
                        mobile: 6.0,
                        tablet: 8.0,
                        desktop: 10.0,
                      ),
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0E639C), // VS Code blue
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      currentScreen!.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ResponsiveHelper.getResponsiveFontSize(
                          context,
                          mobile: 10.0,
                          tablet: 11.0,
                          desktop: 12.0,
                        ),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
                    context,
                    mobile: 8.0,
                    tablet: 10.0,
                    desktop: 12.0,
                  )),
                ],
                
                // Status message
                if (statusMessage != null) ...[
                  Icon(
                    Icons.info_outline,
                    size: ResponsiveHelper.getResponsiveValue(
                      context,
                      mobile: 12.0,
                      tablet: 14.0,
                      desktop: 16.0,
                    ),
                    color: Colors.grey[600],
                  ),
                  SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
                    context,
                    mobile: 4.0,
                    tablet: 6.0,
                    desktop: 8.0,
                  )),
                  Text(
                    statusMessage!,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: ResponsiveHelper.getResponsiveFontSize(
                        context,
                        mobile: 10.0,
                        tablet: 11.0,
                        desktop: 12.0,
                      ),
                    ),
                  ),
                ],
                
                // Loading indicator
                if (isLoading) ...[
                  SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
                    context,
                    mobile: 8.0,
                    tablet: 10.0,
                    desktop: 12.0,
                  )),
                  SizedBox(
                    width: ResponsiveHelper.getResponsiveValue(
                      context,
                      mobile: 12.0,
                      tablet: 14.0,
                      desktop: 16.0,
                    ),
                    height: ResponsiveHelper.getResponsiveValue(
                      context,
                      mobile: 12.0,
                      tablet: 14.0,
                      desktop: 16.0,
                    ),
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.grey[600]!,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          
          // Right side - Statistics and info
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Total orders
              if (totalOrders != null) ...[
                _buildStatusItem(
                  context,
                  icon: Icons.shopping_cart_outlined,
                  label: 'Total',
                  value: totalOrders.toString(),
                  color: Colors.blue[300]!,
                ),
                SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
                  context,
                  mobile: 8.0,
                  tablet: 10.0,
                  desktop: 12.0,
                )),
              ],
              
              // Pending orders
              if (pendingOrders != null) ...[
                _buildStatusItem(
                  context,
                  icon: Icons.pending_outlined,
                  label: 'Pending',
                  value: pendingOrders.toString(),
                  color: Colors.orange[300]!,
                ),
                SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
                  context,
                  mobile: 8.0,
                  tablet: 10.0,
                  desktop: 12.0,
                )),
              ],
              
              // Completed orders
              if (completedOrders != null) ...[
                _buildStatusItem(
                  context,
                  icon: Icons.check_circle_outline,
                  label: 'Completed',
                  value: completedOrders.toString(),
                  color: Colors.green[300]!,
                ),
                SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
                  context,
                  mobile: 8.0,
                  tablet: 10.0,
                  desktop: 12.0,
                )),
              ],
              
              // Time
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveHelper.getResponsiveValue(
                    context,
                    mobile: 6.0,
                    tablet: 8.0,
                    desktop: 10.0,
                  ),
                  vertical: 2.0,
                ),
                child: Text(
                    _getCurrentTime(),
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: ResponsiveHelper.getResponsiveFontSize(
                        context,
                        mobile: 10.0,
                        tablet: 11.0,
                        desktop: 12.0,
                      ),
                      fontFamily: 'monospace',
                    ),
                  ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.getResponsiveValue(
          context,
          mobile: 6.0,
          tablet: 8.0,
          desktop: 10.0,
        ),
        vertical: 2.0,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(3),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: ResponsiveHelper.getResponsiveValue(
              context,
              mobile: 10.0,
              tablet: 12.0,
              desktop: 14.0,
            ),
            color: color,
          ),
          SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
            context,
            mobile: 3.0,
            tablet: 4.0,
            desktop: 5.0,
          )),
          Text(
            '$label: $value',
            style: TextStyle(
              color: color,
              fontSize: ResponsiveHelper.getResponsiveFontSize(
                context,
                mobile: 9.0,
                tablet: 10.0,
                desktop: 11.0,
              ),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }
}
