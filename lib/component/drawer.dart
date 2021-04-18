import 'package:flutter/material.dart';

Widget myDrawer(context) {
  return Drawer(
    child: ListView(
      children: [
        UserAccountsDrawerHeader(
          accountName: Text("Alish Shrestha"),
          accountEmail: Text("alish@gmail.com"),
          currentAccountPicture: CircleAvatar(
            child: Text("A"),
          ),
        ),
        ListTile(
          leading: Icon(Icons.dashboard),
          title: Text("Dashboard"),
        ),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, 'offer');
          },
          leading: Icon(Icons.dashboard),
          title: Text("Offer"),
        ),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, 'teams');
          },
          leading: Icon(Icons.sports_soccer_outlined),
          title: Text("Invite Challange"),
        ),
        ListTile(
          leading: Icon(Icons.people_alt_rounded),
          title: Text("Registered Futsal Team"),
        ),
        ListTile(
          leading: Icon(Icons.event_note_sharp),
          title: Text("Booking"),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.help),
          title: Text("Help"),
        ),
        ListTile(
          leading: Icon(Icons.policy),
          title: Text("Privacy & Policy"),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text("Logout"),
        ),
      ],
    ),
  );
}
