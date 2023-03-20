import 'package:afet_takip/helper_functions.dart';
import 'package:flutter/material.dart';

class CustomNeedCard extends StatelessWidget {
  const CustomNeedCard({
    super.key,
    required this.needName,
    required this.needCategory,
    required this.quantity,
    required this.lastUpdatedAt,
    this.trailing,
    this.leading,
  });
  final String needName;
  final String needCategory;
  final int quantity;
  final String lastUpdatedAt;
  final Widget? trailing;
  final Widget? leading;
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        margin: const EdgeInsets.all(5),
        elevation: 10,
        child: ListTile(
          contentPadding: const EdgeInsets.all(10),
          title: Column(
            children: [
              Text("Name: $needName"),
              Text("Category: $needCategory"),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // LinearPercentIndicator(
                //   animation: true,
                //   lineHeight: 20.0,
                //   animationDuration: 2500,
                //   percent: needPercent,
                //   center: Text("${needPercent * 100}%"),
                //   barRadius: const Radius.circular(20),
                //   progressColor: Colors.green,
                // ),
                Text("Needed Quantity: $quantity"),
                Text(
                    "Last Updated At: ${HelperFunctions.formatDateToTime(lastUpdatedAt)}")
              ],
            ),
          ),
          trailing: trailing,
          minLeadingWidth: 30,
          horizontalTitleGap: 0,
          leading: leading,
        ));
  }
}
