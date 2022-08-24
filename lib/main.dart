import 'package:caravaneering/views/caravan_view.dart';

import 'package:flutter/material.dart';


void main() {
  runApp(const CaravanView(title: 'Flutter Demo Home Page'));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CaravanView(title: 'Flutter Demo Home Page'),
    );
  }
}


