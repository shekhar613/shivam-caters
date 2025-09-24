import 'dart:math';
import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import '../utils/responsive_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _rotationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize animation controllers
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    // Initialize animations
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.easeInOut,
    ));

    // Start animations
    _startAnimations();
    
    // Navigate to dashboard after 2 seconds
    _navigateToDashboard();
  }

  void _startAnimations() {
    _fadeController.forward();
    _scaleController.forward();
    _rotationController.repeat();
  }

  void _navigateToDashboard() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF8A8AFF), // Light purple
              Color(0xFFB8B8FF), // Lighter purple
              Color(0xFFFFFFFF), // White
            ],
            stops: [0.0, 0.6, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Animated background particles
            ...List.generate(5, (index) => _buildFloatingParticle(index)),
            
            // Main content
            Center(
              child: SingleChildScrollView(
                padding: ResponsiveHelper.getResponsivePadding(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animated Logo Container
                    AnimatedBuilder(
                      animation: Listenable.merge([_scaleAnimation, _rotationAnimation]),
                      builder: (context, child) {
                        final logoSize = ResponsiveHelper.getResponsiveValue(
                          context,
                          mobile: 100.0,
                          tablet: 120.0,
                          desktop: 140.0,
                        );
                        final iconSize = ResponsiveHelper.getResponsiveValue(
                          context,
                          mobile: 50.0,
                          tablet: 60.0,
                          desktop: 70.0,
                        );
                        
                        return Transform.scale(
                          scale: _scaleAnimation.value,
                          child: Transform.rotate(
                            angle: _rotationAnimation.value * 0.1, // Subtle rotation
                            child: Container(
                              width: logoSize,
                              height: logoSize,
                              decoration: BoxDecoration(
                                color: const Color(0xFF000047).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(logoSize / 2),
                                border: Border.all(
                                  color: const Color(0xFF8A8AFF),
                                  width: ResponsiveHelper.isMobile(context) ? 2 : 3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF8A8AFF).withOpacity(0.3),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: Image.asset(
                                'assets/logo.png',
                                width: iconSize,
                                height: iconSize,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    
                    SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
                      context,
                      mobile: 30.0,
                      tablet: 40.0,
                      desktop: 50.0,
                    )),
                    
                    // Animated Brand Name with typing effect
                    AnimatedBuilder(
                      animation: _fadeAnimation,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _fadeAnimation.value,
                          child: Column(
                            children: [
                              // Main Brand Name with gradient text
                              ShaderMask(
                                shaderCallback: (bounds) => const LinearGradient(
                                  colors: [
                                    Color(0xFF000047), // Dark blue
                                    Color(0xFF8A8AFF), // Light purple
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ).createShader(bounds),
                                child: Text(
                                  'SHIVAM CATERS',
                                  style: TextStyle(
                                    fontSize: ResponsiveHelper.getResponsiveFontSize(
                                      context,
                                      mobile: 28.0,
                                      tablet: 36.0,
                                      desktop: 42.0,
                                    ),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: ResponsiveHelper.isMobile(context) ? 2 : 3,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              
                              SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
                                context,
                                mobile: 12.0,
                                tablet: 16.0,
                                desktop: 20.0,
                              )),
                              
                              // Subtitle with fade effect
                              Text(
                                'Management System',
                                style: TextStyle(
                                  fontSize: ResponsiveHelper.getResponsiveFontSize(
                                    context,
                                    mobile: 14.0,
                                    tablet: 18.0,
                                    desktop: 20.0,
                                  ),
                                  color: const Color(0xFF000047).withOpacity(0.8),
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    
                    SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
                      context,
                      mobile: 40.0,
                      tablet: 60.0,
                      desktop: 80.0,
                    )),
                    
                    // Animated Loading Indicator with pulsing effect
                    AnimatedBuilder(
                      animation: Listenable.merge([_rotationAnimation, _scaleAnimation]),
                      builder: (context, child) {
                        final indicatorSize = ResponsiveHelper.getResponsiveValue(
                          context,
                          mobile: 40.0,
                          tablet: 50.0,
                          desktop: 60.0,
                        );
                        
                        return Transform.scale(
                          scale: 0.8 + (0.2 * _scaleAnimation.value),
                          child: SizedBox(
                            width: indicatorSize,
                            height: indicatorSize,
                            child: CircularProgressIndicator(
                              value: _rotationAnimation.value,
                              strokeWidth: ResponsiveHelper.isMobile(context) ? 3 : 4,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                const Color(0xFF8A8AFF).withOpacity(0.8),
                              ),
                              backgroundColor: const Color(0xFF8A8AFF).withOpacity(0.2),
                            ),
                          ),
                        );
                      },
                    ),
                    
                    SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
                      context,
                      mobile: 16.0,
                      tablet: 20.0,
                      desktop: 24.0,
                    )),
                    
                    // Loading Text with fade animation
                    AnimatedBuilder(
                      animation: _fadeAnimation,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _fadeAnimation.value,
                          child: Text(
                            'Loading...',
                            style: TextStyle(
                              fontSize: ResponsiveHelper.getResponsiveFontSize(
                                context,
                                mobile: 14.0,
                                tablet: 16.0,
                                desktop: 18.0,
                              ),
                              color: const Color(0xFF000047).withOpacity(0.7),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingParticle(int index) {
    return AnimatedBuilder(
      animation: _rotationController,
      builder: (context, child) {
        final double angle = (_rotationController.value * 2 * 3.14159) + (index * 1.2);
        final double radius = 80 + (index * 15);
        final double centerX = MediaQuery.of(context).size.width / 2;
        final double centerY = MediaQuery.of(context).size.height / 2;
        final double x = centerX + radius * cos(angle) - 4;
        final double y = centerY + radius * sin(angle) - 4;
        
        // Ensure particles stay within screen bounds
        final double clampedX = x.clamp(0, MediaQuery.of(context).size.width - 8);
        final double clampedY = y.clamp(0, MediaQuery.of(context).size.height - 8);
        
        return Positioned(
          left: clampedX,
          top: clampedY,
          child: Opacity(
            opacity: 0.3,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFF8A8AFF),
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
  }
}
