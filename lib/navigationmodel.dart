import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lastassign/model/model.dart';

class Navigmodel extends ChangeNotifier {
  int currentindex = 0;
  String? title = "TODO";
  int floatbtnvalue = 0;
  bool todoaddvisible = false;
  bool contactvisible = false;
  bool callvisible = false;

  List<Widget> itemwidget = [
    Bodyitem(
      color: Colors.green,
      textvalue: "This is todo page",
      floatclickvalue: 0,
    ),
    Bodyitem(
      color: Colors.lightBlue,
      textvalue: "This is Contact page",
      floatclickvalue: 1,
    ),
    Bodyitem(
      color: Colors.purple,
      textvalue: "THis is call page",
      floatclickvalue: 2,
    ),
  ];
  void changeindex() {
    if (currentindex == 0) {
      title = "TODO";
      floatbtnvalue = 0;
    } else if (currentindex == 1) {
      title = "Contact";
      floatbtnvalue = 1;
    } else if (currentindex == 2) {
      title = "Calls";
      floatbtnvalue = 2;
    } else {
      title = "Error";
    }
    notifyListeners();
  }
}
