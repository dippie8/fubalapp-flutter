import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fubalapp_mobile/models/Standing.dart';
import 'package:fubalapp_mobile/utils/ColorConverter.dart';

class StandingView extends StatelessWidget {


  DataTable _data;
  ColorConverter colorConverter = ColorConverter();

  StandingView(List<Standing> standings) {
    this._data = DataTable(

      columns: const <DataColumn>[
        DataColumn(
            label: Icon(
              AntDesign.staro,
              color: Colors.grey,
            )
        ),
        DataColumn(
          label: Text(
            'NOME',
          ),
        ),
        DataColumn(
          numeric: true,
          label: Text(
            'W/TOT',
          ),
        ),
        DataColumn(
          numeric: true,
          label: Text(
            'ELO',
          ),
        ),
      ],
      rows: standings.map<DataRow>((e) => DataRow(
        cells: <DataCell>[
          DataCell(
              Icon(
                AntDesign.star,
                color: colorConverter.hexToColor(e.color),
              )
          ),
          DataCell(Text(e.name)),
          DataCell(Text(e.win.toString() + "/" + e.tot.toString())),
          DataCell(Text(e.elo.toString())),
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
                  SizedBox(height: 45,),
                  Text(
                    "Classifica Mensile",
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
        )
      ],
    );

  }

}

