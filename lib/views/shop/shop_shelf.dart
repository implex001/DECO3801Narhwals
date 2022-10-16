import 'package:flutter/material.dart';

import 'package:caravaneering/views/shop/shop_item.dart';

/// Single shelf of the shop page
class ShopShelf extends StatefulWidget {
  const ShopShelf(
      {Key? key,
      required this.items,
      required this.shopingItem,
      required this.itemClickFunction})
      : super(key: key);

  // The items to display on the shelf
  final List<Map<String, dynamic>> items;
  final Map<String, dynamic> shopingItem;

  // The function to run if the user clicks on an item
  final Function itemClickFunction;

  @override
  State<ShopShelf> createState() => _ShopShelfState();
}

class _ShopShelfState extends State<ShopShelf> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
          height: 100,
          child: Column(children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(70, 10, 70, 0),
                child: SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Row(
                      children: [
                        ShopItem(
                          item: widget.items[0],
                          itemClickFunction: widget.itemClickFunction,
                          showFlicker: widget.shopingItem == widget.items[0],
                        ),
                        ShopItem(
                          item: widget.items[1],
                          itemClickFunction: widget.itemClickFunction,
                          showFlicker: widget.shopingItem == widget.items[1],
                        ),
                        ShopItem(
                          item: widget.items[2],
                          itemClickFunction: widget.itemClickFunction,
                          showFlicker: widget.shopingItem == widget.items[2],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 10,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/shop/bg-shelf-base.png'),
                fit: BoxFit.fitWidth,
              )),
            )
          ])),
    );
  }
}
