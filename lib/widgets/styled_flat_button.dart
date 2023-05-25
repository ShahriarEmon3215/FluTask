import 'package:flutter/material.dart';

import '../helpers/styles/styles.dart';

class StyledFlatButton extends StatelessWidget {
  final String? text;
  final onPressed;
  final double? radius;

  const StyledFlatButton(this.text, {this.onPressed, Key? key, this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 18.0),
        child: Text(
          this.text!,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white),
        ),
      ),
      onPressed: () {
        this.onPressed();
      },
    );
  }
}
