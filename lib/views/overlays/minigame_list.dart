
import 'package:flutter/material.dart';
import 'package:caravaneering/views/play_sound.dart';

class MinigameSelectorPage {
  // Pop up window for minigame selector page
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
                  "Select a minigame:",
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
                    Navigator.pop(context);
                    Navigator.pushNamed(
                      context, "/cave-intro"
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    height: 40,
                    width: 276,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/UI/Cave.png'),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "More minigames coming Soon!",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[300],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    PlaySoundUtil.instance().play("audio/button_click.mp3");
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
