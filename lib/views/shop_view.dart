import 'package:flutter/material.dart';

class ShopView extends StatefulWidget {
  const ShopView({Key? key}) : super(key: key);

  @override
  State<ShopView> createState() => _ShopState();
}

class _ShopState extends State<ShopView> {

  @override
  void initState() {
    super.initState();
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
                              ShopShelf(items: ["horse-yellow.png", "horse-sold-out.png", "horse-sold-out.png"]),
                              ShopShelf(items: ["horse-sold-out.png", "horse-dark-grey.png", "horse-sold-out.png"]),
                              ShopShelf(items: ["horse-sold-out.png", "horse-sold-out.png", "horse-light-grey.png"])
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
  const ShopItem({Key? key, required this.item}) : super(key: key);

  final String item;

  @override
  State<ShopItem> createState() => _ShopItemState();
}



class _ShopItemState extends State<ShopItem> {
  @override
  void initState() {
    super.initState();
  }

  void itemClicked() {
    //TODO: If in inventory then sold out
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
  const ShopShelf({Key? key, required this.items}) : super(key: key);

  final List<String> items;

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
                        ShopItem(item: widget.items[0]),
                        ShopItem(item: widget.items[1]),
                        ShopItem(item: widget.items[2]),
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