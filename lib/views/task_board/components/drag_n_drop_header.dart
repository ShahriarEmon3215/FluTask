import 'package:flutter/material.dart';

class DragNDropListHeaderUI extends StatelessWidget {
  const DragNDropListHeaderUI({
    super.key,
    required this.label
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(7.0)),
              color: Colors.green,
            ),
            padding: const EdgeInsets.all(10),
            child: Text(
              label,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}