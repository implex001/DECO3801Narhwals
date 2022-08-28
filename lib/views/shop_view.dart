import 'package:flutter/material.dart';

import 'package:caravaneering/model/save_model.dart';

class ShopView extends StatefulWidget {
  const ShopView({Key? key}) : super(key: key);

  @override
  State<ShopView> createState() => _ShopState();
}

class _ShopState extends State<ShopView> {

  SaveModel? save;

  static const horseKey = "horse";

  Map<String, List<String>> shopItemsDefaults = {
    horseKey: [
      "horse-yellow.png", "horse-dark-grey.png", "horse-light-grey.png",
      "horse-blue.png", "horse-dark-blue.png", "horse-light-green.png",
      "horse-dark-green.png", "horse-pink.png", "horse-purple.png",
    ],
  };

  Map<String, List<String>> shopItems = {};

  Map<String, String> shopSoldOutVisual = {
    horseKey: "horse-sold-out.png",
  };

  @override
  void initState() {
    super.initState();
    setItemsToLoading();
    if (save == null) {
      save = SaveModel();
      save?.init().then((s) => setUpItems(s));
    } else {
      setUpItems(save!);
    }
  }

  void setItemsToLoading() {
    setState(() {
      for (String shopType in shopItemsDefaults.keys) {
        shopItems[shopType] = [];
        for (int i = 0; i < shopItemsDefaults[shopType]!.length; i++) {
          shopItems[shopType]!.add("loading-item.png");
        }
      }
    });
  }

  void setUpItems(SaveModel s) {
    setState(() {
      for (String shopType in shopItemsDefaults.keys) {
        for (int i = 0; i < shopItemsDefaults[shopType]!.length; i++) {
          String horse = shopItemsDefaults[shopType]![i];
          if (s.checkIfHorseOwned(horse)) {
            shopItems[shopType]![i] = shopSoldOutVisual[shopType]!;
          } else {
            shopItems[shopType]![i] = shopItemsDefaults[shopType]![i];
          }
        }
      }
    });
  }

  void purchaseItem(String type, String item) {
    setState(() {
      // If the item is sold out then return early
      if (item == shopSoldOutVisual[type]!) {
        return;
      }
      int purchaseIndex = shopItems[type]!.indexOf(item);
      shopItems[type]![purchaseIndex] = shopSoldOutVisual[type]!;
      switch (type) {
        case horseKey:
          if (save != null) {
            save?.addHorse(item);
            save?.saveState();
          }
      }
    });
  }

  void temporaryFunctionDeleteSaveData() async {
    await save?.eraseSave();
    setItemsToLoading();
    setUpItems(save!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(40.0),
          child: AppBar(
            title: const Text("GAME MENU WILL GO HERE"),
            backgroundColor: Colors.orange[200],
        )
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 10,
              child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/shop/bg-curtain.png'),
                      fit: BoxFit.cover,
                    )
                  ),
                child: Column(
                  children: [
                    Image.asset('assets/images/shop/bg-rack-top-bar.png'),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/shop/bg-rack-ropes.png'),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              ShopShelf(
                                type: horseKey,
                                items: [shopItems[horseKey]![0], shopItems[horseKey]![1], shopItems[horseKey]![2]],
                                purchaseFunction: purchaseItem,
                              ),
                              ShopShelf(
                                type: horseKey,
                                items: [shopItems[horseKey]![3], shopItems[horseKey]![4], shopItems[horseKey]![5]],
                                purchaseFunction: purchaseItem,
                              ),
                              ShopShelf(
                                type: horseKey,
                                items: [shopItems[horseKey]![6], shopItems[horseKey]![7], shopItems[horseKey]![8]],
                                purchaseFunction: purchaseItem,
                              ),
                            ]
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              )
            ),
            ShopNav(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          temporaryFunctionDeleteSaveData();
          },
        tooltip: 'Erase Save',
        child: const Icon(Icons.recycling),
      ),
    );
  }
}

class ShopNav extends StatelessWidget {
  const ShopNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/shop/bg-shop-right.png'),
            fit: BoxFit.cover,
          )
        ),
      ),
    );
  }
}



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


class ShopShelf extends StatefulWidget {
  const ShopShelf({Key? key, required this.type, required this.items, required this.purchaseFunction}) : super(key: key);

  final String type;
  final List<String> items;
  final Function purchaseFunction;

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
      child: Container(
        height: 100,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(70, 0, 70, 0),
                child: Container(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Row(
                      children: [
                        ShopItem(
                            type: widget.type,
                            item: widget.items[0],
                            purchaseFunction: widget.purchaseFunction,
                        ),
                        ShopItem(
                            type: widget.type,
                            item: widget.items[1],
                            purchaseFunction: widget.purchaseFunction,
                        ),
                        ShopItem(
                            type: widget.type,
                            item: widget.items[2],
                            purchaseFunction: widget.purchaseFunction,
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