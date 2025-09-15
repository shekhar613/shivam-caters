import 'package:flutter/material.dart';
import 'sidebar.dart';
import 'status_bar.dart';
import '../utils/responsive_helper.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  final String title;
  final String currentScreen;
  final VoidCallback onPressed;
  final String? statusMessage;
  final bool isLoading;
  final int? totalOrders;
  final int? pendingOrders;
  final int? completedOrders;

  const MainLayout({
    super.key,
    required this.child,
    required this.title,
    required this.currentScreen,
    required this.onPressed,
    this.statusMessage,
    this.isLoading = false,
    this.totalOrders,
    this.pendingOrders,
    this.completedOrders,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {

  bool _isSidebarExpanded = true;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    return Scaffold(
      body: Row(
        children: [
          // Sidebar - Show only when expanded on tablet and desktop
          if ((isTablet || screenWidth >= 1024) && _isSidebarExpanded)
            Sidebar(
              isExpanded: _isSidebarExpanded,
              currentScreen: widget.currentScreen,
              onToggle: () {
                setState(() {
                  _isSidebarExpanded = !_isSidebarExpanded;
                });
              },
            ),
          
          // Main content area
          Expanded(
            child: Column(
              children: [
                // Top app bar
                Container(
                  height: isMobile ? 56 : 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Menu button - Show only when sidebar is closed or on mobile
                      if (isMobile || !_isSidebarExpanded)
                        Builder(
  builder: (context) {
    return IconButton(
      icon: Icon(Icons.menu),
      onPressed: () {
        if (isMobile) {
          Scaffold.of(context).openDrawer();
        } else {
          setState(() {
            _isSidebarExpanded = !_isSidebarExpanded;
          });
        }
      },
    );
  },
),

                      
                      // Logo and Title
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 16),
                          child: Row(
                            children: [
                              // Logo
                              Image.asset(
                                'assets/logo.png',
                                width: isMobile ? 24 : (isTablet ? 28 : 32),
                                height: isMobile ? 24 : (isTablet ? 28 : 32),
                                fit: BoxFit.contain,
                              ),
                              SizedBox(width: isMobile ? 8 : 12),
                              // Title
                              Expanded(
                                child: Text(
                                  widget.title,
                                  style: TextStyle(
                                    fontSize: isMobile ? 16 : (isTablet ? 18 : 20),
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF000047),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      // User actions
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              // TODO: Implement notifications
                            },
                            icon: Icon(
                              Icons.notifications_outlined,
                              size: isMobile ? 20 : 24,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // TODO: Implement user menu
                            },
                            icon: Icon(
                              Icons.account_circle_outlined,
                              size: isMobile ? 20 : 24,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Content
                Expanded(
                  child: widget.child,
                ),
                
                // Status Bar
                StatusBar(
                  currentScreen: widget.currentScreen,
                  statusMessage: widget.statusMessage,
                  isLoading: widget.isLoading,
                  totalOrders: widget.totalOrders,
                  pendingOrders: widget.pendingOrders,
                  completedOrders: widget.completedOrders,
                ),
              ],
            ),
          ),
        ],
      ),
      
      // Mobile drawer
      drawer: isMobile
          ? Drawer(
              child: Sidebar(
                isExpanded: true,
                currentScreen: widget.currentScreen,
                onToggle: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          : null,

          
          floatingActionButton: FloatingActionButton(
            heroTag: "main_fab",
            onPressed: widget.onPressed,
            backgroundColor: Color(0xFF8A8AFF),
            child: Icon(Icons.add),
            ),
        
    );
  }
}
