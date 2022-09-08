
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mess/pages/expenses.dart';
import 'package:mess/pages/welcome.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      initialRoute: '/',
      routes: {
        '/': (context) => const Welcome(title: "All Transactions"),
        '/add' : (context) => const Expenses( title : "Add page")
      }
    )
  );
}