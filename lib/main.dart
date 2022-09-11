
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mess/pages/transactions.dart';
import 'package:mess/pages/expenses.dart';
import 'package:mess/pages/registration.dart';
import 'package:mess/pages/welcome.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      initialRoute: Welcome.id,
      routes: {
        Welcome.id: (context) => const Welcome(title: "All Transactions"),
        TransactionList.id : (context) => const TransactionList( title : "All Transactions"),
        Registration.id : (context) => const Registration( title : "User Registration"),
        Expenses.id : (context) =>  const Expenses( title : "Expenses")
      }
    )
  );
}