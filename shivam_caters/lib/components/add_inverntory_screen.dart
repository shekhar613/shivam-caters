import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import '../database/db_instance.dart';
import '../database/app_database.dart'; // Drift generated

class AddInverntoryScreen extends StatefulWidget {
  const AddInverntoryScreen({super.key});

  @override
  State<AddInverntoryScreen> createState() => _AddInverntoryScreenState();
}

class _AddInverntoryScreenState extends State<AddInverntoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _availableQuantityController = TextEditingController();
  final _minQuantityController = TextEditingController();
  final _statusController = TextEditingController();
  
  String _selectedCategory = 'Vegetables';
  bool _isLoading = false;
  
  final List<String> _categories = [
    'Vegetables',
    'Oil',
    'Grains',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _availableQuantityController.dispose();
    _minQuantityController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  Future<void> _saveStock() async {
  if (_formKey.currentState!.validate()) {
    try {
      final stock = StocksCompanion(
        name: Value(_nameController.text.trim()),
        category: Value(_selectedCategory),
        availableQuantity: Value(double.tryParse(_availableQuantityController.text.trim()) ?? 0),
        minQuantity: Value(double.tryParse(_minQuantityController.text.trim()) ?? 0),
        status: Value("In Stock"),
      );

      await db.insertStock(stock); // ✅ Insert into DB

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Stock added successfully ✅")),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
        );
      }
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Stock"),
        backgroundColor: const Color(0xFF8A8AFF),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF8A8AFF),
              Color(0xFFF0F0FF),
            ],
            stops: [0.0, 0.3],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF8A8AFF).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.restaurant_menu,
                          size: 48,
                          color: Color(0xFF8A8AFF),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Add New Stock",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF000047),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Fill in the details to add a new Stock to your Inventory",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                
                // Form Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Dish Name
                        _buildTextField(
                          controller: _nameController,
                          label: "Stock Name",
                          hint: "Enter Stock name",
                          icon: Icons.inventory,
                          validator: (value) => value == null || value.isEmpty 
                              ? "Please enter stock name" : null,
                        ),
                        const SizedBox(height: 10),
                        
                        // Category Dropdown
                        _buildCategoryDropdown(),
                        const SizedBox(height: 10),
                        
                        // Price
                        _buildTextField(
                          controller: _availableQuantityController,
                          label: "Stock Quantity (kg)",
                          hint: "Enter quantity",
                          icon: Icons.pix_rounded,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter quantity";
                            }
                            if (double.tryParse(value) == null) {
                              return "Please enter a valid quantity";
                            }
                           
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        
                        // Portion Size
                        _buildTextField(
                          controller: _minQuantityController,
                          label: "Min Stock Size",
                          hint: "e.g., 10 kg, 15kg, 20kg etc",
                          icon: Icons.scale,
                        ),
                     
                        const SizedBox(height: 22),
                        
                        // Save Button
                        ElevatedButton(
                          onPressed: _isLoading ? null : _saveStock,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8A8AFF),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.save, size: 20),
                                    SizedBox(width: 8),
                                    Text(
                                      "Save Stock",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF000047),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: const Color(0xFF8A8AFF)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF8A8AFF), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            filled: true,
            fillColor: Colors.grey[50],
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Category",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF000047),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[50],
          ),
          child: DropdownButtonFormField<String>(
            value: _selectedCategory,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.category, color: Color(0xFF8A8AFF)),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
            items: _categories.map((String category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedCategory = newValue!;
              });
            },
          ),
        ),
      ],
    );
  }
}
