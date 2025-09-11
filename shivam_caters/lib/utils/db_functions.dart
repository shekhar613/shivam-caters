import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:shivam_caters/database/app_database.dart';


class DbFunctions {

  final AppDatabase db;
  DbFunctions(this.db);

  // ? Show all dishes

  Stream<List<Dishe>> watchDishes({String? category}) {
    if (category == null || category == 'All') {
      return (db.select(db.dishes)).watch();
    } else {
      return (db.select(db.dishes)..where((tbl) => tbl.category.equals(category))).watch();
    }
  }


  // ? Edit menu Item
void editMenuItem(BuildContext context, AppDatabase db, Dishe dish) {
  final nameController = TextEditingController(text: dish.name);
  final priceController = TextEditingController(text: dish.price.toString());
  var categoryController = TextEditingController(text: dish.category ?? '');
  final descController = TextEditingController(text: dish.description);
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
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Edit ${dish.name}'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Dish Name"),
            ),
            Column(
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
            value: categoryController.text,
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
              categoryController.text = newValue!;
            },
          ),
        ),
      ],
    ),
           
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: "Price"),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: "Description"
              ),
            ),
            
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () async {
            await (db.update(db.dishes)..where((t) => t.id.equals(dish.id))).write(
              DishesCompanion(
                name: Value(nameController.text),
                price: Value(double.tryParse(priceController.text) ?? dish.price),
                category: Value(categoryController.text),
                description: Value(descController.text),
              ),
            );

            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${dish.name} updated'),
                backgroundColor: Colors.green,
              ),
            );
          },
          child: const Text("Save"),
        ),
      ],
    ),
  );
}

// ? toogle Availabilty for Menu Item

  void toggleAvailability(Dishe dish, BuildContext context) async {
  final newValue = !(dish.isAvailable); // flip the value

  await (db.update(db.dishes)..where((t) => t.id.equals(dish.id))).write(
    DishesCompanion(
      isAvailable: Value(newValue),
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('${dish.name} ${newValue ? 'made available' : 'made unavailable'}'),
      backgroundColor: const Color(0xFF8A8AFF),
    ),
  );
}

// ? Delete Function for Menu Item

void deleteMenuItem(BuildContext context, AppDatabase db, Dishe dish) {
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
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
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
          child: const Text('Delete'),
        ),
      ],
    ),
  );
}


}