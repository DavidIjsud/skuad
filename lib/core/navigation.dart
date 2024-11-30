import 'dart:io';

import 'package:flutter/material.dart';

import 'custom_navigation_transation.dart';

abstract class NavigatorApp {
  static PageRoute<T> _getPageRoute<T>(
    WidgetBuilder widgetBuilder, {
    RouteSettings? routeSettings,
    bool maintainState = true,
    bool fullScreenDialog = false,
    OnWillPopCustom? onWillPop,
  }) {
    return Platform.isAndroid
        ? CustomMaterialPageRoute<T>(
            builder: widgetBuilder,
            settings: routeSettings,
            maintainState: maintainState,
            fullscreenDialog: fullScreenDialog,
            onWillPop: onWillPop,
          )
        : CustomCupertinoPageRoute<T>(
            builder: widgetBuilder,
            settings: routeSettings,
            maintainState: maintainState,
            fullscreenDialog: fullScreenDialog,
            onWillPop: onWillPop,
          );
  }

  static void pop<T>(BuildContext context, {T? result}) async {
    return Navigator.pop<T>(context, result);
  }

  static Future<T> push<T>(
    BuildContext context,
    Widget newRoute, {
    RouteSettings? routeSettings,
    bool maintainState = true,
    bool fullScreenDialog = false,
    OnWillPopCustom? onWillPop,
  }) async {
    return await Navigator.push(
      context,
      _getPageRoute(
        (context) => newRoute,
        routeSettings: routeSettings,
        maintainState: maintainState,
        fullScreenDialog: fullScreenDialog,
        onWillPop: onWillPop,
      ),
    );
  }

  static Future<T> pushReplacement<T>(
    BuildContext context,
    Widget newRoute, {
    RouteSettings? routeSettings,
  }) async {
    return await Navigator.pushReplacement(
      context,
      _getPageRoute((context) => newRoute, routeSettings: routeSettings),
    );
  }

  static Future<T?> pushNamed<T>(
    BuildContext context,
    String newRoute,
  ) async {
    return await Navigator.pushNamed<T>(
      context,
      newRoute,
    );
  }

  static Future<T?> pushNamedAndRemoveUntil<T>(
      BuildContext context, String newRoute, RoutePredicate predicate) async {
    return await Navigator.pushNamedAndRemoveUntil<T>(
      context,
      newRoute,
      predicate,
    );
  }

  static void popUntil(BuildContext context, RoutePredicate predicate) {
    return Navigator.popUntil(context, predicate);
  }

  static Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
      BuildContext context, String newRoute,
      {TO? result, Object? arguments}) async {
    return await Navigator.pushReplacementNamed(
      context,
      newRoute,
      result: result,
      arguments: arguments,
    );
  }

  static Future<void> pushRoute(
    BuildContext context,
    Widget newRoute, {
    OnWillPopCustom? onWillPopCustom,
  }) async {
    Navigator.push(
      context,
      _getPageRoute(
        (context) => newRoute,
        onWillPop: onWillPopCustom,
      ),
    );
  }

  static void popAndPushNamed<TO extends Object?>(
    BuildContext context,
    String newRoute, {
    TO? result,
    Object? arguments,
  }) {
    Navigator.popAndPushNamed(context, newRoute,
        result: result, arguments: arguments);
  }
}
