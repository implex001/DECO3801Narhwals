import 'package:flutter/material.dart';
import '../skills/flicker.dart';

/// Displays a shop item
class ShopItem extends StatefulWidget {
  const ShopItem(
      {Key? key,
      required this.item,
      required this.itemClickFunction,
      this.showFlicker = false})
      : super(key: key);

  // The item to display
  final Map<String, dynamic> item;

  // The function to run if the user clicks on an item
  final Function itemClickFunction;
  final bool showFlicker;

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
    widget.itemClickFunction(widget.item);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          itemClicked();
        },
        child: widget.showFlicker
            ? FlickerAnimation(
                iconPath: Container(
                  margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(widget.item["location"]),
                    fit: BoxFit.contain,
                  )),
                ),
                t_width: 120,
                t_height: 120,
              )
            : Container(
                margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(widget.item["location"]),
                  fit: BoxFit.contain,
                )),
              ),
      ),
    );
  }
}
