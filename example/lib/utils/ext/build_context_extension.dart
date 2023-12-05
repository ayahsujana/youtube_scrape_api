import 'package:skibidiwartube/utils/ext/text_style_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widget/loading.dart';
import '../resources/dimens.dart';

extension AppBarHelper on BuildContext {
  AppBar materialYouAppBar(
    String title, {
    List<Widget>? actions,
    Widget? leadingWidget,
  }) {
    return AppBar(
      leading: leadingWidget,
      title: Text(title),
      titleTextStyle: titleLarge?.copyWith(fontWeight: FontWeight.bold),
      actions: actions ?? [],
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      showMaterialSnackBar(
    String content, {
    SnackBarAction? action,
  }) {
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        content: Text(
          content,
          style: TextStyle(
            color: Theme.of(this).colorScheme.onPrimary,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(this).colorScheme.primary,
        action: action,
      ),
    );
  }
}

extension ContextExtensions on BuildContext {
  //Start Loading Dialog
  static late BuildContext ctx;

  Future<void> show() => showDialog(
        context: this,
        barrierDismissible: false,
        builder: (c) {
          ctx = c;

          return ScreenUtilInit(builder: (BuildContext context, Widget? child) {
            return WillPopScope(
              onWillPop: () async => false,
              child: Material(
                color: Colors.transparent,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      // color: Palette.white,
                      borderRadius: BorderRadius.circular(Dimens.cornerRadius),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: Dimens.space30),
                    padding: EdgeInsets.all(Dimens.space24),
                    child: const Wrap(children: [Loading()]),
                  ),
                ),
              ),
            );
          });
        },
      );

  void dismiss() {
    try {
      Navigator.pop(ctx);
    } catch (_) {}
  }
}
