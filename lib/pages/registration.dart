import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key, required this.title}) : super(key: key);
  static String id = "user_register";
  final String title;
  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: const Center(child: Text('Create users')
        )
    );
  }
}
