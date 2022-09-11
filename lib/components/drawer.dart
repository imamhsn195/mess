import 'package:flutter/material.dart';
import 'package:mess/pages/transactions.dart';
import 'package:mess/pages/welcome.dart';
import '../pages/expenses.dart';
import '../pages/registration.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);
  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(),
            child: Text("Menu"),
          ),
          ListTile(
            title:const Text("Home"),
            onTap: (){
              Navigator.pushNamed(context, Welcome.id);
            },
          ),
          ListTile(
            title: const Text("Create User"),
            onTap: (){
              Navigator.pushNamed(context, Registration.id);
            },
          ),
          ListTile(
            title: const Text("Transactions"),
            onTap: (){
              Navigator.pushNamed(context, TransactionList.id);
            },
          ),
          ListTile(
            title: const Text("Expenses"),
            onTap: (){
              Navigator.pushNamed(context, Expenses.id);
            },
          )
        ],
      ),
    );
  }
}
