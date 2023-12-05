import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'setting_option.dart';

class VersionWidget extends StatefulWidget {
  const VersionWidget({Key? key}) : super(key: key);

  @override
  State<VersionWidget> createState() => _VersionWidgetState();
}

class _VersionWidgetState extends State<VersionWidget> {
  PackageInfo? packageInfo;

  @override
  void initState() {
    super.initState();
    fetchDeviceInfo();
  }

  Future<void> fetchDeviceInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (packageInfo == null) {
      return SettingsOption(
        icon: MdiIcons.numeric0Box,
        title: 'Version app',
        subtitle: 'v1.0.0',
      );
    }
    final version = packageInfo?.version ?? '';
    return SettingsOption(
      icon: Icons.info_outline,
      title: 'Version app',
      subtitle: 'v$version',
    );
  }
}
