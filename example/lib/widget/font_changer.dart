import 'package:skibidiwartube/utils/constants/constants.dart';
import 'package:skibidiwartube/utils/text/subtitle.dart';
import 'package:skibidiwartube/utils/text/title.dart';
import 'package:skibidiwartube/widget/font_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AppFontChanger extends StatelessWidget {
  const AppFontChanger({super.key, required this.settings});
  final Box<dynamic> settings;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: settings.listenable(
          keys: [
            appFontChangerKey,
          ],
        ),
        builder: (context, value, child) {
          return ListTile(
            leading: Icon(MdiIcons.formatFont),
            title: const KhmertracksTitle('Font style'),
            subtitle: const KhmertracksSubTitle('Change the font style'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute<void>(
                  fullscreenDialog: true,
                  builder: (BuildContext context) {
                    return FontPickerPage(
                      currentFont: settings.get(
                        appFontChangerKey,
                        defaultValue: defaultFontName,
                      ),
                    );
                  }));
            },
          );
        });
  }
}
