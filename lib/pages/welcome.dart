import 'package:flutter/material.dart';
import 'package:mess/components/drawer.dart';
import 'package:mess/components/transaction_table.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        drawer: const SideBar(),
        body: const TransactionList(),
    );
  }
}
