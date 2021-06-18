import 'package:flutter/material.dart';
import 'package:lastassign/main.dart';
// Import package
import 'package:contacts_service/contacts_service.dart';

class Contactinfo {
  String? firstname;
  String? lastname;
  String? phone;
}

Contactinfo _contact = Contactinfo();

bool loadingcon = true;
Future<List<Widget>> getcon() async {
  loadingcon = false;
  List<Widget> _item = [];
  try {
    Iterable<Contact> contacts =
        await ContactsService.getContacts(withThumbnails: false);
    contacts.forEach((element) {
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
                    child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Text(
                            "${element.displayName}",
                            style: TextStyle(color: Colors.amber),
                          ),
                          Text(
                            "${element.androidAccountName}",
                            style: TextStyle(color: Colors.amber),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: () async {
                            await ContactsService.deleteContact(Contact(
                                displayName: element.displayName,
                                androidAccountName:
                                    element.androidAccountName));
                            contactobject = await getcon();

                            print("Delete workig");
                          },
                          icon: Icon(Icons.delete)),
                    ),
                  ],
                )),
              ),
            ),
          ),
        ],
      ));
    });
    loadingcon = false;
    return _item;
  } catch (e) {
    print(e);
    return [Text("me")];
  }
  ;
}

Widget contact() {
  return Container(
    child: contactvisiblility == true
        ? Column(
            children: [addcontact()],
          )
        : Column(children: contactobject),
  );
}

Widget addcontact() {
  return Container(
    child: Column(
      children: [
        TextField(
          onChanged: (value) {
            _contact.firstname = value;
          },
          decoration: InputDecoration(
              hintText: "First name:",
              border: OutlineInputBorder(
                  borderSide: BorderSide(width: 4, color: Colors.pink))),
        ),
        TextField(
          onChanged: (value) {
            _contact.lastname = value;
            print("value");
          },
          decoration: InputDecoration(
              hintText: "Last name:",
              border: OutlineInputBorder(
                  borderSide: BorderSide(width: 4, color: Colors.pink))),
        ),
        TextField(
          onChanged: (value) {
            _contact.phone = value;
          },
          decoration: InputDecoration(
              hintText: "Phone Number",
              border: OutlineInputBorder(
                  borderSide: BorderSide(width: 4, color: Colors.pink))),
        ),
        ElevatedButton(
            onPressed: () async {
              await ContactsService.addContact(Contact(
                  displayName: _contact.firstname,
                  middleName: _contact.lastname,
                  phones: [Item(value: _contact.phone)]));

              print("COntact data added");
              print(_contact.phone);
              contactobject = await getcon();
              print("value loaded");
            },
            child: Text("SAVE CONTACT"))
      ],
    ),
  );
}
