import 'package:flutter/material.dart';

class MyTextFieldDialog extends StatelessWidget {
  final BuildContext context;

  const MyTextFieldDialog({super.key, required this.context});
  @override
  Widget build(BuildContext context) {
    String enteredText = ''; // Variable to store the entered text

    return AlertDialog(
      title: Text('Enter Text'),
      content: TextField(
        onChanged: (value) {
          enteredText = value; // Update enteredText as the user types
        },
        decoration: InputDecoration(
          hintText: 'Type something...',
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Print the entered text to the console
            print('Entered Text: $enteredText');
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
