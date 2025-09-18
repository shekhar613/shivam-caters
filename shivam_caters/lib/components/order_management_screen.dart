import 'package:flutter/material.dart';
import 'package:shivam_caters/database/app_database.dart';
import 'package:shivam_caters/database/dao/order_dao.dart';
import 'main_layout.dart';
import 'navigation_helper.dart';

class OrderManagementScreen extends StatefulWidget {
  const OrderManagementScreen({super.key});

  @override
  State<OrderManagementScreen> createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Pending', 'Confirmed', 'In Progress', 'Completed', 'Cancelled'];
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
final OrderDao orderDao = OrderDao(AppDatabase());
  // Sample order data
  // final List<Map<String, dynamic>> _orders = [
  //   {
  //     'id': 'ORD-001',
  //     'customer': 'Rajesh Kumar',
  //     'event': 'Wedding Reception',
  //     'date': '2024-01-15',
  //     'status': 'Pending',
  //     'amount': 45000,
  //     'advancePayment': 15000,
  //     'items': 25,
  //   },
  //   {
  //     'id': 'ORD-002',
  //     'customer': 'Priya Sharma',
  //     'event': 'Birthday Party',
  //     'date': '2024-01-16',
  //     'status': 'Confirmed',
  //     'amount': 15000,
  //     'advancePayment': 5000,
  //     'items': 12,
  //   },
  //   {
  //     'id': 'ORD-003',
  //     'customer': 'Amit Singh',
  //     'event': 'Corporate Meeting',
  //     'date': '2024-01-17',
  //     'status': 'In Progress',
  //     'amount': 8000,
  //     'advancePayment': 8000,
  //     'items': 8,
  //   },
  //   {
  //     'id': 'ORD-004',
  //     'customer': 'Sunita Devi',
  //     'event': 'Anniversary',
  //     'date': '2024-01-18',
  //     'status': 'Completed',
  //     'amount': 22000,
  //     'advancePayment': 10000,
  //     'items': 15,
  //   },
  //   {
  //     'id': 'ORD-005',
  //     'customer': 'Vikram Patel',
  //     'event': 'Engagement Ceremony',
  //     'date': '2024-02-14',
  //     'status': 'Pending',
  //     'amount': 75000,
  //     'advancePayment': 25000,
  //     'items': 35,
  //   },
  //   {
  //     'id': 'ORD-006',
  //     'customer': 'Meera Joshi',
  //     'event': 'Baby Shower',
  //     'date': '2024-02-20',
  //     'status': 'Confirmed',
  //     'amount': 12000,
  //     'advancePayment': 0,
  //     'items': 10,
  //   },
  //   {
  //     'id': 'ORD-007',
  //     'customer': 'Rohit Agarwal',
  //     'event': 'Graduation Party',
  //     'date': '2024-03-01',
  //     'status': 'In Progress',
  //     'amount': 18000,
  //     'advancePayment': 9000,
  //     'items': 18,
  //   },
  //   {
  //     'id': 'ORD-008',
  //     'customer': 'Kavita Reddy',
  //     'event': 'House Warming',
  //     'date': '2024-03-10',
  //     'status': 'Completed',
  //     'amount': 35000,
  //     'advancePayment': 20000,
  //     'items': 20,
  //   },
  // ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: orderDao.watchAllOrders(),
      builder: (context, snapshot) {
        final orders = snapshot.data ?? [];
        return MainLayout(
          onPressed: _showAddOrderDialog,
          title: 'Order Management',
          currentScreen: 'orders',
          statusMessage: 'Managing ${orders.length} orders',
          totalOrders: orders.length,
          pendingOrders: orders.where((order) => order.status == 'Pending').length,
          completedOrders: orders.where((order) => order.status == 'Completed').length,
          child: Column(
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
                          hintText: 'Search by Order ID, Customer, Event, Date, Amount, or Advance Payment...',
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
                          'Filter by Status:',
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
                              children: _filters.map((filter) {
                                final isSelected = _selectedFilter == filter;
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: FilterChip(
                                    label: Text(
                                      filter,
                                      style: TextStyle(
                                        color: isSelected ? Colors.white : const Color(0xFF8A8AFF),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    selected: isSelected,
                                    onSelected: (selected) {
                                      setState(() {
                                        _selectedFilter = filter;
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
                          'Showing ${_getFilteredOrders(orders).length} of ${orders.length} orders',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (_searchQuery.isNotEmpty || _selectedFilter != 'All')
                          TextButton.icon(
                            onPressed: () {
                              setState(() {
                                _searchController.clear();
                                _searchQuery = '';
                                _selectedFilter = 'All';
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
              
              // Orders Table
              Expanded(
                child: Container(
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
                  child: _getFilteredOrders(orders).isEmpty
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
                                'No orders found',
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
                                    : 'No orders match the selected criteria',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[500],
                                ),
                              ),
                              if (_searchQuery.isNotEmpty || _selectedFilter != 'All')
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: TextButton.icon(
                                    onPressed: () {
                                      setState(() {
                                        _searchController.clear();
                                        _searchQuery = '';
                                        _selectedFilter = 'All';
                                      });
                                    },
                                    icon: const Icon(Icons.clear_all, size: 16),
                                    label: const Text('Clear All Filters'),
                                    style: TextButton.styleFrom(
                                      foregroundColor: const Color(0xFF8A8AFF),
                                    ),
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
                              'Order ID',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF000047),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Customer',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF000047),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Event',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF000047),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Date',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF000047),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Status',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF000047),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Amount',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF000047),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Advance Payment',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF000047),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Items',
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
                        rows: _getFilteredOrders(orders)
                        .map((order) {
                          return DataRow(
                            cells: [
                              DataCell(
                                Text(
                                  order.id.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF000047),
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  order.customerName,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              DataCell(
                                Text(
                                  order.eventName,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              DataCell(
                                Text(
                                  order.eventDate.toString(),
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              DataCell(
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(order.status).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: _getStatusColor(order.status),
                                    ),
                                  ),
                                  child: Text(
                                    order.status,
                                    style: TextStyle(
                                      color: _getStatusColor(order.status),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  '₹${order.totalAmount.toString()}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4CAF50),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  '₹${order.advancePayment.toString()}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: order.advancePayment> 0 
                                        ? const Color(0xFF2196F3) 
                                        : Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  order.notes!,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              DataCell(
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.visibility,
                                        size: 18,
                                        color: Color(0xFF8A8AFF),
                                      ),
                                      onPressed: () => _showOrderDetails(order ),
                                      tooltip: 'View Details',
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.edit,
                                        size: 18,
                                        color: Color(0xFF8A8AFF),
                                      ),
                                      onPressed: () => _updateOrderStatus(order ),
                                      tooltip: 'Update Status'
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
                ),
              ),
            ],
          ),
        );
      }
    );
  }

 List<Order> _getFilteredOrders(List<Order> orders) {
  List<Order> filteredOrders = orders;

  // Apply status filter (assuming you have a `status` column in Orders table)
  if (_selectedFilter != 'All') {
    filteredOrders =
        filteredOrders.where((order) => order.status == _selectedFilter).toList();
  }

  // Apply search filter
  if (_searchQuery.isNotEmpty) {
    final query = _searchQuery.toLowerCase();
    filteredOrders = filteredOrders.where((order) {
      final idMatch = order.id.toString().toLowerCase().contains(query);
      final customerMatch = (order.customerName)
          .toLowerCase()
          .contains(query);
      final eventMatch = (order.eventName)
          .toLowerCase()
          .contains(query);
      final dateMatch = order.eventDate
          .toString()
          .toLowerCase()
          .contains(query);

      // Match on total amount
      final total = order.totalAmount.toString();
      final totalMatch = total.contains(query) ||
          total.replaceAll('₹', '').replaceAll(',', '').contains(query);

      // Match on advance
      final advance = order.advancePayment.toString();
      final advanceMatch = advance.contains(query) ||
          advance.replaceAll('₹', '').replaceAll(',', '').contains(query);

      return idMatch ||
          customerMatch ||
          eventMatch ||
          dateMatch ||
          totalMatch ||
          advanceMatch;
    }).toList();
  }

  return filteredOrders;
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
    NavigationHelper.navigateToAddOrder(context).then((_) {
      // Refresh the order list when returning from add order screen
      setState(() {
        // In a real app, you would refresh data from database here
      });
    });
  }

  void _showOrderDetails(Order order) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Order Details - ${order.id}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Customer: ${order.customerName}'),
          Text('Event: ${order.eventName}'),
          Text('Date: ${order.eventDate.toLocal().toString().split(" ").first}'),
          Text('Status: ${order.status ?? "Pending"}'),
          Text('Amount: ₹${order.totalAmount ?? 0}'),
          Text('Advance Payment: ₹${order.advancePayment ?? 0}'),
          // ⚡ If you want meal/dishes too:
          // you’ll fetch via DAO: orderDao.getMealsForOrder(order.id)
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

void _updateOrderStatus(Order order) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Update Order Status'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: _filters.map((status) {
          return ListTile(
            title: Text(status),
            onTap: () async {
              await orderDao.updateOrderStatus(order.id, status);

              // refresh UI immediately
              setState(() {});

              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    ),
  );
}

}
