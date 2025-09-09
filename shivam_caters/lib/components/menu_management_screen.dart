import 'package:flutter/material.dart';
import 'package:shivam_caters/components/add_dish_screen.dart';
import 'package:shivam_caters/database/app_database.dart';
import 'package:shivam_caters/database/db_instance.dart';
import 'package:shivam_caters/utils/db_functions.dart';

class MenuManagementScreen extends StatefulWidget {
  const MenuManagementScreen({super.key});

  @override
  State<MenuManagementScreen> createState() => _MenuManagementScreenState();
}

class _MenuManagementScreenState extends State<MenuManagementScreen> {
  String _selectedCategory = 'All';
  final List<String> _categories = ['All', 'Appetizers', 'Main Course', 'Breads', 'Desserts'];
DbFunctions dbf = DbFunctions();
  // Sample menu data
  final List<Map<String, dynamic>> _menuItems = [
    {
      'id': 'MENU-001',
      'name': 'Samosa',
      'category': 'Appetizers',
      'price': 15,
      'description': 'Crispy fried pastry with spiced potato filling',
      'available': true,
      'prepTime': '15 mins',
    },
    {
      'id': 'MENU-002',
      'name': 'Butter Chicken',
      'category': 'Main Course',
      'price': 200,
      'description': 'Tender chicken in rich tomato and cream sauce',
      'available': true,
      'prepTime': '30 mins',
    },
    {
      'id': 'MENU-003',
      'name': 'Naan',
      'category': 'Breads',
      'price': 25,
      'description': 'Soft leavened flatbread baked in tandoor',
      'available': true,
      'prepTime': '10 mins',
    },
    {
      'id': 'MENU-004',
      'name': 'Gulab Jamun',
      'category': 'Desserts',
      'price': 15,
      'description': 'Soft milk dumplings in sugar syrup',
      'available': false,
      'prepTime': '20 mins',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Management'),
        backgroundColor: const Color(0xFF8A8AFF),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddMenuItemDialog(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Filter
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Text(
                  'Category: ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _categories.map((category) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text(category),
                            selected: _selectedCategory == category,
                            onSelected: (selected) {
                              setState(() {
                                _selectedCategory = category;
                              });
                            },
                            selectedColor: const Color(0xFF8A8AFF).withOpacity(0.3),
                            checkmarkColor: const Color(0xFF8A8AFF),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Menu Items List
          // Expanded(
          //   child: ListView.builder(
          //     padding: const EdgeInsets.all(16),
          //     itemCount: _getFilteredMenuItems().length,
          //     itemBuilder: (context, index) {
          //       final item = _getFilteredMenuItems()[index];
          //     
          //       // return _buildMenuItemCard(item);
          //     },
          //   ),
          // ),
          Expanded(
  child: StreamBuilder<List<Dishe>>(
    stream: db.select(db.dishes).watch(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return const Center(child: CircularProgressIndicator());
      }
      var dishes = snapshot.data!;

      // Apply category filter
      if (_selectedCategory != 'All') {
        dishes = dishes.where((d) => d.category == _selectedCategory).toList();
      }

      if (dishes.isEmpty) {
        return const Center(child: Text("No dishes found in this category."));
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: dishes.length,
        itemBuilder: (context, index) {
          final dish = dishes[index];
          return _buildMenuItemCard({
            'id': dish.id.toString(),
            'name': dish.name,
            'category': dish.category ?? 'Uncategorized',
            'price': dish.price,
            'description': dish.portionSize ?? 'No description',
            'available': true, 
            'prepTime': dish.prepTime, // you can add a field for this too
          });
        },
      );
    },
  ),
),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddMenuItemDialog(),
        backgroundColor: const Color(0xFF8A8AFF),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredMenuItems() {
    if (_selectedCategory == 'All') {
      return _menuItems;
    }
    return _menuItems.where((item) => item['category'] == _selectedCategory).toList();
  }

  Widget _buildMenuItemCard(Map<String, dynamic> item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    item['name'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000047),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: item['available'] 
                        ? const Color(0xFF4CAF50).withOpacity(0.1)
                        : const Color(0xFFF44336).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: item['available'] 
                          ? const Color(0xFF4CAF50)
                          : const Color(0xFFF44336),
                    ),
                  ),
                  child: Text(
                    item['available'] ? 'Available' : 'Unavailable',
                    style: TextStyle(
                      color: item['available'] 
                          ? const Color(0xFF4CAF50)
                          : const Color(0xFFF44336),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              item['description'],
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8A8AFF).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    item['category'],
                    style: const TextStyle(
                      color: Color(0xFF8A8AFF),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Prep: ${item['prepTime']}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Price: ₹${item['price'].toString()}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4CAF50),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => _editMenuItem(item),
                      icon: const Icon(Icons.edit, color: Color(0xFF8A8AFF)),
                    ),
                    IconButton(
                      onPressed: () => {},
                      icon: Icon(
                        item['available'] ? Icons.visibility_off : Icons.visibility,
                        color: item['available'] ? Colors.orange : Colors.green,
                      ),
                    ),
                    IconButton(
                      onPressed: () => _deleteMenuItem(item),
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAddMenuItemDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Menu Item'),
        content: const Text('Menu item creation form will be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => {
              Navigator.pop(context),
            Navigator.push(context, MaterialPageRoute(builder: (context)=> AddDishScreen()))},
            child: const Text('Add Item'),
          ),
        ],
      ),
    );
  }

  void _editMenuItem(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit ${item['name']}'),
        content: const Text('Menu item editing form will be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }

  

  void _deleteMenuItem(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Menu Item'),
        content: Text('Are you sure you want to delete "${item['name']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _menuItems.remove(item);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${item['name']} deleted'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
