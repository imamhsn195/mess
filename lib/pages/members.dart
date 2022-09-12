import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Members extends StatefulWidget {
  const Members({Key? key, required this.title}) : super(key: key);
  static String id = "user_register";
  final String title;
  @override
  State<Members> createState() => _MembersState();
}

class _MembersState extends State<Members> {
  final CollectionReference _members = FirebaseFirestore.instance.collection('members');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SafeArea(
        child: StreamBuilder(
          stream: _members.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if(streamSnapshot.hasData){
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index){
                  final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                  final String name = "Name: ${documentSnapshot["name"].toString()}";
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(name),
                      // subtitle:Text(descriptions),
                      trailing: const SizedBox(
                        width: 100,
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
      );
    }
  }
