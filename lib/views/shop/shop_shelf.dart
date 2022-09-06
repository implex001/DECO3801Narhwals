import 'package:flutter/material.dart';

import 'package:caravaneering/views/shop/shop_item.dart';

/*
 * Creates a single shelf within the shop page
 */
class ShopShelf extends StatefulWidget {
  const ShopShelf({Key? key, required this.type, required this.items, required this.itemClickFunction}) : super(key: key);

  // The shop type
  final String type;
  // The items to display on the shelf
  final List<Map<String, dynamic>> items;
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
          child: Column(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(70, 0, 70, 0),
                    child: SizedBox(
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Row(
                          children: [
                            ShopItem(
                              type: widget.type,
                              item: widget.items[0],
                              itemClickFunction: widget.itemClickFunction,
                            ),
                            ShopItem(
                              type: widget.type,
                              item: widget.items[1],
                              itemClickFunction: widget.itemClickFunction,
                            ),
                            ShopItem(
                              type: widget.type,
                              item: widget.items[2],
                              itemClickFunction: widget.itemClickFunction,
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
                      )
                  ),
                )
              ]
          )
      ),
    );
  }
}