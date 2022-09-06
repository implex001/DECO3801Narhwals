import 'package:flutter/material.dart';

class ShopDescriptionPanel extends StatelessWidget {
  const ShopDescriptionPanel({Key? key, required this.item, required this.purchase}) : super(key: key);

  // The item to display
  final Map<String, dynamic> item;
  final Function purchase;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image(
          image: AssetImage(item["location"]),
          height: 50,
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
          item["name"],
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.orange[200],
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
          item["description"],
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.grey[300],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextButton(
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(const Size(120, 40)),
            backgroundColor: MaterialStateProperty.all(Colors.brown[400]),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Text(
                item["cost"].toString(),
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[300],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Image(
                image: AssetImage(item["purchaseCurrency"]),
                height: 30,
              ),
            ],
          ),
          onPressed: () {purchase(item);},
        )
      ],
    );
  }
}

