import 'package:flutter/material.dart';

// Pop up window for the tips
class TipPopUp {
  static Future<void> showTips(BuildContext context, String tipText) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            backgroundColor: Colors.brown[500],
            title: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
              child: Center(
                child: Text(
                  tipText,
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
}
