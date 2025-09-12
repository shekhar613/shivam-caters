import 'package:flutter/material.dart';
import 'main_layout.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Low Stock', 'Out of Stock', 'In Stock'];

  // Sample inventory data
  final List<Map<String, dynamic>> _inventoryItems = [
    {
      'id': 'INV-001',
      'name': 'Chicken (kg)',
      'category': 'Meat',
      'currentStock': 15,
      'minStock': 10,
      'unit': 'kg',
      'lastUpdated': '2024-01-15',
      'supplier': 'Fresh Meat Co.',
    },
    {
      'id': 'INV-002',
      'name': 'Rice (kg)',
      'category': 'Grains',
      'currentStock': 5,
      'minStock': 20,
      'unit': 'kg',
      'lastUpdated': '2024-01-14',
      'supplier': 'Grain Suppliers',
    },
    {
      'id': 'INV-003',
      'name': 'Onions (kg)',
      'category': 'Vegetables',
      'currentStock': 0,
      'minStock': 5,
      'unit': 'kg',
      'lastUpdated': '2024-01-13',
      'supplier': 'Veggie Mart',
    },
    {
      'id': 'INV-004',
      'name': 'Cooking Oil (L)',
      'category': 'Cooking Essentials',
      'currentStock': 25,
      'minStock': 10,
      'unit': 'L',
      'lastUpdated': '2024-01-16',
      'supplier': 'Oil Distributors',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Inventory Management',
      currentScreen: 'inventory',
      child: Column(
        children: [
          // Summary Cards
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    'Total Items',
                    '${_inventoryItems.length}',
                    Icons.inventory,
                    const Color(0xFF8A8AFF),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSummaryCard(
                    'Low Stock',
                    '${_getLowStockCount()}',
                    Icons.warning,
                    const Color(0xFFFF9800),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSummaryCard(
                    'Out of Stock',
                    '${_getOutOfStockCount()}',
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
              itemCount: _getFilteredItems().length,
              itemBuilder: (context, index) {
                final item = _getFilteredItems()[index];
                return _buildInventoryCard(item);
              },
            ),
          ),
        ],
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

  int _getLowStockCount() {
    return _inventoryItems.where((item) => 
      item['currentStock'] < item['minStock'] && item['currentStock'] > 0
    ).length;
  }

  int _getOutOfStockCount() {
    return _inventoryItems.where((item) => item['currentStock'] == 0).length;
  }

  List<Map<String, dynamic>> _getFilteredItems() {
    switch (_selectedFilter) {
      case 'Low Stock':
        return _inventoryItems.where((item) => 
          item['currentStock'] < item['minStock'] && item['currentStock'] > 0
        ).toList();
      case 'Out of Stock':
        return _inventoryItems.where((item) => item['currentStock'] == 0).toList();
      case 'In Stock':
        return _inventoryItems.where((item) => 
          item['currentStock'] >= item['minStock']
        ).toList();
      default:
        return _inventoryItems;
    }
  }

  Widget _buildInventoryCard(Map<String, dynamic> item) {
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
                    item['name'],
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
              'Category: ${item['category']}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              'Supplier: ${item['supplier']}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              'Last Updated: ${item['lastUpdated']}',
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
                      'Current Stock: ${item['currentStock']} ${item['unit']}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF000047),
                      ),
                    ),
                    Text(
                      'Min Required: ${item['minStock']} ${item['unit']}',
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
                    IconButton(
                      onPressed: () => _addStock(item),
                      icon: const Icon(Icons.add_circle, color: Color(0xFF4CAF50)),
                    ),
                    IconButton(
                      onPressed: () => _removeStock(item),
                      icon: const Icon(Icons.remove_circle, color: Colors.orange),
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

  String _getStockStatus(Map<String, dynamic> item) {
    if (item['currentStock'] == 0) {
      return 'Out of Stock';
    } else if (item['currentStock'] < item['minStock']) {
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
        title: const Text('Add Inventory Item'),
        content: const Text('Inventory item creation form will be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Add Item'),
          ),
        ],
      ),
    );
  }

  void _updateStock(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Stock - ${item['name']}'),
        content: const Text('Stock update form will be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _addStock(Map<String, dynamic> item) {
    setState(() {
      item['currentStock'] += 10; // Add 10 units
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added 10 ${item['unit']} to ${item['name']}'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
    );
  }

  void _removeStock(Map<String, dynamic> item) {
    if (item['currentStock'] > 0) {
      setState(() {
        item['currentStock'] = (item['currentStock'] - 5).clamp(0, double.infinity);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Removed 5 ${item['unit']} from ${item['name']}'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }
}
