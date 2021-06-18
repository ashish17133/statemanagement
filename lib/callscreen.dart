import 'package:flutter/material.dart';
import 'package:lastassign/main.dart';
import 'package:call_log/call_log.dart';

Future<List<Widget>> getcalllog() async {
  List<Widget> _item = [];
  Iterable<CallLogEntry> entries = await CallLog.get();
  entries.forEach((element) {
    _item.add(Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 60,
            child: Card(
              color: Colors.blueGrey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Center(
                  child: Column(
                children: [
                  Text(
                    "${element.callType}",
                    style: TextStyle(color: Colors.amber, fontSize: 20),
                  ),
                  Text(
                    "${element.name ?? "Unknown"}",
                    style: TextStyle(color: Colors.amber),
                  ),
                  Text(
                    "${element.number}",
                    style: TextStyle(color: Colors.amber),
                  ),
                ],
              )),
            ),
          ),
        ),
      ],
    ));
  });
  return _item;
}

Widget calls() {
  return Column(children: calllogdata);
}
