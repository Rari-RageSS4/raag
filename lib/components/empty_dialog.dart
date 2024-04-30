import 'package:flutter/material.dart';
import 'package:raag/styles/textstyle.dart';

class EmptyDialog extends StatelessWidget {
  final String name;
  const EmptyDialog({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("$name is Empty",
        style: TextFontStyle.blueBold16Title,
      ),
    );
  }
}
