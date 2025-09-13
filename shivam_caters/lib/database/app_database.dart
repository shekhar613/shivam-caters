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
class Stocks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get category => text().nullable()();
  RealColumn get availableQuantity => real().withDefault(const Constant(0))();
  RealColumn get minQuantity => real().withDefault(const Constant(0))();
}

// Main database class
@DriftDatabase(tables: [Dishes, Stocks])
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
  
  // ✅ Function to insert stock
  Future<int> insertStock(StocksCompanion stock) {
    return into(stocks).insert(stock);
  }

  // ✅ Function to watch all stocks
  Stream<List<Stock>> watchStocks() {
    return select(stocks).watch();
  }

  // ✅ Function to update a stock row
  Future<bool> updateStock(Stock stock) {
    return update(stocks).replace(stock);
  }

  // ✅ Function to delete a stock row
  Future<int> deleteStock(int id) {
    return (delete(stocks)..where((tbl) => tbl.id.equals(id))).go();
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
