import 'package:flutter/material.dart';
import 'sidebar.dart';
import '../utils/responsive_helper.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  final String title;
  final String currentScreen;

  const MainLayout({
    super.key,
    required this.child,
    required this.title,
    required this.currentScreen,
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
                        IconButton(
                          onPressed: () {
                            if (isMobile) {
                              Scaffold.of(context).openDrawer();
                            } else {
                              setState(() {
                                _isSidebarExpanded = !_isSidebarExpanded;
                              });
                            }
                          },
                          icon: const Icon(Icons.menu),
                        ),
                      
                      // Title
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 16),
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
    );
  }
}
