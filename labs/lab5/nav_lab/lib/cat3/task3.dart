import 'package:flutter/material.dart';

class Contact {
  final String name;
  final String phone;
  final String email;

  const Contact(this.name, this.phone, this.email);
}

const List<Contact> contacts = [
  Contact("Jack", "+998-xxx-yy-zz", "jack@jack.com"),
  Contact("Liz", "+998-xxx-yy-zz", "liz@liz.com"),
  Contact("Murphy", "+998-xxx-yy-zz", "murphy@murphy.com"),
  Contact("Albert", "+998-xxx-yy-zz", "albert@albert.com"),
  Contact("Tom", "+998-xxx-yy-zz", "tom@tom.com"),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWithTitle("Contacts"),
      body: Center(
        child: ListView(
          children: [
            for (final contact in contacts)
              ListTile(
                title: Text(contact.name),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactScreen(contact: contact),
                    ),
                  ),
                },
              ),
          ],
        ),
      ),
    );
  }
}

class ContactScreen extends StatelessWidget {
  final Contact contact;
  const ContactScreen({required this.contact, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWithTitle("Contact details"),
      body: Center(
        child: Column(
          children: [
            Text("Name: ${contact.name}"),
            SizedBox(height: 20.0),
            Text("Phone: ${contact.phone}"),
            SizedBox(height: 20.0),
            Text("Email: ${contact.email}"),
          ],
        ),
      ),
    );
  }
}

AppBar buildAppBarWithTitle(String title) {
  return AppBar(title: Text(title));
}
