import 'package:caravaneering/model/save_keys.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:caravaneering/model/save_model.dart';

class MainMenuPage {
  // Pop up window for main menu page
  static Future<void> showPage(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            backgroundColor: Colors.brown[500],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Main Menu",
                  style: TextStyle(
                    fontSize: 32.0,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
            children: <Widget>[
              Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <
                  Widget>[
                GestureDetector(
                  onTap: () {
                    Provider.of<SaveModel>(context, listen: false)
                        .addCoins(1000);
                    Provider.of<SaveModel>(context, listen: false)
                        .addGems(1000);
                    Provider.of<SaveModel>(context, listen: false).saveState();
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    height: 40,
                    width: 140,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/UI/CheatButton.png'),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Provider.of<SaveModel>(context, listen: false).eraseSave();
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    height: 40,
                    width: 123.5,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/UI/EraseButton.png'),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
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
              ])
            ],
          );
        });
  }
}
