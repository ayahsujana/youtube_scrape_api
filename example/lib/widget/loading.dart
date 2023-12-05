import 'package:flutter/material.dart';

import 'color_loader.dart';

class Loading extends StatelessWidget {
  const Loading({super.key, this.showMessage = true});

  final bool showMessage;

  @override
  Widget build(BuildContext context) {
    return const FittedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ColorLoader(),
        ],
      ),
    );
  }
}
