import "dart:ui";

import "package:flutter/material.dart";


class Hourly extends StatelessWidget {
  final String samay;
  final IconData icon;
  final String value;
  const Hourly({
    super.key,
    required this.samay,
    required this.icon,
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          margin: const EdgeInsets.all(15),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
              child:  Column(
                children: [
                  Text(
                    samay,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Icon(
                    icon,
                    size: 30,
                  ),
                  Text(
                    value,
                    style:
                       const TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
