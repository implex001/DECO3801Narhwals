import 'package:flutter/material.dart';

class ShopNav extends StatelessWidget {
  const ShopNav({Key? key, required this.onTapFunction}) : super(key: key);

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
