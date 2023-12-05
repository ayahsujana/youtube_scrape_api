import 'package:skibidiwartube/data/enum/box_types.dart';
import 'package:skibidiwartube/utils/constants/constants.dart';
import 'package:skibidiwartube/utils/ext/text_style_extension.dart';
import 'package:skibidiwartube/utils/locator/setup_locator.dart';
import 'package:skibidiwartube/utils/text/title.dart';
import 'package:skibidiwartube/utils/themes/theme_mode.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class ChooseThemeModeWidget extends StatefulWidget {
  const ChooseThemeModeWidget({
    Key? key,
    required this.currentTheme,
  }) : super(key: key);
  final ThemeMode currentTheme;

  @override
  ChooseThemeModeWidgetState createState() => ChooseThemeModeWidgetState();
}

class ChooseThemeModeWidgetState extends State<ChooseThemeModeWidget> {
  late ThemeMode currentIndex = widget.currentTheme;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListTile(
            title: Text(
              'Choose theme',
              style: context.titleLarge,
            ),
          ),
          ...ThemeMode.values
              .map(
                (e) => RadioListTile(
                  value: e,
                  activeColor: Theme.of(context).colorScheme.primary,
                  groupValue: currentIndex,
                  onChanged: (ThemeMode? value) {
                    currentIndex = value!;
                    setState(() {});
                  },
                  title: KhmertracksTitle(
                    e.themeName(context),
                  ),
                ),
              )
              .toList(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancel',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0, bottom: 16),
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () => locator
                      .get<Box<dynamic>>(instanceName: BoxType.settings.name)
                      .put(themeModeKey, currentIndex.index)
                      .then((value) => Navigator.pop(context)),
                  child: const Text(
                    'Ok',
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
