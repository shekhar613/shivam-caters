import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import '../database/db_instance.dart';
import '../database/app_database.dart'; // Drift generated

class AddDishScreen extends StatefulWidget {
  const AddDishScreen({super.key});

  @override
  State<AddDishScreen> createState() => _AddDishScreenState();
}

class _AddDishScreenState extends State<AddDishScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _portionController = TextEditingController();
  final _prepTimeController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  String _selectedCategory = 'Appetizers';
  bool _isAvailable = true;
  bool _isLoading = false;
  
  final List<String> _categories = [
    'Appetizers',
    'Main Course',
    'Breads',
    'Desserts',
    'Beverages',
    'Salads',
    'Soups',
    'Snacks'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _portionController.dispose();
    _prepTimeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveDish() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final dish = DishesCompanion(
          
          name: Value(_nameController.text.trim()),
          category: Value(_selectedCategory),
          price: Value(double.tryParse(_priceController.text.trim()) ?? 0),
          portionSize: Value(_portionController.text.trim()),
          prepTime:  Value(_prepTimeController.text.trim()),
          description: Value(_descriptionController.text.trim()),
          isAvailable: Value(_isAvailable),
        );

        await db.into(db.dishes).insert(dish);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("Dish added successfully ✅"),
              backgroundColor: const Color(0xFF4CAF50),
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.pop(context, true);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error adding dish: $e"),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Dish"),
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
                        "Add New Dish",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF000047),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Fill in the details to add a new dish to your menu",
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
                          label: "Dish Name",
                          hint: "Enter dish name",
                          icon: Icons.restaurant,
                          validator: (value) => value == null || value.isEmpty 
                              ? "Please enter dish name" : null,
                        ),
                        const SizedBox(height: 20),
                        
                        // Category Dropdown
                        _buildCategoryDropdown(),
                        const SizedBox(height: 20),
                        
                        // Price
                        _buildTextField(
                          controller: _priceController,
                          label: "Price (₹)",
                          hint: "Enter price",
                          icon: Icons.currency_rupee_outlined,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter price";
                            }
                            if (double.tryParse(value) == null) {
                              return "Please enter a valid price";
                            }
                            if (double.parse(value) <= 0) {
                              return "Price must be greater than 0";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        
                        // Portion Size
                        _buildTextField(
                          controller: _portionController,
                          label: "Portion Size",
                          hint: "e.g., 1 plate, 2 pieces, 250ml",
                          icon: Icons.scale,
                        ),
                        const SizedBox(height: 20),
                        
                        // Prep Time
                        _buildTextField(
                          controller: _prepTimeController,
                          label: "Preparation Time",
                          hint: "e.g., 15 mins, 30 mins",
                          icon: Icons.timer,
                        ),
                        const SizedBox(height: 20),
                        
                        // Description
                        _buildTextField(
                          controller: _descriptionController,
                          label: "Description",
                          hint: "Brief description of the dish",
                          icon: Icons.description,
                          maxLines: 3,
                        ),
                        const SizedBox(height: 20),
                        
                        // Availability Toggle
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.visibility,
                                color: _isAvailable ? Colors.green : Colors.orange,
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                "Available",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              Switch(
                                value: _isAvailable,
                                onChanged: (value) {
                                  setState(() {
                                    _isAvailable = value;
                                  });
                                },
                                activeColor: const Color(0xFF8A8AFF),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        
                        // Save Button
                        ElevatedButton(
                          onPressed: _isLoading ? null : _saveDish,
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
                                      "Save Dish",
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
