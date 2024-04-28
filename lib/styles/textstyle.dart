import 'package:flutter/material.dart';

class TextFontStyle{
  static const boldWhiteTitle = TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  );
  static const whiteSubTitle = TextStyle(
                    color: Colors.white,
                  );
  static const italicWhiteSubTitle = TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 17,
                        color: Colors.white,
                      );
  static const blueTitle = TextStyle(color: Color.fromARGB(255, 0, 67, 100));
  static const lightBlueTitle = TextStyle(
                  color: Color.fromARGB(255, 0, 116, 174),
                );
  static const blueBold16Title = TextStyle(
                  color: Color.fromARGB(255, 0, 88, 132),
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                );
  static const blueBoldTitle = TextStyle(
          color: Color.fromARGB(255, 0, 82, 123),
          fontWeight: FontWeight.bold,
         );
}