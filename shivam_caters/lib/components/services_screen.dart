import 'package:flutter/material.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Services'),
        backgroundColor: const Color(0xFF8A8AFF),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildServiceCard(
            'Wedding Catering',
            'Complete wedding catering services with customizable menus and professional service.',
            Icons.favorite,
          ),
          const SizedBox(height: 16),
          _buildServiceCard(
            'Corporate Events',
            'Business meeting catering, conferences, and corporate celebrations.',
            Icons.business,
          ),
          const SizedBox(height: 16),
          _buildServiceCard(
            'Birthday Parties',
            'Fun and delicious food for birthday celebrations of all ages.',
            Icons.cake,
          ),
          const SizedBox(height: 16),
          _buildServiceCard(
            'Anniversary Celebrations',
            'Special anniversary catering with elegant presentation and service.',
            Icons.celebration,
          ),
          const SizedBox(height: 16),
          _buildServiceCard(
            'Festival Catering',
            'Traditional festival food for Diwali, Holi, and other celebrations.',
            Icons.festival,
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(String title, String description, IconData icon) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
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
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8A8AFF),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
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
}
