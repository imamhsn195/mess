import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key, required this.title}) : super(key: key);
  final String title;
  static String id = "transactions";
  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {

  final CollectionReference _transactions = FirebaseFirestore.instance.collection('transactions');
  final CollectionReference _members = FirebaseFirestore.instance.collection('members');
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime _date = DateTime.now();
  String _selectedMember = 'RNFEdd36gntDfZ9mGo9W';

  late List<QueryDocumentSnapshot<Object?>> allMembers;

  Future<void> _getAllRecords() async {
    try {
      final memberSnapshot = await _members.get();
      if(memberSnapshot.docs.isNotEmpty) {
        allMembers = memberSnapshot.docs;
      }
    } catch (error) {
      print('Error caught while getting data:  $error');
    }
  }

  String formattedDate(timeStamp){
    var dateFromTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);
    return DateFormat("dd-MM-yyyy hh:mm a").format(dateFromTimeStamp);
  }

  Future<void> _delete(String transactionId) async{
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: const Text('Please Confirm'),
            content: const Text('Are you sure to remove transaction?'),
            actions: [
              // The "Yes" button
              CupertinoDialogAction(
                onPressed: (){
                  setState(() async {
                    Navigator.of(context).pop();
                    await _transactions.doc(transactionId).delete();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Transaction Deleted successfully"))
                    );
                  });
                },
                isDefaultAction: true,
                isDestructiveAction: true,
                child: const Text('Yes'),
              ),
              // The "No" button
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                isDefaultAction: false,
                isDestructiveAction: false,
                child: const Text('No'),
              )
            ],
          );
        }
      );
  }

  Future<void> _create() async{
  await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx){
        return Padding(
          padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DateTimeFormField(
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.black45),
                  errorStyle: TextStyle(color: Colors.redAccent),
                  suffixIcon: Icon(Icons.event_note),
                  labelText: 'Only date',
                ),
                initialValue: DateTime.now(),
                mode: DateTimeFieldPickerMode.dateAndTime,
                autovalidateMode: AutovalidateMode.always,
                validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                onDateSelected: (DateTime value) {_date = value;},
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10.0),
                  child: Text("Members")
              ),
              DropdownButtonFormField(
                  value: _selectedMember,
                  isExpanded: true,
                  items: allMembers.map((item) =>  DropdownMenuItem( value: item.id, child: Text(item.get('name')))).toList(),
                  onChanged: (String? value){
                    setState((){
                      _selectedMember = value!;
                    });
                  }
              ),
              TextField(
                decoration: const InputDecoration(labelText: "descriptions"),
                controller: _descriptionController,
              ),
              TextField(
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: "amount"),
                controller: _amountController,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  onPressed: () async{
                    final double? amount = double.tryParse(_amountController.text);
                    final String descriptions = _descriptionController.text;
                    if(amount != null){
                      await _transactions.add({ "date": _date, "created_by" : _selectedMember, "amount" : amount, "descriptions" : descriptions });
                      _amountController.text = '';
                      _descriptionController.text = '';
                    }
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Transaction created successfully"),),
                    );
                  },
                child: const Text("Add"),
              )
            ],
          ),
        );
      }
  );
}

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async{
  if(documentSnapshot != null){
    _date = documentSnapshot['date'].toDate();
    _descriptionController.text = documentSnapshot['descriptions'].toString();
    _amountController.text = documentSnapshot['amount'].toString();
  }
  await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx){
        return Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DateTimeFormField(
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.black45),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    suffixIcon: Icon(Icons.event_note),
                    labelText: "Date",
                  ),
                  initialValue: documentSnapshot!['date'].toDate(),
                  mode: DateTimeFieldPickerMode.date,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                  onDateSelected: (DateTime value) {
                    _date = value;
                  },
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10.0),
                    child: Text("Members")
                ),
                DropdownButtonFormField(
                    value: _selectedMember ,
                    isExpanded: true,
                    // DropdownMenuItem( value: 1, child: Text('Item 1'))
                    items: allMembers.map((item) =>  DropdownMenuItem( value: item.id, child: Text(item.get('name')))).toList(),
                    onChanged: (String? value){
                      setState((){
                        _selectedMember = value!;
                      });
                    }
                ),
                TextField(
                  decoration: const InputDecoration(labelText: "descriptions"),
                  controller: _descriptionController,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: "amount"),
                  controller: _amountController,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      minimumSize: const Size.fromHeight(50), // NEW
                    ),
                    onPressed: () async{
                      final double? amount = double.tryParse(_amountController.text);
                      final String descriptions = _descriptionController.text;
                      if(amount != null){
                        await _transactions.doc(documentSnapshot.id)
                        .update({ "date": _date, "created_by" : _selectedMember, "amount" : amount, "descriptions" : descriptions  });
                        _date = DateTime.now();
                        _descriptionController.text = '';
                        _amountController.text = '';
                      }
                      Navigator.of(context).pop();
                    },
                    child: const Text("Update")
                )
              ],
            ),
        );
      }
  );
}

  @override
  void initState() {
    super.initState();
    _getAllRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text(widget.title)),
      body: SafeArea(
        child: StreamBuilder(
            stream: _transactions.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if(streamSnapshot.hasData){
                return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index){
                      final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                      final String descriptions = "${documentSnapshot['descriptions']} on ${formattedDate(documentSnapshot["date"])}";
                      final String title = "AED ${documentSnapshot["amount"].toString().split('.')[0]}";
                      return Card(
                        margin: const EdgeInsets.all(10.0),
                        child: ListTile(
                          title: Text(title),
                          subtitle:Text(descriptions),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: (){
                                      _update(documentSnapshot);
                                    },
                                    icon: const Icon(Icons.edit)
                                ),
                                IconButton(
                                    onPressed: (){
                                      _delete(documentSnapshot.id);
                                    },
                                    icon: const Icon(Icons.delete)
                                ),
                              ],
                            ),
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
      floatingActionButton: FloatingActionButton(
        child:const Icon(Icons.add),
        onPressed: () => _create(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}