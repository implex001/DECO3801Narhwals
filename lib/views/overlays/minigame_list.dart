import 'package:flutter/material.dart';

class MiniGameList extends StatelessWidget {

  const MiniGameList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child:
        ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/minigames/jump");
                },
                child: Text("Minigame 1")
            ),
            TextButton(onPressed: (){}, child: Text("Placeholder")),
            TextButton(onPressed: (){}, child: Text("Placeholder")),
            TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text("Back")
            ),
          ],
        ),
    );
  }
}
