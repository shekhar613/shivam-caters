import 'package:flutter/material.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({super.key});

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Pending', 'Paid', 'Overdue'];

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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Billing & Invoices'),
        backgroundColor: const Color(0xFF8A8AFF),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showCreateInvoiceDialog(),
          ),
        ],
      ),
      body: Column(
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
          
          // Invoices List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _getFilteredInvoices().length,
              itemBuilder: (context, index) {
                final invoice = _getFilteredInvoices()[index];
                return _buildInvoiceCard(invoice);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateInvoiceDialog(),
        backgroundColor: const Color(0xFF8A8AFF),
        child: const Icon(Icons.add, color: Colors.white),
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
    if (_selectedFilter == 'All') {
      return _invoices;
    }
    return _invoices.where((invoice) => invoice['status'] == _selectedFilter).toList();
  }

  Widget _buildInvoiceCard(Map<String, dynamic> invoice) {
    Color statusColor = _getStatusColor(invoice['status']);
    
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
                  invoice['id'],
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
                    invoice['status'],
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
              'Customer: ${invoice['customer']}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            Text(
              'Order: ${invoice['orderId']}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              'Date: ${invoice['date']}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              'Due: ${invoice['dueDate']}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Amount: ₹${invoice['amount'].toString()}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4CAF50),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => _viewInvoice(invoice),
                      icon: const Icon(Icons.visibility, color: Color(0xFF8A8AFF)),
                    ),
                    IconButton(
                      onPressed: () => _downloadInvoice(invoice),
                      icon: const Icon(Icons.download, color: Color(0xFF8A8AFF)),
                    ),
                    if (invoice['status'] == 'Pending')
                      IconButton(
                        onPressed: () => _markAsPaid(invoice),
                        icon: const Icon(Icons.check_circle, color: Color(0xFF4CAF50)),
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
