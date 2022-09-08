import 'package:flutter/material.dart';
import 'package:mess/components/drawer.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(widget.title)
      ),
      drawer: const SideBar(),
      body: const Center(
        child: Text("Add page"),
      ),
    );
  }
}
