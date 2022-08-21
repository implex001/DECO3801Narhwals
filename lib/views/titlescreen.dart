import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class TitleScreen extends StatelessWidget {
  const TitleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.blueGrey[900],
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/idle.gif',
                  width: 19,
                ),
                Center(
                  child: Text("welcome",
                      style:
                          GoogleFonts.vt323(fontSize: 30, color: Colors.white)),
                ),
                Center(
                    child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(
                      200,
                      30,
                    ),
                  ),
                  child: AnimatedTextKit(repeatForever: true, animatedTexts: [
                    TyperAnimatedText('click to start...',
                        speed: Duration(milliseconds: 100))
                  ]),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PagePlaceholder()));
                  },
                ))
              ],
            )));
  }
}

class PagePlaceholder extends StatelessWidget {
  const PagePlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
        "this should be the page follows the title page (ie caravan page or login??)");
  }
}
