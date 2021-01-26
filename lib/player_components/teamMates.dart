import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fubalapp_mobile/models/Teammate.dart';
import 'package:fubalapp_mobile/player_components/teamMateCard.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'indicator.dart';

class Teammates extends StatelessWidget {

  final List<Teammate> teammates;


  Teammates(this.teammates);

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    "Compagni / Avversari",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            )
          ],
        ),
        Container(
          padding: EdgeInsets.all(16),
          height: 310,
          child: new Swiper(
            itemCount: teammates.length,
            itemBuilder: (BuildContext context, int index) => TeamMateCard(teammates[index]),
            itemWidth: 320.0,
            layout: SwiperLayout.STACK,
          ),
        )
      ],
    );
  }



}
