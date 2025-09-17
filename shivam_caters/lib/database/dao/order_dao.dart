import 'package:drift/drift.dart';
import '../app_database.dart';

part 'order_dao.g.dart';

@DriftAccessor(tables: [Orders, OrderMeals, OrderDishes])
class OrderDao extends DatabaseAccessor<AppDatabase> with _$OrderDaoMixin {
  final AppDatabase db;
  OrderDao(this.db) : super(db);

  // ---------------- INSERT METHODS ----------------
  Future<int> insertOrder(OrdersCompanion order) async {
    return into(db.orders).insert(order);
  }

  Future<int> insertOrderMeal(OrderMealsCompanion meal) async {
    return into(db.orderMeals).insert(meal);
  }

  Future<int> insertOrderDish(OrderDishesCompanion dish) async {
    return into(db.orderDishes).insert(dish);
  }

  // ---------------- FETCH METHODS ----------------
  Future<List<Order>> getAllOrders() {
    return select(db.orders).get();
  }

  Future<List<OrderMeal>> getMealsForOrder(int orderId) {
    return (select(db.orderMeals)..where((m) => m.orderId.equals(orderId))).get();
  }

  Future<List<OrderDishe>> getDishesForOrder(int orderId) {
    return (select(db.orderDishes)..where((d) => d.orderId.equals(orderId))).get();
  }

  // ---------------- FULL ORDER (Invoice) ----------------
  Future<Map<String, dynamic>> getFullOrderDetails(int orderId) async {
    final order = await (select(db.orders)..where((o) => o.id.equals(orderId))).getSingle();
    final meals = await (select(db.orderMeals)..where((m) => m.orderId.equals(orderId))).get();
    final dishes = await (select(db.orderDishes)..where((d) => d.orderId.equals(orderId))).get();

    return {
      "order": order,
      "meals": meals,
      "dishes": dishes,
    };
  }
}
