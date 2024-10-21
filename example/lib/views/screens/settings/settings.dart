import 'package:skibidiwartube/views/screens/privacy/privacy.dart';
import 'package:skibidiwartube/views/screens/privacy/terms.dart';
import 'package:skibidiwartube/widget/annotate.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:skibidiwartube/data/enum/box_types.dart';
import 'package:skibidiwartube/utils/constants/constants.dart';
import 'package:skibidiwartube/utils/ext/build_context_extension.dart';
import 'package:skibidiwartube/utils/locator/setup_locator.dart';
import 'package:skibidiwartube/utils/text/title.dart';
import 'package:skibidiwartube/utils/themes/theme_mode.dart';
import 'package:skibidiwartube/widget/choose_theme_mode.dart';
import 'package:skibidiwartube/widget/font_changer.dart';
import 'package:skibidiwartube/widget/setting_group_card.dart';
import 'package:skibidiwartube/widget/setting_option.dart';
import 'package:skibidiwartube/widget/version_app.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utils/constants/app_info.dart';

class Settings extends StatelessWidget {
  Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = locator.get<Box<dynamic>>(
      instanceName: BoxType.settings.name,
    );
    final currentTheme = ThemeMode.values[locator
        .get<Box<dynamic>>(instanceName: BoxType.settings.name)
        .get(themeModeKey, defaultValue: 0)];
    String? appUrl = settings.get(playStoreUrl, defaultValue: urlPS);
    return KhmertracksAnnotatedRegionWidget(
      child: ScreenTypeLayout.builder(
        mobile: (context) => Scaffold(
          appBar: context.materialYouAppBar('Settings',
              leadingWidget: IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back_rounded))),
          body: ListView(
            shrinkWrap: true,
            children: [
              SettingsGroup(title: 'Themes & Fonts', options: [
                SettingsOption(
                  icon: FluentIcons.dark_theme_24_regular,
                  title: 'Choose theme',
                  subtitle: currentTheme.themeName(context),
                  onTap: () {
                    showModalBottomSheet(
                      useRootNavigator: true,
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width >= 700
                              ? 700
                              : double.infinity),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16))),
                      context: context,
                      builder: (_) => ChooseThemeModeWidget(
                        currentTheme: currentTheme,
                      ),
                    );
                  },
                ),
                Divider(color: Colors.grey.withOpacity(0.2)),
                AppFontChanger(
                  settings: settings,
                ),
              ]),
              Visibility(
                visible: appUrl != null ? true : false,
                child: Column(
                  children: [
                    SettingsGroup(
                      title: 'Rate & Share',
                      options: [
                        SettingsOption(
                          icon: FluentIcons.star_24_regular,
                          title: 'Rate the app',
                          subtitle:
                              'Love this app? Give us you good review and 5 star',
                          onTap: () {},
                        ),
                        Divider(color: Colors.grey.withOpacity(0.2)),
                        SettingsOption(
                            icon: FluentIcons.share_24_regular,
                            title: 'Share',
                            subtitle:
                                'Share the app with your friends and family',
                            onTap: () => Share.share(
                                  '$appName • Download now on play store free without ads $appUrl$packageName',
                                  subject: appName,
                                ))
                      ],
                    ),
                    SettingsGroup(
                      title: 'About Notice',
                      options: [
                        SettingsOption(
                          icon: MdiIcons.security,
                          title: 'Privacy Policy',
                          onTap: () => Get.to(PrivacyPolicy()),
                        ),
                        Divider(color: Colors.grey.withOpacity(0.2)),
                        SettingsOption(
                          icon: FluentIcons.accessibility_24_regular,
                          title: 'Terms of Use',
                          onTap: () => Get.to(TermsOfUse()),
                        ),
                      ],
                    ),
                    SettingsGroup(title: 'Others', options: [
                      const VersionWidget(),
                      Divider(color: Colors.grey.withOpacity(0.2)),
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: KhmertracksTitle(appName),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
