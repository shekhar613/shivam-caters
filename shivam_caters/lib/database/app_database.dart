import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'app_database.g.dart';

// Define table
class Dishes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get category => text().nullable()();
  RealColumn get price => real()();
  TextColumn get portionSize => text().nullable()();
  TextColumn get prepTime => text().nullable()();
  BoolColumn get isAvailable => boolean().withDefault(const Constant(true))();
}

// Main database class
@DriftDatabase(tables: [Dishes])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // ✅ Watch dishes with optional category filter
  Stream<List<Dishe>> watchDishes({String? category}) {
    if (category == null || category == 'All') {
      return (select(dishes)).watch();
    } else {
      return (select(dishes)..where((tbl) => tbl.category.equals(category))).watch();
    }
  }

  // ✅ Insert new dish
  Future<int> insertDish(DishesCompanion dish) => into(dishes).insert(dish);

  // ✅ Update availability
  Future updateAvailability(int id, bool available) {
    return (update(dishes)..where((t) => t.id.equals(id)))
        .write(DishesCompanion(isAvailable: Value(available)));
  }

  // ✅ Delete dish
  Future deleteDish(int id) {
    return (delete(dishes)..where((t) => t.id.equals(id))).go();
  }
}

// Open connection
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationSupportDirectory();
    final file = File(p.join(dbFolder.path, 'catering.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
