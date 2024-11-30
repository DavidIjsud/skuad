enum Flavor { prod, dev }

class FlavorConfig {
  factory FlavorConfig({required Flavor flavor}) {
    _instance ??= FlavorConfig._internal(flavor: flavor);
    return _instance!;
  }

  FlavorConfig._internal({required this.flavor});
  final Flavor flavor;
  static FlavorConfig? _instance;

  static Flavor get currentFlavor => _instance!.flavor;
}

extension FlavorExtension on Flavor {
  static const deConfigFile = 'assets/config/dev_config.json';
  static const prodConfigFile = 'assets/config/prod_config.json';

  String get configFile {
    switch (this) {
      case Flavor.dev:
        return deConfigFile;
      case Flavor.prod:
        return prodConfigFile;
    }
  }
}
