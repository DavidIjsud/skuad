import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:skuadchallengue/core/endpoints.dart';
import 'package:skuadchallengue/modules/home/data/repositories/home_repository.dart';
import 'package:skuadchallengue/modules/home/data/repositories/home_repository.impl.dart';
import 'package:skuadchallengue/modules/home/domain/use_cases/get_articles_use_case.impl.dart';
import 'package:skuadchallengue/modules/home/presentation/bloc/home_bloc.dart';
import 'package:skuadchallengue/services/network/network_client.dart';
import 'package:skuadchallengue/services/network/network_client.impl.dart';
import 'package:skuadchallengue/services/storage/secure_storage.dart';
import 'package:skuadchallengue/services/storage/secure_storage.impl.dart';

import '../modules/home/domain/use_cases/get_articles.usecase.dart';
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
  HomeBloc get homeBloc;

  Future<void> _initializeBlocs();
  Future<void> _initializeRepositories();
  Future<void> _initExtraServices();
  Future<void> _initializeUsesCases();
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
  //blocs
  late HomeBloc _homeBloc;
  //repository
  late HomeRepository _homeRepository;
  //use cases
  late GetArticlesUseCase _getArticlesUseCase;
  //extra services
  late Endpoints _endpoints;
  late NetworkClient _networkClient;
  late SecureStorage _secureStorage;

  @override
  Future<void> _initializeBlocs() async {
    _homeBloc = HomeBloc(getArticlesUseCase: _getArticlesUseCase);
  }

  @override
  Future<void> _initializeRepositories() async {
    _homeRepository = HomeRepositoryImpl(
      networkClient: _networkClient,
      endpoints: _endpoints,
    );
  }

  Future<void> _loadEndPointsFromRootBundle() async {
    final configJson = await rootBundle.loadString(_flavor.configFile);
    _endpoints = Endpoints.fromJson(jsonDecode(configJson));
  }

  @override
  Future<void> _initExtraServices() async {
    await _loadEndPointsFromRootBundle();
    _networkClient = NetworkClientImpl();
    _secureStorage = SecureStorageImpl();
  }

  @override
  Future<void> _initializeUsesCases() async {
    _getArticlesUseCase = GetArticlesUseCaseImpl(
        homeRepository: _homeRepository, secureStorage: _secureStorage);
  }

  @override
  Future<void> bootstrap() async {
    if (_initializationStatus != InitializationStatus.initialized) {
      try {
        log('Starting bootstrap process...');
        await _initExtraServices();
        await _initializeRepositories();
        await _initializeUsesCases();
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
  HomeBloc get homeBloc => _homeBloc;

  @override
  void dispose() {}
}

class _DevBootstrapper extends _DefaultBootstrapper {
  _DevBootstrapper() : super(Flavor.dev);
}

class _ProdBootstrapper extends _DefaultBootstrapper {
  _ProdBootstrapper() : super(Flavor.dev);
}
