import 'core/app_launcher.dart';
import 'core/flavor.dart';

void main() {
  FlavorConfig(flavor: Flavor.dev);
  AppLauncher.launchApp(flavor: Flavor.dev);
}
