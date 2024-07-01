import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';

class TermsDialog {
  static Future<void> show(BuildContext context, String title, String filePath) async {
    String content = await rootBundle.loadString(filePath);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Container(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height * 0.6,
            child: Markdown(
              data: content,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
