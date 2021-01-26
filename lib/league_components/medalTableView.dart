import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fubalapp_mobile/models/MedalTable.dart';

class MedalTableView extends StatelessWidget {

  DataTable _data;

  MedalTableView(List<MedalTableRow> medalTableRows) {
    this._data = DataTable(

      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'NOME',
          ),
        ),
        DataColumn(
            numeric: true,
            label: Icon(
              MaterialCommunityIcons.medal,
              color: Colors.yellowAccent,
            )
        ),
        DataColumn(
            numeric: true,
            label: Icon(
              MaterialCommunityIcons.medal,
              color: Colors.grey,
            )
        ),
        DataColumn(
            numeric: true,
            label: Icon(
              MaterialCommunityIcons.medal,
              color: Colors.brown,
            )
        ),
      ],
      rows: medalTableRows.map<DataRow>((e) => DataRow(
        cells: <DataCell>[
          DataCell(Text(e.name)),
          DataCell(Text(e.gold.toString())),
          DataCell(Text(e.silver.toString())),
          DataCell(Text(e.bronze.toString())),
        ],
      )).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Text(
                    "Medagliere",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            )
          ],
        ),
        Container(
            child: _data,
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            )
        ),
      ],
    );

  }
}
