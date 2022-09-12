import 'package:flutter/material.dart';

class Balances extends StatefulWidget {
  const Balances({Key? key, required this.title}) : super(key: key);
  static String id = "expenses";
  final String title;
  @override
  State<Balances> createState() => _BalancesState();
}

class _BalancesState extends State<Balances> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(widget.title)
      ),
      // drawer: const SideBar(),
      body: const Center(
        child: Text("Balance"),
      ),
    );
  }
}
