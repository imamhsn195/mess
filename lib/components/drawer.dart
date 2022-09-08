import 'package:flutter/material.dart';

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
              Navigator.pushNamed(context, "/");
            },
          ),
          ListTile(
            title: const Text("Add Transaction"),
            onTap: (){
              Navigator.pushNamed(context, "/add");
            },
          )
        ],
      ),
    );
  }
}
