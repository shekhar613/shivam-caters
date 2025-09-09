import 'package:flutter/material.dart';
import '../database/db_instance.dart';
import '../database/app_database.dart';
import 'add_dish_screen.dart';

class TestMenu extends StatefulWidget {
  const TestMenu({super.key});

  @override
  State<TestMenu> createState() => _TestMenuState();
}

class _TestMenuState extends State<TestMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddDishScreen()),
              );
              if (result == true) setState(() {}); // refresh after add
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Dishe>>(
        stream: db.select(db.dishes).watch(), // live updates
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final dishes = snapshot.data!;
          if (dishes.isEmpty) {
            return const Center(child: Text("No dishes yet. Add some!"));
          }
          return ListView.separated(
            itemCount: dishes.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final dish = dishes[index];
              return ListTile(
                title: Text(dish.name,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(
                    "${dish.category ?? "Uncategorized"} • ₹${dish.price}"),
                trailing: Text(dish.portionSize ?? ""),
              );
            },
          );
        },
      ),
    );
  }
}
