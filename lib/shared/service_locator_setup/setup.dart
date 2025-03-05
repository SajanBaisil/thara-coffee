import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:thara_coffee/shared/domain/constants/global_variables.dart';
import 'package:thara_coffee/shared/local_storage/local_storage_service.dart';
import 'package:thara_coffee/shared/router/responsive_helper.dart';

Future<void> setUpServiceLocator() async {
  serviceLocator.allowReassignment = true;
  serviceLocator
    ..registerSingleton(LocalStorageService())
    ..registerSingleton(ResponsiveHelper())
    ..registerSingleton(const FlutterSecureStorage());
}
