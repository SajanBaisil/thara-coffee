import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:thara_coffee/shared/domain/constants/global_variables.dart';
import 'package:thara_coffee/shared/extensions/on_string.dart';
import 'package:thara_coffee/shared/local_storage/keys.dart';
import 'package:thara_coffee/shared/local_storage/local_storage_service.dart';

class HttpService {
  factory HttpService() {
    return _instance;
  }
  HttpService._internal();
  static final HttpService _instance = HttpService._internal();

  void logout() {
    _authToken = null;
  }

  String? _authToken;
  Future<Map<String, String>> getRequestHeaders({
    bool authenticationRequired = true,
  }) async {
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (authenticationRequired) {
      if (_authToken.isNullOrEmpty) {
        await setAuthToken();
      }
      header['Authorization'] = 'Bearer $_authToken';
    }
    if (printApiResponse) {
      log('header : $header');
    }
    return header;
  }

  Future<void> setAuthToken([String? tempToken]) async {
    final token = tempToken ??
        await serviceLocator<LocalStorageService>()
            .getFromLocal(LocalStorageKeys.token);

    _authToken = token;
    // assert(_authToken == null);
  }

  Future<http.Response> get(
    String url, {
    bool authenticationRequired = true,
    Map<dynamic, dynamic>? data,
  }) async {
    try {
      final opUrl = Uri.parse(url).replace(
        queryParameters: data
            ?.map((key, value) => MapEntry(key.toString(), value.toString())),
      );
      return http.get(
        opUrl,
        headers: await getRequestHeaders(
          authenticationRequired: authenticationRequired,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> post(
    String url, {
    Map<dynamic, dynamic>? data,
    bool authenticationRequired = true,
    bool encodeBody = true,
  }) async {
    try {
      return http.post(
        Uri.parse(url),
        headers: await getRequestHeaders(
          authenticationRequired: authenticationRequired,
        ),
        body: encodeBody ? jsonEncode(data) : data,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> put(
    String url, {
    Map<dynamic, dynamic>? data,
    bool authenticationRequired = true,
    bool encodeBody = true,
  }) async {
    try {
      return http.put(
        Uri.parse(url),
        headers: await getRequestHeaders(
          authenticationRequired: authenticationRequired,
        ),
        body: encodeBody ? jsonEncode(data) : data,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> delete(
    String url, {
    bool authenticationRequired = true,
    Map<dynamic, dynamic>? data,
    bool encodeBody = true,
  }) async {
    try {
      return http.delete(
        Uri.parse(url),
        headers: await getRequestHeaders(
          authenticationRequired: authenticationRequired,
        ),
        body: encodeBody ? jsonEncode(data) : data,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> patch(
    String url, {
    Map<dynamic, dynamic>? data,
    bool authenticationRequired = true,
    bool encodeBody = true,
  }) async {
    try {
      return http.patch(
        Uri.parse(url),
        headers: await getRequestHeaders(
          authenticationRequired: authenticationRequired,
        ),
        body: encodeBody ? jsonEncode(data) : data,
      );
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> convertJsonToMap(String response) {
    return json.decode(response);
  }

  Future<http.Response> uploadFile(
    String url, {
    required Map<String, String>? data,
    required List<String> filePaths,
    bool authenticationRequired = true,
    String fileFieldName = 'image[]',
    List<http.MultipartFile>? multiPartFiles,
  }) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );
      request.headers.addAll(
        await getRequestHeaders(
          authenticationRequired: authenticationRequired,
        ),
      );

      if (multiPartFiles != null) {
        request.files.addAll(multiPartFiles);
      } else {
        for (var i = 0; i < filePaths.length; i++) {
          final file = await http.MultipartFile.fromPath(
            fileFieldName,
            filePaths[i],
          );
          request.files.add(file);
        }
      }
      request.fields.addAll(data ?? {});

      final response = await request.send();
      return http.Response.fromStream(response);
    } catch (e) {
      rethrow;
    }
  }
}
