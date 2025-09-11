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
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

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
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
          // Search and Filter Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border(
                bottom: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: Column(
              children: [
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search by Name, Category, Price, or Description...',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color(0xFF8A8AFF),
                      ),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, color: Colors.grey),
                              onPressed: () {
                                setState(() {
                                  _searchController.clear();
                                  _searchQuery = '';
                                });
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value.toLowerCase();
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16),
                // Filter Chips
                Row(
                  children: [
                    const Text(
                      'Filter by Category:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF000047),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _categories.map((category) {
                            final isSelected = _selectedCategory == category;
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: FilterChip(
                                label: Text(
                                  category,
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : const Color(0xFF8A8AFF),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                selected: isSelected,
                                onSelected: (selected) {
                                  setState(() {
                                    _selectedCategory = category;
                                  });
                                },
                                selectedColor: const Color(0xFF8A8AFF),
                                checkmarkColor: Colors.white,
                                backgroundColor: Colors.white,
                                side: BorderSide(
                                  color: const Color(0xFF8A8AFF).withOpacity(0.3),
                                ),
                                elevation: isSelected ? 2 : 0,
                                shadowColor: const Color(0xFF8A8AFF).withOpacity(0.3),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Results Count
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Showing ${_getFilteredMenuItems().length} menu items',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (_searchQuery.isNotEmpty || _selectedCategory != 'All')
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = '';
                            _selectedCategory = 'All';
                          });
                        },
                        icon: const Icon(Icons.clear_all, size: 16),
                        label: const Text('Clear All'),
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF8A8AFF),
                        ),
                      ),
                  ],
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

                // Apply search filter
                if (_searchQuery.isNotEmpty) {
                  dishes = dishes.where((dish) {
                    final nameMatch = dish.name.toLowerCase().contains(_searchQuery);
                    final categoryMatch = (dish.category ?? '').toLowerCase().contains(_searchQuery);
                    final priceMatch = dish.price.toString().contains(_searchQuery);
                    final descriptionMatch = (dish.portionSize ?? '').toLowerCase().contains(_searchQuery);
                    
                    return nameMatch || categoryMatch || priceMatch || descriptionMatch;
                  }).toList();
                }

                return Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: dishes.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No menu items found',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _searchQuery.isNotEmpty
                                    ? 'Try adjusting your search or filters'
                                    : 'No items match the selected criteria',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SingleChildScrollView(
                            child: DataTable(
                              columnSpacing: 20,
                              horizontalMargin: 16,
                              headingRowColor: MaterialStateProperty.all(
                                const Color(0xFF8A8AFF).withOpacity(0.1),
                              ),
                              columns: const [
                                DataColumn(
                                  label: Text(
                                    'ID',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF000047),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Name',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF000047),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Category',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF000047),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Price',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF000047),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Description',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF000047),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Availability',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF000047),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Prep Time',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF000047),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Actions',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF000047),
                                    ),
                                  ),
                                ),
                              ],
                              rows: dishes.map((dish) {
                                final item = {
                                  'id': dish.id.toString(),
                                  'name': dish.name,
                                  'category': dish.category ?? 'Uncategorized',
                                  'price': dish.price,
                                  'description': dish.portionSize ?? 'No description',
                                  'available': true, // You can add availability field to database
                                  'prepTime': '15 mins', // You can add prep time field to database
                                };
                                
                                return DataRow(
                                  cells: [
                                    DataCell(
                                      Text(
                                        item['id'].toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF000047),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        item['name'].toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF000047),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF8A8AFF).withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          item['category'].toString(),
                                          style: const TextStyle(
                                            color: Color(0xFF8A8AFF),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        '₹${item['price'].toString()}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF4CAF50),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      SizedBox(
                                        width: 200,
                                        child: Text(
                                          item['description'].toString(),
                                          style: const TextStyle(fontSize: 14),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: (item['available'] as bool) 
                                              ? const Color(0xFF4CAF50).withOpacity(0.1)
                                              : const Color(0xFFF44336).withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                            color: (item['available'] as bool) 
                                                ? const Color(0xFF4CAF50)
                                                : const Color(0xFFF44336),
                                          ),
                                        ),
                                        child: Text(
                                          (item['available'] as bool) ? 'Available' : 'Unavailable',
                                          style: TextStyle(
                                            color: (item['available'] as bool) 
                                                ? const Color(0xFF4CAF50)
                                                : const Color(0xFFF44336),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        item['prepTime'].toString(),
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    DataCell(
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.edit,
                                              size: 18,
                                              color: Color(0xFF8A8AFF),
                                            ),
                                            onPressed: () => _editMenuItem(item),
                                            tooltip: 'Edit Item',
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              (item['available'] as bool) ? Icons.visibility_off : Icons.visibility,
                                              size: 18,
                                              color: (item['available'] as bool) ? Colors.orange : Colors.green,
                                            ),
                                            onPressed: () => _toggleAvailability(item),
                                            tooltip: (item['available'] as bool) ? 'Make Unavailable' : 'Make Available',
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.delete,
                                              size: 18,
                                              color: Colors.red,
                                            ),
                                            onPressed: () => _deleteMenuItem(item),
                                            tooltip: 'Delete Item',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ),
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
