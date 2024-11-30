import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef OnWillPopCustom = bool Function();

class CustomMaterialPageRoute<T> extends MaterialPageRoute<T> {
  @override
  bool get hasScopedWillPopCallback {
    if (onWillPop != null) {
      onWillPop!();
    }
    return true;
  }

  final OnWillPopCustom? onWillPop;

  CustomMaterialPageRoute({
    required super.builder,
    super.settings,
    super.maintainState,
    super.fullscreenDialog,
    this.onWillPop,
  });
}

class CustomCupertinoPageRoute<T> extends CupertinoPageRoute<T> {
  @override
  bool get hasScopedWillPopCallback {
    if (onWillPop != null) {
      onWillPop!();
    }
    return true;
  }

  final OnWillPopCustom? onWillPop;

  CustomCupertinoPageRoute({
    required super.builder,
    super.settings,
    super.maintainState,
    super.fullscreenDialog,
    this.onWillPop,
  });
}
