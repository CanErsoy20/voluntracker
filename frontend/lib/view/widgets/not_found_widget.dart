import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NotFoundLottie extends StatelessWidget {
  NotFoundLottie({super.key, required this.title, required this.description});
  String title;
  String description;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Lottie.asset(
              "assets/lotties/not_found_lottie.json",
              height: 200,
            ),
            Text(
              title,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              description,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
