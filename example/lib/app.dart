import 'package:skibidiwartube/views/screens/root/root_page.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'utils/constants/constants.dart';
import 'utils/themes/flutter_theme.dart';
import 'widget/annotate.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
    required this.settings,
  }) : super(key: key);
  final Box<dynamic> settings;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return KhmertracksAnnotatedRegionWidget(
        child: ValueListenableBuilder<Box>(
      valueListenable: widget.settings.listenable(keys: [
        appColorKey,
        dynamicThemeKey,
        themeModeKey,
        appLanguageKey,
        appFontChangerKey
      ]),
      builder: (context, value, _) {
        final bool isDynamic = value.get(
          dynamicThemeKey,
          defaultValue: false,
        );
        final ThemeMode themeMode = ThemeMode.values[value.get(
          themeModeKey,
          defaultValue: 0,
        )];
        final int color = value.get(
          appColorKey,
          defaultValue: defaultColor,
        );
        final Color primaryColor = Color(color);
        final Locale locale =
            Locale(value.get(appLanguageKey, defaultValue: 'en'));
        final String fontPreference =
            value.get(appFontChangerKey, defaultValue: defaultFontName);
        return DynamicColorBuilder(
          builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
            ColorScheme lightColorScheme;
            ColorScheme darkColorScheme;
            if (lightDynamic != null && darkDynamic != null && isDynamic) {
              lightColorScheme = lightDynamic.harmonized();
              darkColorScheme = darkDynamic.harmonized();
            } else {
              lightColorScheme = ColorScheme.fromSeed(seedColor: primaryColor);
              darkColorScheme = ColorScheme.fromSeed(
                  seedColor: primaryColor, brightness: Brightness.dark);
            }
            final lightTextTheme = GoogleFonts.getTextTheme(
                fontPreference, ThemeData.light().textTheme);
            final darkTextTheme = GoogleFonts.getTextTheme(
                fontPreference, ThemeData.dark().textTheme);
            return GetMaterialApp(
              locale: locale,
              debugShowCheckedModeBanner: false,
              themeMode: themeMode,
              theme: ThemeData.from(colorScheme: lightColorScheme).copyWith(
                textTheme: lightTextTheme,
                colorScheme: lightColorScheme,
                dialogTheme: dialogTheme,
                timePickerTheme: timePickerTheme,
                useMaterial3: true,
                appBarTheme: appBarThemeLight(lightColorScheme),
                scaffoldBackgroundColor: lightColorScheme.background,
                dialogBackgroundColor: lightColorScheme.background,
                navigationBarTheme: navigationBarThemeData(
                  lightColorScheme,
                  lightTextTheme,
                ),
                navigationDrawerTheme: navigationDrawerThemeData(
                  lightColorScheme,
                  lightTextTheme,
                ),
                drawerTheme: drawerThemeData(
                  lightColorScheme,
                  lightTextTheme,
                ),
                applyElevationOverlayColor: true,
                inputDecorationTheme: inputDecorationTheme,
                elevatedButtonTheme: elevatedButtonTheme(
                  context,
                  lightColorScheme,
                ),
                dividerTheme: DividerThemeData(
                  color: ThemeData.light().dividerColor,
                ),
              ),
              darkTheme: ThemeData.from(
                colorScheme: darkColorScheme,
              ).copyWith(
                textTheme: darkTextTheme,
                colorScheme: darkColorScheme,
                dialogTheme: dialogTheme,
                timePickerTheme: timePickerTheme,
                appBarTheme: appBarThemeDark(darkColorScheme),
                scaffoldBackgroundColor: darkColorScheme.background,
                dialogBackgroundColor: darkColorScheme.background,
                navigationBarTheme: navigationBarThemeData(
                  darkColorScheme,
                  darkTextTheme,
                ),
                navigationDrawerTheme: navigationDrawerThemeData(
                  darkColorScheme,
                  darkTextTheme,
                ),
                drawerTheme: drawerThemeData(
                  darkColorScheme,
                  darkTextTheme,
                ),
                applyElevationOverlayColor: true,
                inputDecorationTheme: inputDecorationTheme,
                elevatedButtonTheme: elevatedButtonTheme(
                  context,
                  darkColorScheme,
                ),
                dividerTheme: DividerThemeData(
                  color: ThemeData.dark().dividerColor,
                ),
              ),
              home: const RootPage(),
            );
          },
        );
      },
    ));
  }
}
