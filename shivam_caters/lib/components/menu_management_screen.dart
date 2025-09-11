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
          return _buildMenuItemCard(dish);
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

  
Widget _buildMenuItemCard(Dishe dish) {
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
                  dish.name,
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
                  color: (dish.isAvailable)
                      ? const Color(0xFF4CAF50).withOpacity(0.1)
                      : const Color(0xFFF44336).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: (dish.isAvailable)
                        ? const Color(0xFF4CAF50)
                        : const Color(0xFFF44336),
                  ),
                ),
                child: Text(
                  (dish.isAvailable) ? 'Available' : 'Unavailable',
                  style: TextStyle(
                    color: (dish.isAvailable)
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

          
          if (dish.category != null)
            Text(
              dish.category!,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            // ! This above code has to be removed because it has no effect as we are already displaying category below this
          const SizedBox(height: 8),
          Row(
            children: [
              if (dish.category != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8A8AFF).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    dish.category!,
                    style: const TextStyle(
                      color: Color(0xFF8A8AFF),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              const SizedBox(width: 8),
              if (dish.prepTime != null)
                Text(
                  'Prep: ${dish.prepTime}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Price: ₹${dish.price.toString()}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4CAF50),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => _editMenuItem(dish),
                    icon: const Icon(Icons.edit, color: Color(0xFF8A8AFF)),
                  ),
                  IconButton(
                    onPressed: () => dbf.toggleAvailability(dish, context),
                    icon: Icon(
                      (dish.isAvailable)
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: (dish.isAvailable)
                          ? Colors.orange
                          : Colors.green,
                    ),
                  ),
                  IconButton(
                    onPressed: () => _deleteMenuItem(dish),
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
        title: SizedBox(
          width: 600,
          child: const Text('Add Menu Item')),
        content: const AddDishScreen(),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          
        ],
      ),
    );
  }

  void _editMenuItem(Dishe dish) {
    final nameController = TextEditingController(text: dish.name);
  final categoryController = TextEditingController(text: dish.category ?? '');
  final priceController = TextEditingController(text: dish.price.toString());
  final portionController = TextEditingController(text: dish.portionSize ?? '');
  final prepTimeController = TextEditingController(text: dish.prepTime ?? '');
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Edit ${dish.name}'),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: "Name")),
            TextField(controller: categoryController, decoration: const InputDecoration(labelText: "Category")),
            TextField(controller: priceController, decoration: const InputDecoration(labelText: "Price"), keyboardType: TextInputType.number),
            TextField(controller: portionController, decoration: const InputDecoration(labelText: "Portion Size")),
            TextField(controller: prepTimeController, decoration: const InputDecoration(labelText: "Prep Time")),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: (){
            dbf.editDish(portionController, nameController, categoryController, priceController, prepTimeController, context, dish);
          },
          child: const Text('Save Changes'),
        ),
      ],
    ),
  );
}

  

 void _deleteMenuItem(Dishe dish) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Delete Menu Item'),
      content: Text('Are you sure you want to delete "${dish.name}"?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            await (db.delete(db.dishes)..where((t) => t.id.equals(dish.id))).go();

            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${dish.name} deleted'),
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
