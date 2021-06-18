import 'package:flutter/material.dart';
import 'package:lastassign/database/databaseclass.dart';
import 'package:lastassign/main.dart';
import 'package:lastassign/model/todotask.dart';

var _value = 1;
DateTime currentdate = DateTime.now();
DateTime? pickeddate;
TODO _todo = TODO();
Databaseclass mydatabase = Databaseclass();

Widget todoadd(context) {
  return Column(
    children: [
      TextField(
        onChanged: (value) {
          _todo.taskname = value;
        },
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: "Task Name",
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 4, color: Colors.pink))),
      ),
      TextField(
        onChanged: (value) {
          _todo.task = value;
        },
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: "Task todo",
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 4, color: Colors.pink))),
      ),
      TextField(
        onChanged: (value) {
          _todo.date = value;
        },
        decoration: InputDecoration(
            hintText: "Date:$currentdate",
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 4, color: Colors.pink)),
            suffixIcon: IconButton(
                onPressed: () async {
                  _selectdate(context);
                },
                icon: Icon(Icons.date_range))),
      ),
      ElevatedButton(
          onPressed: () async {
            await mydatabase.insert(TODO(
                task: _todo.task, taskname: _todo.taskname, date: _todo.date));
            print("database entered");
          },
          child: Text("SAVE"))
    ],
  );
}

Future<void> _selectdate(BuildContext context) async {
  final DateTime? pickeddate = await showDatePicker(
      context: context,
      initialDate: currentdate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2025));
  if ((pickeddate != null) && (pickeddate != currentdate)) {
    currentdate = pickeddate;
  }
}
