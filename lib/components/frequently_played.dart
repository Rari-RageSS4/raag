import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FrequentlyPlayed extends StatelessWidget {
  const FrequentlyPlayed({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey
                ),
              ),
    );
  }
}