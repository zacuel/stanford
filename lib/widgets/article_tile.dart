import 'package:flutter/material.dart';
import '../theme/pallete.dart';

class ArticleTile extends StatelessWidget {
  final String title;
  final String exciteLine;
  final Color borderColor;
  const ArticleTile(
      {super.key,
      required this.title,
      required this.exciteLine,
      this.borderColor = Colors.red});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(width: 10, color: borderColor),
        borderRadius: BorderRadius.circular(20),
        color: Pallete.pastelIndigo.withOpacity(.5),
      ),
      child: Column(children: [
        Text('title'),
      ]),
    );
  }
}
