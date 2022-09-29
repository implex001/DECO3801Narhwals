import 'dart:async';

import 'package:caravaneering/games/caravan_game.dart';
import 'package:flutter/material.dart';

// For flame use only
Widget coinOverlay(BuildContext buildContext, CaravanGame game) {
  return game.coinCollectAnimation;
}

class CoinCollectAnimation extends StatefulWidget {
  const CoinCollectAnimation(
      {Key? key,
      required this.startTop,
      required this.endTop,
      required this.startLeft,
      required this.endLeft,
      required this.startTurn,
      required this.endTurn,
      required this.numCoins,
      this.startScale = 1,
      this.endScale = 1})
      : super(key: key);

  final double startTop;
  final double endTop;
  final double startLeft;
  final double endLeft;
  final int startTurn;
  final int endTurn;
  final double startScale;
  final double endScale;

  final int numCoins;

  @override
  State<CoinCollectAnimation> createState() => _CoinCollectAnimationState();
}

class _CoinCollectAnimationState extends State<CoinCollectAnimation> {
  final Duration duration = const Duration(milliseconds: 1000);
  final Duration delay = const Duration(milliseconds: 100);
  final List<double> topPositions = [];
  final List<double> leftPositions = [];
  final List<double> turns = [];
  final List<double> scales = [];

  @override
  void initState() {
    super.initState();
    _generateCoinPositions();
    play();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _buildAllCoins(),
    );
  }

  void play() {
    for (int i = 0; i < widget.numCoins; i++) {
      _animateCoin(i);
    }
  }

  List<Widget> _buildAllCoins() {
    List<Widget> coins = [];
    for (int i = 0; i < widget.numCoins; i++) {
      coins.add(_buildCoin(i));
    }
    return coins;
  }

  Widget _buildCoin(int index) {
    return AnimatedPositioned(
        duration: duration,
        top: topPositions[index],
        left: leftPositions[index],
        curve: Curves.easeInQuint,
        child: AnimatedRotation(
          duration: duration,
          turns: turns[index],
          child: AnimatedScale(
              duration: duration,
              scale: scales[index],
              curve: Curves.easeInExpo,
              child: Image.asset('assets/images/UI/CoinIcon.png')),
        ));
  }

  void _generateCoinPositions() {
    topPositions.clear();
    leftPositions.clear();
    turns.clear();
    for (int i = 0; i < widget.numCoins; i++) {
      topPositions.add(widget.startTop.toDouble());
      leftPositions.add(widget.startLeft.toDouble());
      turns.add(widget.startTurn.toDouble());
      scales.add(widget.startScale.toDouble());
    }
  }

  void _animateCoin(int index) {
    Timer(delay * index, () {
      setState(() {
        topPositions[index] = widget.endTop.toDouble();
        leftPositions[index] = widget.endLeft.toDouble();
        turns[index] = widget.endTurn.toDouble();
        scales[index] = widget.endScale.toDouble();
      });
    });
  }
}
