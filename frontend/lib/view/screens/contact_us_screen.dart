import 'package:afet_takip/view/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Create New Help Center"),
      ),
      endDrawer: CustomDrawer(loggedIn: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contact Us',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )
            ),
            SizedBox(height: 20),
            const Text(
              'If you have any questions or suggestions, please feel free to contact us using the form below:',
              style: TextStyle(
                color: Colors.white

              )
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle form submission
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}