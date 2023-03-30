import 'package:afet_takip/models/user/user_info.dart';
import 'package:afet_takip/view/widgets/custom_drawer.dart';
import 'package:afet_takip/view/widgets/custom_menu_card.dart';
import 'package:flutter/material.dart';


class LandingPage extends StatelessWidget {
  final List<String> items = List.generate(20, (index) => "Item $index");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Voluntracker"),
        centerTitle: true,
      ),
      endDrawer: CustomDrawer(loggedIn: UserInfo.loggedUser != null),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Welcome to Voluntracker!",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                "Voluntracker is a volunteer management system that helps you manage your volunteers and their tasks.",
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 1.0,
                padding: EdgeInsets.all(8.0),
                children: List.generate(items.length, (index) {
                  return CustomMenuCard(title: "Card $index");
                }),
                ),
            ],
          ),
        ),
        ),
      );
  }
}