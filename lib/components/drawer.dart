import 'package:flutter/material.dart';
import 'package:mess/pages/transactions.dart';
import 'package:mess/pages/welcome.dart';
import '../pages/balance.dart';
import '../pages/members.dart';

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
            title: const Text("Members"),
            onTap: (){
              Navigator.pushNamed(context, Members.id);
            },
          ),
          ListTile(
            title: const Text("Transactions"),
            onTap: (){
              Navigator.pushNamed(context, Transactions.id);
            },
          ),
          ListTile(
            title: const Text("Balances"),
            onTap: (){
              Navigator.pushNamed(context, Balances.id);
            },
          )
        ],
      ),
    );
  }
}
