import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

import 'package:shivam_caters/database/dao/order_dao.dart';

part 'app_database.g.dart';

//  Dishes table
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


//  Stocks table
class Stocks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get category => text().nullable()();
  RealColumn get availableQuantity => real().withDefault(const Constant(0))();
  RealColumn get minQuantity => real().withDefault(const Constant(0))();
}

//  Orders table
class Orders extends Table {
  IntColumn get id => integer().autoIncrement()();

  // Customer Details
  TextColumn get customerName => text()();
  TextColumn get contactNumber => text()();
  TextColumn get eventName => text()();
  DateTimeColumn get eventDate => dateTime()();
  DateTimeColumn get bookingDate => dateTime()();

  // Event Details
  TextColumn get eventPlace => text()();
  TextColumn get decorationItems => text().nullable()();

  // Billing Details
  RealColumn get totalAmount => real().withDefault(Constant(0.0))();
  RealColumn get advancePayment => real().withDefault(Constant(0.0))();
  TextColumn get paymentMode => text().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get status => text()();
}

// Order Meals table

class OrderMeals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get orderId => integer().references(Orders, #id)();

  TextColumn get mealType => text()(); // Breakfast, Lunch, Dinner
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime()();

  IntColumn get numberOfPersons => integer()();
  IntColumn get extraPersons => integer().withDefault(Constant(0))();
  RealColumn get pricePerPerson => real()();
  RealColumn get totalAmount => real()();
}

//Order Dishes

class OrderDishes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get orderId => integer().references(Orders, #id)();

  TextColumn get dishName => text()();
  IntColumn get quantity => integer().withDefault(Constant(1))();
  RealColumn get price => real().withDefault(Constant(0.0))();
}


// Main database class
@DriftDatabase(tables: [Dishes, Stocks, Orders,OrderMeals,OrderDishes],
daos: [OrderDao]
)
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
