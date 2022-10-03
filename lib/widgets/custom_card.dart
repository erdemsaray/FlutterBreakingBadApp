import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String value;
  final String title;
  const CustomCard({required this.title, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: ListTile(
        leading: Text(
          title,
          style: const TextStyle(color: Colors.amberAccent, fontSize: 26),
        ),
        title: Text(
          value,
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
