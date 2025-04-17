import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thara_coffee/shared/domain/constants/global_variables.dart';
import 'package:thara_coffee/shared/local_storage/keys.dart';

class LocalStorageService {
  LocalStorageService() {
    _clearStorageDataOnFirstRun();
  }
  Future<void> _clearStorageDataOnFirstRun() async {
    final shared = await SharedPreferences.getInstance();
    if (!shared.containsKey(LocalStorageKeys.firstRun)) {
      await clearLocal();
    }
  }

  Future<String?> getFromLocal(String key) async {
    final storage = serviceLocator<FlutterSecureStorage>();
    final data = await storage.read(
      key: key,
      iOptions: getIOSOptions(),
      aOptions: getAndroidOptions(),
    );
    return data;
  }

  // Future<void> clearAll() async {
  //   final storage = serviceLocator<FlutterSecureStorage>();
  //   final allValues = await storage.readAll(
  //     iOptions: getIOSOptions(),
  //     aOptions: getAndroidOptions(),
  //   );
  //   final keys = allValues.keys.toList();
  //   for (var i = 0; i < keys.length; i++) {
  //     log(keys[i]);
  //     await storage.delete(
  //       key: keys[i],
  //       iOptions: getIOSOptions(),
  //       aOptions: getAndroidOptions(),
  //     );
  //   }
  // }

  Future<void> removeFromLocal(String key) async {
    final storage = serviceLocator<FlutterSecureStorage>();
    await storage.delete(
      key: key,
      iOptions: getIOSOptions(),
      aOptions: getAndroidOptions(),
    );
  }

  Future<void> saveToLocal(
    dynamic jsonData,
    String key, {
    bool encode = false,
  }) async {
    final storage = serviceLocator<FlutterSecureStorage>();
    await storage.write(
      key: key,
      value: encode ? jsonEncode(jsonData) : jsonData,
      iOptions: getIOSOptions(),
      aOptions: getAndroidOptions(),
    );
  }

//will keep the gateway tokens in local storage
//to unregister the device from the gateway on reinstalling the app
  Future<void> clearLocal() async {
    final storage = serviceLocator<LocalStorageService>();
    final secureStorage = serviceLocator<FlutterSecureStorage>();
    final shared = await SharedPreferences.getInstance();
    storage.removeFromLocal(LocalStorageKeys.loginResponse);
    await Future.wait([
      secureStorage.deleteAll(
        iOptions: getIOSOptions(),
        aOptions: getAndroidOptions(),
      ),
      shared.clear(),
    ]);
  }

  Future<void> setFirstTimeRun() async {
    final shared = await SharedPreferences.getInstance();
    await shared.setBool(LocalStorageKeys.firstRun, true);
  }

  /// register as chat tour experienced

//local Storage security options
  IOSOptions getIOSOptions() => const IOSOptions(
        accountName: 'iocod',
        accessibility: KeychainAccessibility.first_unlock,
      );

  AndroidOptions getAndroidOptions() => const AndroidOptions(
        keyCipherAlgorithm:
            KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
      );
}
