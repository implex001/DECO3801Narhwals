import 'package:flutter/material.dart';

/*
 * Displays a shop item
 */
class ShopItem extends StatefulWidget {
  const ShopItem({Key? key, required this.type, required this.item, required this.purchaseFunction}) : super(key: key);

  // The type of the shop
  final String type;
  // The item to display
  final String item;
  // The function to run if the user clicks on an item
  final Function purchaseFunction;

  @override
  State<ShopItem> createState() => _ShopItemState();
}

class _ShopItemState extends State<ShopItem> {
  @override
  void initState() {
    super.initState();
  }

  // If this widget is clicked then run the purchase function
  void itemClicked() {
    widget.purchaseFunction(widget.type, widget.item);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {itemClicked();},
        child: Container(
          margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/shop/${widget.item}'),
                fit: BoxFit.contain,
              )
          ),
        ),
      ),
    );
  }
}

