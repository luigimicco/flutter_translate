import 'package:flutter/material.dart';

class Bubble extends StatelessWidget {
  final String message;
  final String type;
  const Bubble({Key? key, required this.message, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          (type == "text") ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              color: (type == "text") ? Colors.blueAccent : Colors.teal,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              message,
              style: TextStyle(
                  color: Colors.white, fontSize: (type == "text") ? 12 : 10),
            ),
          ),
        ),
      ],
    );
  }
}
