// tabs/tab_cart.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Setting extends StatelessWidget{

  final List<String> settingsItems = [
    'Notification',
    'Privacy',
    'About',
    'Log out',
    // Add more settings items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView.builder(
        itemCount: settingsItems.length,
        itemBuilder: (BuildContext context, int index) {
          final String item = settingsItems[index];
          return ListTile(
            title: Text(item),
            onTap: () {
              // Handle item tap here
              // You can navigate to a specific settings page based on the tapped item
            },
          );
        },
      ),
    );
  }
}