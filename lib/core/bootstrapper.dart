import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:skuadchallengue/core/endpoints.dart';

import 'flavor.dart';

enum InitializationStatus {
  disposed,
  error,
  initialized,
  initializing,
  unsafeDevice,
}

abstract class Bootstrapper {
  factory Bootstrapper.fromFlavor(Flavor flavor) {
    Bootstrapper result;
    switch (flavor) {
      case Flavor.dev:
        result = _DevBootstrapper();
        break;
      case Flavor.prod:
        result = _ProdBootstrapper();
        break;
    }

    return result;
  }

  Stream<InitializationStatus> get initializationStream;

  Future<void> _initializeBlocs();
  Future<void> _initializeRepositories();
  Future<void> _initExtraServices();
  Future<void> bootstrap();
  void dispose();
}

class _DefaultBootstrapper implements Bootstrapper {
  _DefaultBootstrapper(Flavor flavor) : _flavor = flavor;

  final Flavor _flavor;
  InitializationStatus _initializationStatus =
      InitializationStatus.initializing;
  final StreamController<InitializationStatus> _initializationStreamController =
      StreamController<InitializationStatus>.broadcast();
  //view Models
  //repository
  //extra services
  late Endpoints _endpoints;

  @override
  Future<void> _initializeBlocs() async {}

  @override
  Future<void> _initializeRepositories() async {}

  Future<void> _loadEndPointsFromRootBundle() async {
    final configJson = await rootBundle.loadString(_flavor.configFile);
    _endpoints = Endpoints.fromJson(jsonDecode(configJson));
  }

  @override
  Future<void> _initExtraServices() async {
    await _loadEndPointsFromRootBundle();
  }

  @override
  Future<void> bootstrap() async {
    if (_initializationStatus != InitializationStatus.initialized) {
      try {
        log('Starting bootstrap process...');
        await _initExtraServices();
        await _initializeRepositories();
        await _initializeBlocs();
        _initializationStatus = InitializationStatus.initialized;
        log('Bootstrap process completed successfully.');
      } catch (e) {
        _initializationStatus = InitializationStatus.error;
        log('Error during bootstrap process: $e');
      }

      _initializationStreamController.add(_initializationStatus);
    }
  }

  @override
  Stream<InitializationStatus> get initializationStream =>
      _initializationStreamController.stream;

  @override
  void dispose() {}
}

class _DevBootstrapper extends _DefaultBootstrapper {
  _DevBootstrapper() : super(Flavor.dev);
}

class _ProdBootstrapper extends _DefaultBootstrapper {
  _ProdBootstrapper() : super(Flavor.dev);
}
