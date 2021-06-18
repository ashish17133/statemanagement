import 'package:flutter/material.dart';
import 'package:lastassign/TODO/addtodo.dart';

import '../callscreen.dart';
import '../contactscreen.dart';
import '../todoscreen.dart';

class Bodyitem extends StatelessWidget {
  String textvalue;
  Color color;
  int floatclickvalue;

  Bodyitem(
      {required this.color,
      required this.textvalue,
      required this.floatclickvalue});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        floatclickvalue == 0
            ? todo()
            : (floatclickvalue == 1 ? contact() : calls()),
        Center(
          child: Flexible(
            child: Container(
              child: Text("$textvalue"),
              decoration: BoxDecoration(color: color),
            ),
          ),
        ),
      ],
    );
  }
}
