import 'package:flutter/material.dart';
import 'database/databaseclass.dart';
import 'main.dart';

bool loading = true;

Widget todo() {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      print("Code for all list of task goes here");
                    },
                    child: Text(
                      "All",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    width: 5,
                    color: Colors.white,
                  ),
                  TextButton(
                    child: Text("TODAY", style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      print("Code for today list goes here");
                    },
                  ),
                  Container(
                    width: 5,
                    color: Colors.white,
                  ),
                  TextButton(
                    onPressed: () {
                      print("Code for tomorrow list goes here");
                    },
                    child: Text(
                      "TOMORROW",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    width: 5,
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          child: Column(children: todolistwidget()),
        ),
      ],
    ),
  );
}

List<Widget> todolistwidget() {
  List<Widget> mylist = [];
  loading = true;
  for (int i = 0; i <= value.length - 1; i++) {
    mylist.add(Padding(
      padding: EdgeInsets.all(10),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        tileColor: Colors.lightBlue,
        title: Text(
          "${value[i].task}",
          style: TextStyle(color: Colors.yellow, fontSize: 30),
        ),
        subtitle: Text(
          "${value[i].taskname}",
          style: TextStyle(color: Colors.yellow, fontSize: 30),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () async {
            await mydatabase.delete("${value[i].taskname}");
            print("${value[i].taskname}");

            print("Delete code for listitem goes here todoscreen");
          },
        ),
        leading: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            print("Edit code for list item goes here todoscreen");
          },
        ),
      ),
    ));
  }
  loading = false;
  return mylist == null
      ? [
          Text(
            "No DATA",
            style: TextStyle(fontSize: 80),
          )
        ]
      : mylist;
}
