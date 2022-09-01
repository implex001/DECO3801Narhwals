import 'package:flutter/material.dart';

class ShopItem extends StatefulWidget {
  const ShopItem({Key? key, required this.type, required this.item, required this.purchaseFunction}) : super(key: key);

  final String type;
  final String item;
  final Function purchaseFunction;

  @override
  State<ShopItem> createState() => _ShopItemState();
}

class _ShopItemState extends State<ShopItem> {
  @override
  void initState() {
    super.initState();
  }

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

