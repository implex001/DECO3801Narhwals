import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}


class Mushroom extends StatefulWidget {
  const Mushroom(void moveMent, {Key? key}) : super(key: key);

  @override
  State<Mushroom> createState() => _MushroomState();
}

class _MushroomState extends State<Mushroom> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset("lib/images/mushroom.png"),
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Caravan(),
    );
  }
}

class Caravan extends StatefulWidget {
  const Caravan({Key? key}) : super(key: key);

  @override
  State<Caravan> createState() => _CaravanState();
}

class _CaravanState extends State<Caravan> {

  double missileX = -1; 

  void moveMent() {
    Timer.periodic(Duration(milliseconds: 100), (timer) {
        setState(() {
        missileX += 0.00001;
      });
    });
  }

  void resetMushroom() {
    missileX = -1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.blue[500],
              child: Align(
                child: Text(
                'Caravan',
                textAlign: TextAlign.center,
                style: TextStyle(
                fontSize: 25,
                ),
              ),
              )
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.blue[200],
              child: AnimatedContainer(
                alignment: Alignment(missileX, 1),
                duration: Duration(milliseconds: 100),
                child: Mushroom(
                  moveMent(),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.green[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    child: Text("menu"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue[400]),   
                      textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16)),            
                    ),
                    onPressed: () {},
                  ),
                  ElevatedButton(
                    child: Text("skill"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue[400]),   
                      textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16)),           
                    ),
                    onPressed: () {},
                  ),
                ],
              )   
            )
          )  
        ]
      ),
    );
  }
}
