import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Menu'),
        backgroundColor: const Color(0xFF8A8AFF),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildMenuCategory('Appetizers', [
            'Samosa (₹15 each)',
            'Pakora (₹20 each)',
            'Chicken Tikka (₹25 each)',
            'Paneer Tikka (₹20 each)',
          ]),
          const SizedBox(height: 20),
          _buildMenuCategory('Main Course', [
            'Butter Chicken (₹200)',
            'Dal Makhani (₹150)',
            'Biryani (₹180)',
            'Palak Paneer (₹120)',
            'Chicken Curry (₹180)',
          ]),
          const SizedBox(height: 20),
          _buildMenuCategory('Breads', [
            'Naan (₹25 each)',
            'Roti (₹10 each)',
            'Paratha (₹30 each)',
            'Kulcha (₹20 each)',
          ]),
          const SizedBox(height: 20),
          _buildMenuCategory('Desserts', [
            'Gulab Jamun (₹15 each)',
            'Ras Malai (₹20 each)',
            'Kheer (₹30)',
            'Ice Cream (₹40)',
          ]),
        ],
      ),
    );
  }

  Widget _buildMenuCategory(String title, List<String> items) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8A8AFF),
              ),
            ),
            const SizedBox(height: 12),
            ...items.map((item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const Icon(
                    Icons.circle,
                    size: 6,
                    color: Color(0xFF8A8AFF),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
