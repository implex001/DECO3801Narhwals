import 'package:flutter/material.dart';

/*
 * Creates the right hand side of the shop that contains the shop navigation
 */
class ShopNav extends StatelessWidget {
  const ShopNav({Key? key, required this.navImageHeight, required this.navImageWidth, required this.onTapFunction}) : super(key: key);

  // The function to call if the user clicks somewhere in this widget
  final Function onTapFunction;
  final double navImageHeight;
  final double navImageWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) => onTapFunction(details),
      child: Container(
        height: navImageHeight,
        width: navImageWidth,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/shop/bg-shop-nav.png'),
              fit: BoxFit.cover,
            )
        ),
      ),
    );
  }
}
