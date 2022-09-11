import 'package:flutter/material.dart';

class ComingSoonPage {
  // Pop up window for coming soon page
  static Future<void> showPage(BuildContext context, String comingSoonText) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            backgroundColor: Colors.brown[500],
            title: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
              child: Center(
                child: Text(
                  comingSoonText,
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
