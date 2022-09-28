import 'dart:async';

import 'package:flutter/material.dart';

class CoinCollectAnimation extends StatefulWidget {
  const CoinCollectAnimation({Key? key}) : super(key: key);

  @override
  State<CoinCollectAnimation> createState() => _CoinCollectAnimationState();
}

class _CoinCollectAnimationState extends State<CoinCollectAnimation> {
  final Duration duration = const Duration(milliseconds: 1000);
  final Duration delay = const Duration(milliseconds: 100);
  final List<double> topPositions = [];
  final List<double> leftPositions = [];
  final List<double> turns = [];

  int startTop = 0;
  int endTop = 0;
  int startLeft = 0;
  int endLeft = 0;
  int startTurn = 0;
  int endTurn = 0;

  int numCoins = 1;

  void setValues(
      {required int numCoins,
      required int startTop,
      required int endTop,
      required int startLeft,
      required int endLeft,
      required int startTurn,
      required int endTurn}) {
    this.numCoins = numCoins;
    this.startTop = startTop;
    this.endTop = endTop;
    this.startLeft = startLeft;
    this.endLeft = endLeft;
    this.startTurn = startTurn;
    this.endTurn = endTurn;
    _generateCoinPositions();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _buildAllCoins(),
    );
  }

  void play() {
    for (int i = 0; i < numCoins; i++) {
      _animateCoin(i);
    }
  }

  List<Widget> _buildAllCoins() {
    List<Widget> coins = [];
    for (int i = 0; i < numCoins; i++) {
      coins.add(_buildCoin(i));
    }
    return coins;
  }

  Widget _buildCoin(int index) {
    return AnimatedPositioned(
        duration: duration,
        top: topPositions[index],
        left: leftPositions[index],
        child: AnimatedRotation(
          duration: duration,
          turns: 1,
          child: Image.asset('assets/images/UI/coin.png'),
        ));
  }

  void _generateCoinPositions() {
    topPositions.clear();
    leftPositions.clear();
    turns.clear();
    for (int i = 0; i < numCoins; i++) {
      topPositions.add(startTop.toDouble());
      leftPositions.add(startLeft.toDouble());
      turns.add(startTurn.toDouble());
    }
  }

  void _animateCoin(int index) {
    Timer(delay * index, () {
      setState(() {
        topPositions[index] = endTop.toDouble();
        leftPositions[index] = endLeft.toDouble();
        turns[index] = endTurn.toDouble();
      });
    });
  }
}
