import 'package:skibidiwartube/utils/constants/privacy.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Policy",
            style: GoogleFonts.cousine(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 15.0, left: 13, right: 13, bottom: 50),
          child: Text(
            newPrivacy,
            style: GoogleFonts.cousine(fontSize: 12),
          ),
        ),
      ),
    );
  }
}
