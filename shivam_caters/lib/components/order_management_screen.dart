import 'package:flutter/material.dart';

class OrderManagementScreen extends StatefulWidget {
  const OrderManagementScreen({super.key});

  @override
  State<OrderManagementScreen> createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Pending', 'Confirmed', 'In Progress', 'Completed', 'Cancelled'];

  // Sample order data
  final List<Map<String, dynamic>> _orders = [
    {
      'id': 'ORD-001',
      'customer': 'Rajesh Kumar',
      'event': 'Wedding Reception',
      'date': '2024-01-15',
      'status': 'Pending',
      'amount': 45000,
      'items': 25,
    },
    {
      'id': 'ORD-002',
      'customer': 'Priya Sharma',
      'event': 'Birthday Party',
      'date': '2024-01-16',
      'status': 'Confirmed',
      'amount': 15000,
      'items': 12,
    },
    {
      'id': 'ORD-003',
      'customer': 'Amit Singh',
      'event': 'Corporate Meeting',
      'date': '2024-01-17',
      'status': 'In Progress',
      'amount': 8000,
      'items': 8,
    },
    {
      'id': 'ORD-004',
      'customer': 'Sunita Devi',
      'event': 'Anniversary',
      'date': '2024-01-18',
      'status': 'Completed',
      'amount': 22000,
      'items': 15,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Management'),
        backgroundColor: const Color(0xFF8A8AFF),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddOrderDialog(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Section
          Container(
            padding: const EdgeInsets.all(16),
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
          
          // Orders List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _getFilteredOrders().length,
              itemBuilder: (context, index) {
                final order = _getFilteredOrders()[index];
                return _buildOrderCard(order);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddOrderDialog(),
        backgroundColor: const Color(0xFF8A8AFF),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredOrders() {
    if (_selectedFilter == 'All') {
      return _orders;
    }
    return _orders.where((order) => order['status'] == _selectedFilter).toList();
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    Color statusColor = _getStatusColor(order['status']);
    
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
                Text(
                  order['id'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000047),
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
                    order['status'],
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Customer: ${order['customer']}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            Text(
              'Event: ${order['event']}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              'Date: ${order['date']}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Amount: ₹${order['amount'].toString()}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4CAF50),
                  ),
                ),
                Text(
                  'Items: ${order['items']}',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _showOrderDetails(order),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8A8AFF),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('View Details'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _updateOrderStatus(order),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF8A8AFF),
                      side: const BorderSide(color: Color(0xFF8A8AFF)),
                    ),
                    child: const Text('Update Status'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Confirmed':
        return Colors.blue;
      case 'In Progress':
        return Colors.purple;
      case 'Completed':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showAddOrderDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Order'),
        content: const Text('Order creation form will be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Add Order'),
          ),
        ],
      ),
    );
  }

  void _showOrderDetails(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Order Details - ${order['id']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Customer: ${order['customer']}'),
            Text('Event: ${order['event']}'),
            Text('Date: ${order['date']}'),
            Text('Status: ${order['status']}'),
            Text('Amount: ₹${order['amount']}'),
            Text('Items: ${order['items']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _updateOrderStatus(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Order Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _filters.map((status) {
            return ListTile(
              title: Text(status),
              onTap: () {
                setState(() {
                  order['status'] = status;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
