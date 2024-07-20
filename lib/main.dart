import 'package:exam_e_commerce/views/screens/cart_page.dart';
import 'package:exam_e_commerce/views/screens/detail_page.dart';
import 'package:exam_e_commerce/views/screens/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomePage(),
        'detail_page': (context) => const DetailPage(),
        'cart_page': (context) => const CartPage(),
      },
    );
  }
}
