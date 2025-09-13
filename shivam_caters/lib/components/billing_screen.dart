import 'package:flutter/material.dart';
import 'main_layout.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({super.key});

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Pending', 'Paid', 'Overdue'];
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Sample billing data
  final List<Map<String, dynamic>> _invoices = [
    {
      'id': 'INV-001',
      'customer': 'Rajesh Kumar',
      'orderId': 'ORD-001',
      'amount': 45000,
      'status': 'Paid',
      'date': '2024-01-15',
      'dueDate': '2024-01-15',
    },
    {
      'id': 'INV-002',
      'customer': 'Priya Sharma',
      'orderId': 'ORD-002',
      'amount': 15000,
      'status': 'Pending',
      'date': '2024-01-16',
      'dueDate': '2024-01-23',
    },
    {
      'id': 'INV-003',
      'customer': 'Amit Singh',
      'orderId': 'ORD-003',
      'amount': 8000,
      'status': 'Overdue',
      'date': '2024-01-10',
      'dueDate': '2024-01-17',
    },
    {
      'id': 'INV-004',
      'customer': 'Sunita Devi',
      'orderId': 'ORD-004',
      'amount': 22000,
      'status': 'Paid',
      'date': '2024-01-18',
      'dueDate': '2024-01-18',
    },
    {
      'id': 'INV-005',
      'customer': 'Vikram Patel',
      'orderId': 'ORD-005',
      'amount': 75000,
      'status': 'Pending',
      'date': '2024-02-14',
      'dueDate': '2024-02-21',
    },
    {
      'id': 'INV-006',
      'customer': 'Meera Joshi',
      'orderId': 'ORD-006',
      'amount': 12000,
      'status': 'Paid',
      'date': '2024-02-20',
      'dueDate': '2024-02-20',
    },
    {
      'id': 'INV-007',
      'customer': 'Rohit Agarwal',
      'orderId': 'ORD-007',
      'amount': 18000,
      'status': 'Overdue',
      'date': '2024-02-25',
      'dueDate': '2024-03-01',
    },
    {
      'id': 'INV-008',
      'customer': 'Kavita Reddy',
      'orderId': 'ORD-008',
      'amount': 35000,
      'status': 'Paid',
      'date': '2024-03-10',
      'dueDate': '2024-03-10',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      onPressed: _showCreateInvoiceDialog,
      title: 'Billing & Invoices',
      currentScreen: 'billing',
      child: Column(
        children: [
          // Summary Cards
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    'Total Revenue',
                    '₹90,000',
                    Icons.attach_money,
                    const Color(0xFF4CAF50),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSummaryCard(
                    'Pending Amount',
                    '₹23,000',
                    Icons.pending,
                    const Color(0xFFFF9800),
                  ),
                ),
              ],
            ),
          ),
          
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
                      hintText: 'Search by Invoice ID, Customer, Order ID, Amount, or Date...',
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
                      'Showing ${_getFilteredInvoices().length} of ${_invoices.length} invoices',
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
          
          // Invoices List
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
              child: _getFilteredInvoices().isEmpty
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
                            'No invoices found',
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
                                : 'No invoices match the selected criteria',
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
                                'Invoice ID',
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
                                'Order ID',
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
                                'Status',
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
                                'Due Date',
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
                          rows: _getFilteredInvoices().map((invoice) {
                            return DataRow(
                              cells: [
                                DataCell(
                                  Text(
                                    invoice['id'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF000047),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    invoice['customer'],
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    invoice['orderId'],
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    '₹${invoice['amount'].toString()}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF4CAF50),
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
                                      color: _getStatusColor(invoice['status']).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: _getStatusColor(invoice['status']),
                                      ),
                                    ),
                                    child: Text(
                                      invoice['status'],
                                      style: TextStyle(
                                        color: _getStatusColor(invoice['status']),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    invoice['date'],
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    invoice['dueDate'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: invoice['status'] == 'Overdue' 
                                          ? Colors.red 
                                          : Colors.grey[600],
                                      fontWeight: invoice['status'] == 'Overdue' 
                                          ? FontWeight.bold 
                                          : FontWeight.normal,
                                    ),
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
                                        onPressed: () => _viewInvoice(invoice),
                                        tooltip: 'View Invoice',
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.download,
                                          size: 18,
                                          color: Color(0xFF8A8AFF),
                                        ),
                                        onPressed: () => _downloadInvoice(invoice),
                                        tooltip: 'Download Invoice',
                                      ),
                                      if (invoice['status'] == 'Pending')
                                        IconButton(
                                          icon: const Icon(
                                            Icons.check_circle,
                                            size: 18,
                                            color: Color(0xFF4CAF50),
                                          ),
                                          onPressed: () => _markAsPaid(invoice),
                                          tooltip: 'Mark as Paid',
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

  List<Map<String, dynamic>> _getFilteredInvoices() {
    List<Map<String, dynamic>> filteredInvoices = _invoices;

    // Apply status filter
    if (_selectedFilter != 'All') {
      filteredInvoices = filteredInvoices.where((invoice) => invoice['status'] == _selectedFilter).toList();
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filteredInvoices = filteredInvoices.where((invoice) {
        // Search in text fields (case-insensitive)
        final idMatch = invoice['id'].toString().toLowerCase().contains(_searchQuery);
        final customerMatch = invoice['customer'].toString().toLowerCase().contains(_searchQuery);
        final orderIdMatch = invoice['orderId'].toString().toLowerCase().contains(_searchQuery);
        final dateMatch = invoice['date'].toString().toLowerCase().contains(_searchQuery);
        final dueDateMatch = invoice['dueDate'].toString().toLowerCase().contains(_searchQuery);
        
        // Search in amount field (supports both with and without currency symbol)
        final amount = invoice['amount'].toString();
        final amountMatch = amount.contains(_searchQuery) || 
                           amount.replaceAll('₹', '').replaceAll(',', '').contains(_searchQuery);
        
        return idMatch || customerMatch || orderIdMatch || dateMatch || dueDateMatch || amountMatch;
      }).toList();
    }

    return filteredInvoices;
  }


  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Paid':
        return Colors.green;
      case 'Overdue':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showCreateInvoiceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create New Invoice'),
        content: const Text('Invoice creation form will be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Create Invoice'),
          ),
        ],
      ),
    );
  }

  void _viewInvoice(Map<String, dynamic> invoice) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Invoice - ${invoice['id']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Customer: ${invoice['customer']}'),
            Text('Order: ${invoice['orderId']}'),
            Text('Amount: ₹${invoice['amount']}'),
            Text('Status: ${invoice['status']}'),
            Text('Date: ${invoice['date']}'),
            Text('Due Date: ${invoice['dueDate']}'),
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

  void _downloadInvoice(Map<String, dynamic> invoice) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Downloading invoice ${invoice['id']}...'),
        backgroundColor: const Color(0xFF8A8AFF),
      ),
    );
  }

  void _markAsPaid(Map<String, dynamic> invoice) {
    setState(() {
      invoice['status'] = 'Paid';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Invoice ${invoice['id']} marked as paid'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
    );
  }
}
