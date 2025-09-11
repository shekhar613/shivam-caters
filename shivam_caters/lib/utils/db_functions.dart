import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:shivam_caters/database/app_database.dart';
import 'package:shivam_caters/database/db_instance.dart';

class DbFunctions {
 void editDish (dynamic portionController, dynamic nameController, dynamic categoryController, dynamic priceController, dynamic prepTimeController, BuildContext context, Dishe dish) async {
            await (db.update(db.dishes)..where((t) => t.id.equals(dish.id))).write(
              DishesCompanion(
                name: Value(nameController.text),
                category: Value(categoryController.text),
                price: Value(double.tryParse(priceController.text) ?? 0),
                portionSize: Value(portionController.text),
                prepTime: Value(prepTimeController.text),
              ),
            );
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Dish updated ✅")));
          }
  
  void toggleAvailability(Dishe item, BuildContext context) async {
  final newValue = !(item.isAvailable); // flip the value

  await (db.update(db.dishes)..where((t) => t.id.equals(item.id))).write(
    DishesCompanion(
      isAvailable: Value(newValue),
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('${item.name} ${newValue ? 'made available' : 'made unavailable'}'),
      backgroundColor: const Color(0xFF8A8AFF),
    ),
  );
}

}