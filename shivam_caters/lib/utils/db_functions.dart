import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:shivam_caters/database/app_database.dart';
import 'package:shivam_caters/database/db_instance.dart';

class DbFunctions {
  void toggleAvailability(Dishe item, BuildContext context) async {
  final newValue = !(item.isAvailable ?? true); // flip the value

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