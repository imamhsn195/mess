import 'package:flutter/material.dart';
import 'package:mess/pages/transactions.dart';
import '../components/drawer.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key, required this.title}) : super(key: key);
  final String title;
  static String id = 'welcome';
  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Mess Book",
          textAlign: TextAlign.center),
          actions: [
            TextButton(onPressed: (){},
            child: const Icon(Icons.language))
          ],
        ),
        drawer: const SideBar(),
        body: const Transactions(title: "All Transactions"),
    );
  }
}
