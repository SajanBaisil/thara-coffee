import 'package:flutter/services.dart';
import 'package:thara_coffee/feature/login/domain/model/login_response.dart';
import 'package:thara_coffee/shared/domain/constants/global_variables.dart';
import 'package:thara_coffee/shared/local_storage/keys.dart';
import 'package:thara_coffee/shared/local_storage/local_storage_service.dart';

class GlobalSetters {
  static Future<void> storeTokenToLocal(String? token) async {
    await serviceLocator<LocalStorageService>()
        .saveToLocal(token.toString(), LocalStorageKeys.token);
  }

  static Future<void> saveLoginResponseToLocal(
    LoginResponse response,
  ) async {
    await serviceLocator<LocalStorageService>().saveToLocal(
      response.toJson(),
      LocalStorageKeys.loginResponse,
      encode: true,
    );
  }

  static void changeAppBarBrightness(Brightness brightness) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: brightness,
        statusBarIconBrightness: brightness,
      ),
    );
  }
}
