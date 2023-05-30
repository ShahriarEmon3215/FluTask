import 'package:flutter/material.dart';
import 'package:progress_loading_button/progress_loading_button.dart';

class StyledFlatButton extends StatelessWidget {
  final String? text;
  final onPressed;
  final double? radius;

  const StyledFlatButton(this.text, {this.onPressed, Key? key, this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingButton(
      defaultWidget: Text(
        this.text!,
        style: Theme.of(context)
            .textTheme
            .displayMedium!
            .copyWith(color: Colors.white),
      ),
      width: 196,
      height: 60,
      borderRadius: 20,
      animate: true,
      loadingWidget: const CircularProgressIndicator(color: Colors.white),
      color: Theme.of(context).primaryColor,
      onPressed: () async {
        await this.onPressed();
      },
    );
  }
}
