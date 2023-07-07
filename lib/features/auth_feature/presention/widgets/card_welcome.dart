import 'package:auth_with_phone_number/core/utils/constant.dart';
import 'package:flutter/material.dart';

class CardWelcome extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  const CardWelcome(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.imagePath});

  get kdarkColor => null;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kButtonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: kdarkColor,
              ),
              textAlign: TextAlign.right,
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: kdarkColor,
              ),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 10.0),
            Image.asset(
              imagePath,
              fit: BoxFit.fitHeight,
              width: 200,
              height: 130,
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
