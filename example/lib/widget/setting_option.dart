import 'package:skibidiwartube/utils/text/subtitle.dart';
import 'package:skibidiwartube/utils/text/title.dart';
import 'package:flutter/material.dart';

class SettingsOption extends StatelessWidget {
  const SettingsOption({
    Key? key,
    required this.title,
    this.icon,
    this.trailing,
    this.subtitle,
    this.onTap,
  }) : super(key: key);

  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final IconData? icon;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon == null
          ? null
          : Icon(
              icon,
              color: Theme.of(context).colorScheme.onBackground,
            ),
      title: KhmertracksTitle(title),
      subtitle: subtitle != null
          ? KhmertracksSubTitle(
              subtitle,
              maxLines: 2,
            )
          : null,
      onTap: onTap,
      trailing: trailing,
    );
  }
}
