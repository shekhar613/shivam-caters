import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:shivam_caters/components/add_inverntory_screen.dart';
import 'package:shivam_caters/database/app_database.dart';
import 'package:shivam_caters/database/db_instance.dart';
import 'main_layout.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Low Stock', 'Out of Stock', 'In Stock'];

  @override
  Widget build(BuildContext context) {
    
    return MainLayout(
      onPressed: _showAddInventoryDialog,
      title: 'Inventory Management',
      currentScreen: 'inventory',
      child: StreamBuilder<List<Stock>>(
        stream: db.select(db.stocks).watch(), // 🚀 Listen to DB changes
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final allItems = snapshot.data!;
          final filteredItems = _getFilteredItems(allItems);

          return Column(
            children: [
              // Summary Cards
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildSummaryCard(
                        'Total Items',
                        '${allItems.length}',
                        Icons.inventory,
                        const Color(0xFF8A8AFF),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildSummaryCard(
                        'Low Stock',
                        '${_getLowStockCount(allItems)}',
                        Icons.warning,
                        const Color(0xFFFF9800),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildSummaryCard(
                        'Out of Stock',
                        '${_getOutOfStockCount(allItems)}',
                        Icons.error,
                        const Color(0xFFF44336),
                      ),
                    ),
                  ],
                ),
              ),

              // Filter Section
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Text(
                      'Filter: ',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _filters.map((filter) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: FilterChip(
                                label: Text(filter),
                                selected: _selectedFilter == filter,
                                onSelected: (selected) {
                                  setState(() {
                                    _selectedFilter = filter;
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

              // Inventory Items List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];
                    return _buildInventoryCard(item);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 24, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  int _getLowStockCount(List<Stock> items) {
    return items
        .where((item) => item.availableQuantity <= item.minQuantity && item.availableQuantity > 0)
        .length;
  }

  int _getOutOfStockCount(List<Stock> items) {
    return items.where((item) => item.availableQuantity == 0).length;
  }

  List<Stock> _getFilteredItems(List<Stock> items) {
    switch (_selectedFilter) {
      case 'Low Stock':
        return items.where((item) => item.availableQuantity < item.minQuantity && item.availableQuantity > 0).toList();
      case 'Out of Stock':
        return items.where((item) => item.availableQuantity == 0).toList();
      case 'In Stock':
        return items.where((item) => item.availableQuantity >= item.minQuantity).toList();
      default:
        return items;
    }
  }

  Widget _buildInventoryCard(Stock item) {
    String stockStatus = _getStockStatus(item);
    Color statusColor = _getStatusColor(stockStatus);

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
                    item.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000047),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: statusColor),
                  ),
                  child: Text(
                    stockStatus,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Category: ${item.category}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Stock: ${item.availableQuantity}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF000047),
                      ),
                    ),
                    Text(
                      'Min Required: ${item.minQuantity}',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => _updateStock(item),
                      icon: const Icon(Icons.edit, color: Color(0xFF8A8AFF)),
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

  String _getStockStatus(Stock item) {
    if (item.availableQuantity == 0) {
      return 'Out of Stock';
    } else if (item.availableQuantity < item.minQuantity) {
      return 'Low Stock';
    } else {
      return 'In Stock';
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'In Stock':
        return Colors.green;
      case 'Low Stock':
        return Colors.orange;
      case 'Out of Stock':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showAddInventoryDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: SizedBox(width: 600, child: const Text('Add Stock Item')),
        content: const AddInverntoryScreen(),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  // Edit Stock Item
  void _updateStock(Stock stock) {
    final nameController = TextEditingController(text: stock.name);
    final minQuantityController = TextEditingController(text: stock.minQuantity.toString());
    var categoryController = TextEditingController(text: stock.category ?? '');
    final availableQuantityController = TextEditingController(text: stock.availableQuantity.toString());

    final List<String> _categories = ['Vegetables', 'Oil', 'Grains'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit ${stock.name}'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: "Stock Name")),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: categoryController.text.isEmpty ? null : categoryController.text,
                items: _categories.map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
                onChanged: (val) => categoryController.text = val!,
                decoration: const InputDecoration(labelText: "Category"),
              ),
              const SizedBox(height: 12),
              TextField(controller: availableQuantityController, decoration: const InputDecoration(labelText: "Available Stocks")),
              const SizedBox(height: 12),
              TextField(controller: minQuantityController, decoration: const InputDecoration(labelText: "Minimum Stock Quantity")),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () async {
              await (db.update(db.stocks)..where((t) => t.id.equals(stock.id))).write(
                StocksCompanion(
                  name: Value(nameController.text),
                  minQuantity: Value(double.tryParse(minQuantityController.text) ?? stock.minQuantity),
                  category: Value(categoryController.text),
                  availableQuantity: Value(double.tryParse(availableQuantityController.text) ?? stock.availableQuantity),
                ),
              );
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${stock.name} updated'), backgroundColor: Colors.green),
              );
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }
}
