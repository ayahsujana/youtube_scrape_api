import 'package:flutter/material.dart';

extension ThemeModeName on ThemeMode {
  String themeName(BuildContext context) {
    switch (this) {
      case ThemeMode.system:
        return 'System default';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
    }
  }
}