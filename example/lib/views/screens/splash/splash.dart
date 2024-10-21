import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:skibidiwartube/utils/constants/constants.dart';
import 'package:skibidiwartube/views/screens/root/root_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool isReady = true;

  Future checkNetwork() async {
    try {
      final res = await InternetAddress.lookup('google.com');
      if (res.isNotEmpty && res[0].rawAddress.isNotEmpty) {
        setState(() {
          isReady = true;
        });
        await Future.delayed(const Duration(seconds: 3), () {
          Get.offAll(const RootBottomNav());
        });
      }
    } on SocketException catch (_) {
      setState(() {
        isReady = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkNetwork();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isReady
          ? SafeArea(
              child: Stack(
                fit: StackFit.loose,
                alignment: Alignment.center,
                children: <Widget>[
                  Center(
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage("assets/icons/logo.png"))),
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    child: Column(
                      children: [
                        CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Color(defaultColor)),
                          backgroundColor: Colors.white,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        const Text(
                          "Please wait....",
                          style: TextStyle(fontSize: 14, letterSpacing: 2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child: Text('ERROR: Please check your connection!!'),
            ),
    );
  }

  showExitDialog(String newPackage) async {
    final shouldPop = await showDialog(
      barrierDismissible: false,
      context: context,
      barrierColor: Colors.black26,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            "I'm so sorry",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          content: SizedBox(
            height: 75,
            child: Center(
              child: Text(
                "This app isn't verified and not support again, please click INSTALL to get our new app.",
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
              child: Text("CANCEL",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
              child: Text("INSTALL",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
    return shouldPop;
  }
}
