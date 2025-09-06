import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
        backgroundColor: const Color(0xFF8A8AFF),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Icon(
                      Icons.restaurant,
                      size: 60,
                      color: Color(0xFF8A8AFF),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Shivam Caters',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8A8AFF),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Delicious Food for Every Occasion',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildContactInfo(Icons.phone, '+91 98765 43210'),
                    const SizedBox(height: 12),
                    _buildContactInfo(Icons.email, 'info@shivamcaters.com'),
                    const SizedBox(height: 12),
                    _buildContactInfo(Icons.location_on, '123 Main Street, City, State 12345'),
                    const SizedBox(height: 12),
                    _buildContactInfo(Icons.access_time, 'Mon-Sun: 9:00 AM - 10:00 PM'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle call action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8A8AFF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Call Now',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // Handle email action
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF8A8AFF),
                  side: const BorderSide(color: Color(0xFF8A8AFF)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Send Email',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF8A8AFF),
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
