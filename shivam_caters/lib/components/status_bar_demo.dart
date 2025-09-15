import 'package:flutter/material.dart';
import 'main_layout.dart';
import '../utils/responsive_helper.dart';

class StatusBarDemo extends StatefulWidget {
  const StatusBarDemo({super.key});

  @override
  State<StatusBarDemo> createState() => _StatusBarDemoState();
}

class _StatusBarDemoState extends State<StatusBarDemo> {
  String _currentMessage = 'Ready';
  bool _isLoading = false;
  int _totalOrders = 50;
  int _pendingOrders = 15;
  int _completedOrders = 35;

  void _updateStatus(String message, {bool loading = false}) {
    setState(() {
      _currentMessage = message;
      _isLoading = loading;
    });

    // Simulate loading completion
    if (loading) {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _currentMessage = 'Operation completed successfully';
          });
        }
      });
    }
  }

  void _simulateOrderUpdate() {
    setState(() {
      _totalOrders++;
      _pendingOrders++;
    });
    _updateStatus('New order added', loading: true);
  }

  void _simulateOrderCompletion() {
    setState(() {
      _pendingOrders--;
      _completedOrders++;
    });
    _updateStatus('Order marked as completed', loading: true);
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      onPressed: () => Navigator.of(context).pop(),
      title: 'Status Bar Demo',
      currentScreen: 'status_demo',
      statusMessage: _currentMessage,
      isLoading: _isLoading,
      totalOrders: _totalOrders,
      pendingOrders: _pendingOrders,
      completedOrders: _completedOrders,
      child: SingleChildScrollView(
        padding: ResponsiveHelper.getResponsivePadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: ResponsiveHelper.getResponsivePadding(context),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1E1E1E), Color(0xFF2D2D2D)],
                ),
                borderRadius: BorderRadius.circular(ResponsiveHelper.isMobile(context) ? 12 : 16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Colors.white,
                        size: ResponsiveHelper.getResponsiveValue(
                          context,
                          mobile: 24.0,
                          tablet: 28.0,
                          desktop: 32.0,
                        ),
                      ),
                      SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
                        context,
                        mobile: 12.0,
                        tablet: 16.0,
                        desktop: 20.0,
                      )),
                      Expanded(
                        child: Text(
                          'Status Bar Demo',
                          style: TextStyle(
                            fontSize: ResponsiveHelper.getResponsiveFontSize(
                              context,
                              mobile: 20.0,
                              tablet: 24.0,
                              desktop: 28.0,
                            ),
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
                    context,
                    mobile: 8.0,
                    tablet: 12.0,
                    desktop: 16.0,
                  )),
                  Text(
                    'This demo shows how the status bar updates dynamically. Check the bottom of the screen to see the status bar in action.',
                    style: TextStyle(
                      fontSize: ResponsiveHelper.getResponsiveFontSize(
                        context,
                        mobile: 14.0,
                        tablet: 16.0,
                        desktop: 18.0,
                      ),
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
              context,
              mobile: 24.0,
              tablet: 32.0,
              desktop: 40.0,
            )),

            // Demo Controls
            Text(
              'Status Bar Controls',
              style: TextStyle(
                fontSize: ResponsiveHelper.getResponsiveFontSize(
                  context,
                  mobile: 18.0,
                  tablet: 20.0,
                  desktop: 22.0,
                ),
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2D3748),
              ),
            ),

            SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
              context,
              mobile: 16.0,
              tablet: 20.0,
              desktop: 24.0,
            )),

            // Control Buttons
            Wrap(
              spacing: ResponsiveHelper.getResponsiveSpacing(
                context,
                mobile: 8.0,
                tablet: 12.0,
                desktop: 16.0,
              ),
              runSpacing: ResponsiveHelper.getResponsiveSpacing(
                context,
                mobile: 8.0,
                tablet: 12.0,
                desktop: 16.0,
              ),
              children: [
                _buildControlButton(
                  context,
                  'Show Success',
                  Icons.check_circle,
                  Colors.green,
                  () => _updateStatus('Operation completed successfully!'),
                ),
                _buildControlButton(
                  context,
                  'Show Warning',
                  Icons.warning,
                  Colors.orange,
                  () => _updateStatus('Warning: Please check your input'),
                ),
                _buildControlButton(
                  context,
                  'Show Error',
                  Icons.error,
                  Colors.red,
                  () => _updateStatus('Error: Something went wrong'),
                ),
                _buildControlButton(
                  context,
                  'Show Loading',
                  Icons.refresh,
                  Colors.blue,
                  () => _updateStatus('Processing...', loading: true),
                ),
                _buildControlButton(
                  context,
                  'Add Order',
                  Icons.add_shopping_cart,
                  Colors.purple,
                  _simulateOrderUpdate,
                ),
                _buildControlButton(
                  context,
                  'Complete Order',
                  Icons.done_all,
                  Colors.teal,
                  _simulateOrderCompletion,
                ),
                _buildControlButton(
                  context,
                  'Clear Status',
                  Icons.clear,
                  Colors.grey,
                  () => _updateStatus('Ready'),
                ),
              ],
            ),

            SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
              context,
              mobile: 32.0,
              tablet: 40.0,
              desktop: 48.0,
            )),

            // Current Status Info
            Container(
              width: double.infinity,
              padding: ResponsiveHelper.getResponsivePadding(context),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(ResponsiveHelper.isMobile(context) ? 12 : 16),
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Status Information',
                    style: TextStyle(
                      fontSize: ResponsiveHelper.getResponsiveFontSize(
                        context,
                        mobile: 16.0,
                        tablet: 18.0,
                        desktop: 20.0,
                      ),
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2D3748),
                    ),
                  ),
                  SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
                    context,
                    mobile: 12.0,
                    tablet: 16.0,
                    desktop: 20.0,
                  )),
                  _buildStatusInfo(context, 'Message', _currentMessage),
                  _buildStatusInfo(context, 'Loading', _isLoading ? 'Yes' : 'No'),
                  _buildStatusInfo(context, 'Total Orders', _totalOrders.toString()),
                  _buildStatusInfo(context, 'Pending Orders', _pendingOrders.toString()),
                  _buildStatusInfo(context, 'Completed Orders', _completedOrders.toString()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.getResponsiveValue(
            context,
            mobile: 12.0,
            tablet: 16.0,
            desktop: 20.0,
          ),
          vertical: ResponsiveHelper.getResponsiveValue(
            context,
            mobile: 8.0,
            tablet: 10.0,
            desktop: 12.0,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildStatusInfo(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: ResponsiveHelper.getResponsiveSpacing(
          context,
          mobile: 4.0,
          tablet: 6.0,
          desktop: 8.0,
        ),
      ),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: ResponsiveHelper.getResponsiveFontSize(
                context,
                mobile: 12.0,
                tablet: 14.0,
                desktop: 16.0,
              ),
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: ResponsiveHelper.getResponsiveFontSize(
                context,
                mobile: 12.0,
                tablet: 14.0,
                desktop: 16.0,
              ),
              color: const Color(0xFF2D3748),
            ),
          ),
        ],
      ),
    );
  }
}
