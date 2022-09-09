import 'package:caravaneering/games/caravan_game.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:caravaneering/model/save_model.dart';

/// Game engine function to build navbar overlay.
/// For Flame use only
Widget flameNavbarOverlay(BuildContext buildContext, CaravanGame game) {
  return const NavBar();
}

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [NavbarLeftOverlay(), NavbarRightOverlay()],
      ),
      NavbarBottomOverlay(),
    ]);
  }
}

class NavbarLeftOverlay extends StatefulWidget {
  NavbarLeftOverlay({Key? key});

  @override
  State<NavbarLeftOverlay> createState() => _NavbarLeftOverlayState();
}

class _NavbarLeftOverlayState extends State<NavbarLeftOverlay> {
  String route = "";
  String menuButtonImage = 'assets/images/UI/Menu.png';
  String shopButtonImage = 'assets/images/UI/Shop.png';
  String skillsButtonImage = 'assets/images/UI/Skills.png';
  String caravanButtonImage = 'assets/images/UI/Caravan.png';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ModalRoute.of(context) != null &&
        ModalRoute.of(context)!.settings.name != null) {
      route = ModalRoute.of(context)!.settings.name!;
      switch (route) {
        case "/menu":
          menuButtonImage = 'assets/images/UI/MenuSelected.png';
          break;
        case "/shop":
          shopButtonImage = 'assets/images/UI/ShopSelected.png';
          break;
        case "/skills":
          skillsButtonImage = 'assets/images/UI/SkillsSelected.png';
          break;
        case "/caravan":
          caravanButtonImage = 'assets/images/UI/CaravanSelected.png';
          break;
      }
    }
  }

  // Pop up window for menu page
  Future<void> menuPage() async {
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
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <
                  Widget>[
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
              ])
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      GestureDetector(
          onTap: () {
            menuPage();
          },
          child: Image.asset(
            menuButtonImage,
            fit: BoxFit.contain,
            height: 30,
          )),
      GestureDetector(
          onTap: () {
            if (route != "/shop") {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/shop", (route) => false);
            }
          },
          child: Image.asset(
            shopButtonImage,
            fit: BoxFit.contain,
            height: 30,
          )),
      GestureDetector(
          onTap: () {
            Navigator.pushNamed(
                context, "/skills");
          },
          child: Image.asset(
            skillsButtonImage,
            fit: BoxFit.contain,
            height: 30,
          )),
      GestureDetector(
          onTap: () {
            if (route != "/caravan") {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/caravan", (route) => false);
            }
          },
          child: Image.asset(
            caravanButtonImage,
            fit: BoxFit.contain,
            height: 30,
          )),
    ]);
  }
}

class NavbarRightOverlay extends StatefulWidget {
  NavbarRightOverlay({Key? key});

  @override
  State<NavbarRightOverlay> createState() => _NavbarRightOverlayState();
}

class _NavbarRightOverlayState extends State<NavbarRightOverlay> {
  SaveModel? save;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    save ??= Provider.of<SaveModel>(context, listen: true);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(alignment: AlignmentDirectional.center, children: [
          Image.asset(
            'assets/images/UI/Coins.png',
            height: 30,
            fit: BoxFit.contain,
          ),
          const DefaultTextStyle(
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 20,
            ),
            child: Text(
              'XXXX', // Place holder for number of coins
              textAlign: TextAlign.center,
            ),
          )
        ]),
        Stack(alignment: AlignmentDirectional.center, children: [
          Image.asset(
            'assets/images/UI/Gems.png',
            height: 30,
            fit: BoxFit.contain,
          ),
          const DefaultTextStyle(
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 20,
            ),
            child: Text(
              'XXXX', // Place holder for number of gems
              textAlign: TextAlign.center,
            ),
          )
        ]),
      ],
    );
  }
}

class NavbarBottomOverlay extends StatefulWidget {
  NavbarBottomOverlay({Key? key});

  @override
  State<NavbarBottomOverlay> createState() => _NavbarBottomOverlayState();
}

class _NavbarBottomOverlayState extends State<NavbarBottomOverlay> {
  // Pop up window for coming soon
  Future<void> comingSoonPrompt() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            backgroundColor: Colors.brown[500],
            title: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
              child: Center(
                child: Text(
                  "Story Coming Soon",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[300],
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      GestureDetector(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, "/minigames", (route) => false);
          },
          child: Image.asset(
            'assets/images/UI/Minigames.png',
            fit: BoxFit.contain,
            height: 30,
          )),
      GestureDetector(
          onTap: () {
            comingSoonPrompt();
          },
          child: Image.asset(
            'assets/images/UI/Story.png',
            fit: BoxFit.contain,
            height: 30,
          )),
    ]);
  }
}
