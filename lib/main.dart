import 'package:flutter/material.dart';
import 'package:lastassign/TODO/addtodo.dart';
import 'package:lastassign/callscreen.dart';
import 'package:lastassign/contactscreen.dart';
import 'package:lastassign/database/databaseclass.dart';
import 'package:lastassign/navigationmodel.dart';
import 'package:lastassign/todoscreen.dart';
import 'package:provider/provider.dart';

import 'model/todotask.dart';

var contactobject;
var calllogdata;
Databaseclass mydatabase = Databaseclass();
bool contactvisiblility = false;
bool callvisibility = false;
List<TODO> value = [];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Databaseclass mydatabase = Databaseclass();
  await mydatabase.init();
  loadvalue();
  contactobject = await getcon();
  calllogdata = await getcalllog();
  // await mydatabase.insert(
  //     TODO(task: "First", taskname: "Solve database problem", date: "10596"));

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<Navigmodel>(create: (_) => Navigmodel()),
    ],
    child: MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<Navigmodel>(builder: (context, navig, child) {
      void actiontotake() async {
        if (navig.floatbtnvalue == 0) {
          print("todo float clicked");
          navig.todoaddvisible == false
              ? navig.todoaddvisible = true
              : navig.todoaddvisible = false;
          print(navig.todoaddvisible);
          loadvalue();
          navig.changeindex();
        } else if (navig.floatbtnvalue == 1) {
          print("contact float clicked");
          print("todo float clicked");
          navig.contactvisible == false
              ? navig.contactvisible = true
              : navig.contactvisible = false;
          contactvisiblility = navig.contactvisible;

          print(navig.contactvisible);
          navig.changeindex();
        } else {
          navig.callvisible == false
              ? navig.callvisible = true
              : navig.callvisible = false;
          callvisibility = navig.callvisible;
          print(navig.callvisible);
          navig.changeindex();
          print("Calls float clicked");
        }
      }

      return Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              DrawerHeader(
                  child: Text("App Feature",
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 30,
                      ))),
              TextButton(
                  onPressed: () {
                    navig.currentindex = 0;
                    navig.changeindex();
                  },
                  child: Text("TO DO TAB")),
              TextButton(
                  onPressed: () {
                    navig.currentindex = 1;
                    navig.changeindex();
                  },
                  child: Text("Contact TAB")),
              TextButton(
                  onPressed: () {
                    navig.currentindex = 2;
                    navig.changeindex();
                  },
                  child: Text("Call TAB")),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("${navig.title}"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: navig.todoaddvisible == true
                ? todoadd(context)
                : (navig.contactvisible == true)
                    ? contact()
                    : (navig.callvisible == true)
                        ? calls()
                        : navig.itemwidget[navig.currentindex]),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            navig.currentindex = value;
            navig.changeindex();
          },
          currentIndex: navig.currentindex,
          backgroundColor: Colors.lightGreen,
          items: [
            BottomNavigationBarItem(
              title: Text("TODO"),
              icon: Icon(Icons.work),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.contact_mail), title: Text("Contact")),
            BottomNavigationBarItem(
                icon: Icon(Icons.call), title: Text("Call")),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            actiontotake();
          },
        ),
      );
    }));
  }
}

void loadvalue() async {
  value = await mydatabase.gettodo();
  print(value.length);
}
