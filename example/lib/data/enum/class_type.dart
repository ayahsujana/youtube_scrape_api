import 'package:flutter/material.dart';

enum ClassType {
  classType;

  static Widget classInHome(int type) {
    switch (type) {
      case 0:
        return SizedBox();
      case 1:
        return SizedBox();
      case 2:
        return SizedBox();
      default:
        return SizedBox();
    }
  }
}
