import 'package:caravaneering/model/items_details.dart';
import 'package:flutter/material.dart';

/*
 * Creates the right hand side of the shop that contains the shop navigation
 */
class ShopNav extends StatefulWidget {
  const ShopNav({Key? key, required this.navImageHeight, required this.navImageWidth, required this.onTapFunction, required this.shopType}) : super(key: key);

  // The function to call if the user clicks somewhere in this widget
  final Function onTapFunction;
  final double navImageHeight;
  final double navImageWidth;
  final String shopType;


  @override
  State<ShopNav> createState() => _ShopNavState();
}

class _ShopNavState extends State<ShopNav> {
  String shopNavImage = 'assets/images/shop/bg-shop-nav.png';
  @override
  Widget build(BuildContext context) {
    // print("shopType are: ${widget.shopType}")
    switch (widget.shopType) {
      case ItemDetails.horseKey:
        shopNavImage = 'assets/images/shop/Shop-Right-Bottom-Horse.gif';
        break;
      case ItemDetails.cartKey:
        shopNavImage = 'assets/images/shop/Shop-Right-Bottom-Cart.gif';
        break;
      case ItemDetails.petKey:
       shopNavImage = 'assets/images/shop/Shop-Right-Bottom-Pet.gif';
        break;
    }

    return GestureDetector(
      onTapDown: (TapDownDetails details) => widget.onTapFunction(details),
      child: Container(
        height: widget.navImageHeight,
        width: widget.navImageWidth,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(shopNavImage),
              fit: BoxFit.cover,
            )
        ),
      ),
    );
  }
}
