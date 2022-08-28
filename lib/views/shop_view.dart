import 'package:caravaneering/games/caravan_game.dart';
import 'package:caravaneering/views/overlays/caravan_bar_overlay.dart';
import 'package:flame/game.dart';
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
              flex: 1,
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red[900],
                  ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ShopShelf(),
                      ShopShelf(),
                      ShopShelf()
                    ]
                  ),
                )
              )
            ),
            Container(
              width: 200,
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                    ),
                  ),
                  ShopNav(),
                ]
              )
            ),
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
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[200],
        ),
      ),
    );
  }
}



class ShopItem extends StatelessWidget {
  const ShopItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
        decoration: BoxDecoration(
          color: Colors.red[500],
        ),
      ),
    );
  }
}


class ShopShelf extends StatefulWidget {
  const ShopShelf({Key? key}) : super(key: key);

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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.red[100],
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.red[200],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Row(
                      children: [
                        ShopItem(),
                        ShopItem(),
                        ShopItem(),
                        ShopItem(),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.red[300],
                ),
              )
            ]
          )
        ),
      ),
    );
  }
}