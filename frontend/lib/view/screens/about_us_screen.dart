import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("About Us"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Meet Our Team',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView(
                children: [
                  _buildTeamMember(
                    name: 'Tolga Özgün',
                    email: 'tolgaozgun@gmail.com',
                    image: AssetImage('assets/images/team/tolga.png'),
                  ),
                  _buildTeamMember(
                    name: 'Can Ersoy',
                    email: 'canersoy2002@gmail.com',
                    image: AssetImage('images/team/can.jpeg'),
                  ),
                  _buildTeamMember(
                    name: 'Selim Can Güler',
                    email: 'cs.selim.guler@gmail.com',
                    image: AssetImage('images/team/selim.JPG'),
                  ),
                  _buildTeamMember(
                    name: 'Berra Yüce',
                    email: 'berrayuce@gmail.com',
                    image: AssetImage('images/team/berra.jpg'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamMember({
    required String name,
    required String email,
    required ImageProvider<Object> image,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundImage: image,
          ),
          SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                email,
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}