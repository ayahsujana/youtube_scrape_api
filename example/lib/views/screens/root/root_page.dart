import 'package:skibidiwartube/views/screens/splash/splash.dart';
import 'package:skibidiwartube/widget/annotate.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class RootPage extends StatefulWidget {
  const RootPage({
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return KhmertracksAnnotatedRegionWidget(
        child: ScreenTypeLayout.builder(
      mobile: (context) => const Splash(),
    ));
  }
}
