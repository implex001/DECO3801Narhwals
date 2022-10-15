import 'package:flutter/material.dart';
import 'package:caravaneering/model/items_details.dart';
import 'package:caravaneering/views/play_sound.dart';


class PurchaseConfirmationPage {
  // Pop up window for shop purchase confirmation page
  static Future<void> showPage(BuildContext context, bool enoughCurrency, Map<String, dynamic> item, Function purchase) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            backgroundColor: Colors.brown[500],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                   (item.containsKey('name')) ? "${item["name"]} for ${item["cost"].toString()}" : "${item["cost"].toString()}",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[300],
                  ),
                ),
                Image(
                  image: AssetImage((item["purchaseCurrency"] == ItemDetails.gems) ? ItemDetails.gemImagePath : ItemDetails.coinImagePath),
                  height: 32,
                ),
              ],
            ),
            children: <Widget>[
              Image(
                image: AssetImage(item["location"]),
                height: 80,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget> [
                    GestureDetector(
                      onTap: () {
                        PlaySoundUtil.instance().play("audio/button_click.mp3");
                        Navigator.pop(context);},
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        height: 40,
                        width: 140,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/UI/CancelButton.png'),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (enoughCurrency) {
                          PlaySoundUtil.instance().play("audio/purchase.mp3");
                          purchase();
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        height: 40,
                        width: 88,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(enoughCurrency ? 'assets/images/UI/BuyButton.png' : 'assets/images/UI/BuyButtonDisabled.png'),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                  ]
              )
            ],
          );
        });
  }
}
