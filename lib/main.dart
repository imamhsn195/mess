
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mess/pages/transactions.dart';
import 'package:mess/pages/balance.dart';
import 'package:mess/pages/members.dart';
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
        Transactions.id : (context) => const Transactions( title : "Transactions"),
        Members.id : (context) => const Members( title : "Members"),
        Balances.id : (context) =>  const Balances( title : "Balances")
      }
    )
  );
}