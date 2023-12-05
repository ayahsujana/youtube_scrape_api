import 'package:skibidiwartube/utils/ext/text_style_extension.dart';
import 'package:flutter/material.dart';

class KhmertracksSubTitle extends StatelessWidget {
  const KhmertracksSubTitle(this.title,
      {super.key, this.maxLines = 1, this.center = false});
  final String? title;
  final int? maxLines;
  final bool center;
  @override
  Widget build(BuildContext context) {
    return Text(title!,
        overflow: TextOverflow.ellipsis,
        maxLines: maxLines,
        textAlign: center ? TextAlign.center : TextAlign.start,
        style: context.bodySmall?.copyWith(fontSize: 14));
  }
}
