import 'package:flutter/material.dart';
import 'components/splash_screen.dart';

void main() async {

  await WidgetsFlutterBinding.ensureInitialized();
  runApp(const ShivamCatersApp());
}

class ShivamCatersApp extends StatelessWidget {
  const ShivamCatersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shivam Caters - Management System',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8A8AFF), // Light purple as primary
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

