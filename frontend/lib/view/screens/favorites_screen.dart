import 'package:flutter/material.dart';
import 'package:voluntracker/view/widgets/not_found_widget.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Favorites"),
      ),
      body: Center(
        child: NotFoundLottie(
            title: "This page is currently under construction...",
            description: "We thank you for your patience."),
      ),
    );
  }
}
