import 'package:flutter/material.dart';
// import 'navigation_helper.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Modern Hero Section
            Container(
              height: 100,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF8A8AFF), // Light purple
                    Color(0xFFB8B8FF), // Lighter purple
                  ],
                ),
              ),
              child: const Center(
                child: Text(
                  'Shivam Caters',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000047), // Dark blue
                  ),
                ),
              ),
            ),
            
            // Main Hero Section
            Container(
              height: 500,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFB8B8FF), // Lighter purple
                    Color(0xFFFFFFFF), // White
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8A8AFF).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF8A8AFF).withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.restaurant,
                        size: 100,
                        color: Color(0xFF000047),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Delicious Food for Every Occasion',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF000047),
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Professional catering services with fresh ingredients, custom menus, and exceptional service for your special events.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF000047),
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => {},
                          // NavigationHelper.navigateToMenu(context),
                          child: _buildActionButton(
                            'View Menu',
                            Icons.restaurant_menu,
                            const Color(0xFF8A8AFF),
                            const Color(0xFFFFFFFF),
                          ),
                        ),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: () => {},
                          //  NavigationHelper.navigateToContact(context),
                          child: _buildActionButton(
                            'Contact Us',
                            Icons.phone,
                            const Color(0xFF000047),
                            const Color(0xFFFFFFFF),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            // Features Section
            Container(
              padding: const EdgeInsets.all(40.0),
              decoration: const BoxDecoration(
                color: Color(0xFFFFFFFF),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Why Choose Shivam Caters?',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000047),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 100,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFF8A8AFF),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: _buildModernFeatureCard(
                          Icons.fastfood,
                          'Fresh Ingredients',
                          'We use only the freshest and highest quality ingredients for all our dishes.',
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildModernFeatureCard(
                          Icons.event_available,
                          'Custom Menus',
                          'Personalized menu options for weddings, corporate events, and special occasions.',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _buildModernFeatureCard(
                          Icons.delivery_dining,
                          'On-Time Delivery',
                          'Reliable and punctual delivery service to ensure your event runs smoothly.',
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildModernFeatureCard(
                          Icons.star,
                          'Experienced Team',
                          'Professional chefs and staff with years of experience in catering services.',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // CTA Section
            Container(
              padding: const EdgeInsets.all(60.0),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF8A8AFF),
                    Color(0xFFB8B8FF),
                  ],
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    'Ready to Make Your Event Special?',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000047),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Contact us today for a personalized quote and let us handle the catering for your special occasion.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF000047),
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () => {},
                    // NavigationHelper.navigateToContact(context),
                    child: _buildActionButton(
                      'Get Quote Now',
                      Icons.arrow_forward,
                      const Color(0xFF000047),
                      const Color(0xFFFFFFFF),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, IconData icon, Color backgroundColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: textColor, size: 20),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernFeatureCard(IconData icon, String title, String description) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8A8AFF).withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(
          color: const Color(0xFFB8B8FF).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF8A8AFF).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF8A8AFF),
              size: 32,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF000047),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF000047),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
