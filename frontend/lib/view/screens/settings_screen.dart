import 'package:flutter/material.dart';

import '../widgets/not_found_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Settings"),
      ),
      body: Center(
        child: NotFoundLottie(
            title: "This page is currently under construction...",
            description: "We thank you for your patience."),
      ),
    );
  }
}
