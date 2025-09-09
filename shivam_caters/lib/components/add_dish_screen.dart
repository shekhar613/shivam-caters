import 'package:drift/drift.dart';
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
  final _categoryController = TextEditingController();
  final _priceController = TextEditingController();
  final _portionController = TextEditingController();

  Future<void> _saveDish() async {
    if (_formKey.currentState!.validate()) {
      final dish = DishesCompanion(
        name: Value(_nameController.text.trim()),
        category: Value(_categoryController.text.trim()),
        price: Value(double.tryParse(_priceController.text.trim()) ?? 0),
        portionSize: Value(_portionController.text.trim()),
      );

      await db.into(db.dishes).insert(dish);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Dish added successfully ✅")),
      );

      Navigator.pop(context, true); // return success
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Dish")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Dish Name"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter dish name" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: "Category"),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter price" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _portionController,
                decoration: const InputDecoration(labelText: "Portion Size"),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text("Save Dish"),
                onPressed: _saveDish,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
