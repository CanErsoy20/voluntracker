import 'package:flutter/material.dart';

class UndefinedScreen extends StatelessWidget {
  const UndefinedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Undefined"),
      ),
      body: const Center(
        child: Text("Page Not Found"),
      ),
    );
  }
}
