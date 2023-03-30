import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final int? id;
  final String? firstname;
  final String? surname;
  final String? email;
  final String? phone;
  final String? createdAt;
  final String? userRole;
  final bool? isCurrentUser;

  ProfileScreen({
    this.id,
    this.firstname,
    this.surname,
    this.email,
    this.phone,
    this.createdAt,
    this.userRole,
    this.isCurrentUser,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40.0,
                  backgroundImage: NetworkImage(
                      'https://picsum.photos/seed/picsum/200/300'),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${firstname ?? ""} ${surname ?? ""}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'ID: ${id ?? ""}',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '${userRole ?? ""}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey[300]!,
                  ),
                ),
              ),
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  SizedBox(height: 16.0),
                  buildProfileInfoRow(Icons.email, 'Email', email ?? ""),
                  buildProfileInfoRow(Icons.phone, 'Phone', phone ?? ""),
                  buildProfileInfoRow(
                      Icons.date_range, 'Joined On', createdAt ?? ""),
                  SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfileInfoRow(IconData iconData, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(iconData, size: 24.0, color: Colors.grey[600]),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}