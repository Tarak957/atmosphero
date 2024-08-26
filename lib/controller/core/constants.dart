import 'package:flutter/material.dart';

class CustomColor {
  static Color black = Colors.black;
  static Color white = Colors.white;
  static Color purple = Colors.deepPurple;
  static Color grey = Colors.grey;
  static Color red = const Color(0xFFDA2128);
  static const colorCard = Color(0xffE9ECF1);
  static const gradientColorOne = Color(0xff408ADE);
  static const gradientColorTwo = Color(0xff5286CD);
  static const dividerLine = Color(0xffE4E4EE);
}

class CustomFuction {
  static TextStyle textStyleFuction(
      {required double size, required FontWeight fontWeight, Color? color}) {
    return TextStyle(fontWeight: fontWeight, color: color, fontSize: size);
  }

  static BoxDecoration gradient = const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF55ADF6),
        Color(0x1AF2EEEE),
        Color(0xFF85C5F9),
      ],
    ),
  );
  static BoxDecoration errorGradient = const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFFDA2128),
        Color(0x1AFFFFFF),
        Color(0x1AFFFFFF),
        Color(0xFFDA2128),
      ],
    ),
  );
}

class CustomHeights {
  static commonHeight(context) {
    Size size = MediaQuery.of(context).size;
    var height = SizedBox(
      height: size.height * 0.03,
    );
    return height;
  }

  static minHeight(context) {
    Size size = MediaQuery.of(context).size;
    var height = SizedBox(
      height: size.height * 0.01,
    );
    return height;
  }
}

class CustomWidth {
  static commonwidth(context) {
    Size size = MediaQuery.of(context).size;
    var width = SizedBox(
      width: size.height * 0.01,
    );
    return width;
  }
}
