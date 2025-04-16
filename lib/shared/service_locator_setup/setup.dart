import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:thara_coffee/feature/cart/domain/repository/payment_repository.dart';
import 'package:thara_coffee/feature/cart/domain/service/payment_service.dart';
import 'package:thara_coffee/feature/home/domain/repository/home_repo.dart';
import 'package:thara_coffee/feature/home/domain/service/home_service.dart';
import 'package:thara_coffee/feature/login/domain/repository/login_repository.dart';
import 'package:thara_coffee/feature/login/domain/service/login_service.dart';
import 'package:thara_coffee/feature/orders/domain/repository/orders_repository.dart';
import 'package:thara_coffee/feature/orders/domain/service/orders_service.dart';
import 'package:thara_coffee/shared/domain/constants/global_variables.dart';
import 'package:thara_coffee/shared/local_storage/local_storage_service.dart';
import 'package:thara_coffee/shared/router/responsive_helper.dart';

Future<void> setUpServiceLocator() async {
  serviceLocator.allowReassignment = true;
  serviceLocator
    ..registerSingleton(LocalStorageService())
    ..registerSingleton(ResponsiveHelper())
    ..registerSingleton(const FlutterSecureStorage())
    ..registerLazySingleton<LoginRepository>(LoginService.new)
    ..registerLazySingleton<PaymentRepository>(PaymentService.new)
    ..registerLazySingleton<OrdersRepository>(OrdersService.new)
    ..registerLazySingleton<HomeRepository>(HomeService.new);
}
