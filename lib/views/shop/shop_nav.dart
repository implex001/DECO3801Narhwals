import 'package:flutter/material.dart';

/*
 * Creates the right hand side of the shop that contains the shop navigation
 */
class ShopNav extends StatelessWidget {
  const ShopNav({Key? key, required this.onTapFunction}) : super(key: key);

  // The function to call if the user clicks somewhere in this widget
  final Function onTapFunction;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: GestureDetector(
        onTapDown: (TapDownDetails details) => onTapFunction(details),
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/shop/bg-shop-right.png'),
                fit: BoxFit.cover,
              )
          ),
        ),
      ),
    );
  }
}
