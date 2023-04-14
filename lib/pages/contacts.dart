import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

class Contacts extends StatefulWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  bool contactsPermission = true;
  List contacts = [];
  List resultContacts = [];

  void getStatus() async {
    PermissionStatus status = await Permission.contacts.status;
    if (status == PermissionStatus.granted) {
      getContacts();
    } else {
      setState(() {
        contactsPermission = false;
      });
    }
  }

  void getContacts() async {
    List<Contact> fetchContacts = await ContactsService.getContacts();
    if (fetchContacts.isNotEmpty) {
      setState(() {
        contacts = fetchContacts;
        resultContacts = fetchContacts;
      });
    }
  }

  void filterContacts(String name) {
    final contactNames = contacts.where((contact) {
      final displayName = contact.displayName.toLowerCase();
      final input = name.toLowerCase();
      return displayName.contains(input);
    }).toList();
    setState(() => resultContacts = contactNames);
  }

  @override
  void initState() {
    super.initState();
    getStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              onChanged: (text) {
                filterContacts(text);
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter contact name',
              ),
            ),
          ),
          contactsPermission == true
              ? Expanded(
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(5.0),
                        itemCount: resultContacts.length,
                        itemBuilder: (context, index) {
                          Contact contact = resultContacts[index];
                          return ListTile(
                            leading: CircleAvatar(
                              child: Icon(Icons.people),
                            ),
                            title: Text('${contact.displayName}'),
                          );
                        }),
                  ),
              )
              : TextButton(
                  onPressed: () async {
                    PermissionStatus status =
                        await Permission.contacts.request();
                    if (status == PermissionStatus.granted) {
                      setState(() {
                        contactsPermission = true;
                      });
                    } else if (status == PermissionStatus.denied) {
                      ScaffoldMessenger(
                          child: Text("Please give access to contacts"));
                    } else if (status == PermissionStatus.permanentlyDenied) {
                      openAppSettings();
                    }
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(10.0)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)))),
                  child: Text(
                    "Give permission",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, letterSpacing: 1.0),
                  )),
        ],
      ),
    );
  }
}
