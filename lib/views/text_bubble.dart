import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';

class TextBubble extends StatelessWidget {
  final String text;
  double? width;
  double? height;
  EdgeInsetsGeometry? padding;
  double? fontSize;

  TextBubble(
      {Key? key,
      required this.text,
      this.width,
      this.height,
      this.padding,
      this.fontSize = 12})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NineTileBoxWidget.asset(
        path: "UI/speechbubble.png",
        tileSize: 95,
        destTileSize: 95,
        width: width,
        height: height,
        padding: padding,
        child: SizedBox(
          child: Text(text,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: fontSize,
                  decoration: TextDecoration.none)),
        ));
  }
}
