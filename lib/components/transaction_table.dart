import 'package:flutter/material.dart';
class TransactionList extends StatefulWidget {
  const TransactionList({Key? key}) : super(key: key);
  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    List<DataColumn> _createColumns(){
      List <DataColumn> columns = [];
      columns.add(
          const DataColumn(
            label: Expanded(
              child: Text(
                'Date',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          )
      );
      columns.add(
        const DataColumn(
          label: Expanded(
            child: Text(
              'Description',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),);
      columns.add(
        const DataColumn(
          label: Expanded(
            child: Text(
              'Member',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),);
      columns.add(
        const
        DataColumn(
          label: Expanded(
            child: Text(
              'Amount',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),);
      return columns;
    }
    List<DataRow> _createRows(){
      List<DataRow> rows = [];
      rows.add(
          const DataRow(
            cells: <DataCell>[
              DataCell(Text('2022-01-20')),
              DataCell(Text('shopping')),
              DataCell(Text('Imam Hasan')),
              DataCell(Text('100')),
            ],
          )
      );      rows.add(
          const DataRow(
            cells: <DataCell>[
              DataCell(Text('2022-01-20')),
              DataCell(Text('shopping')),
              DataCell(Text('Imam Hasan')),
              DataCell(Text('100')),
            ],
          )
      );      rows.add(
          const DataRow(
            cells: <DataCell>[
              DataCell(Text('2022-01-20')),
              DataCell(Text('shopping')),
              DataCell(Text('Imam Hasan')),
              DataCell(Text('100')),
            ],
          )
      );
      return rows;
    }
    DataTable _creteDataTable(){
      return DataTable(
          columnSpacing: 15.0,
          columns: _createColumns(),
          rows: _createRows()
      );
    }
    return _creteDataTable();
  }
}