import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:thara_coffee/feature/login/screens/login_screen.dart';
import 'package:thara_coffee/main.dart';
import 'package:thara_coffee/shared/components/app_strings.dart';
import 'package:thara_coffee/shared/components/size_manager.dart';
import 'package:thara_coffee/shared/components/theme/color_manager.dart';
import 'package:thara_coffee/shared/components/theme/theme_getters.dart';
import 'package:thara_coffee/shared/domain/constants/global_variables.dart';
import 'package:thara_coffee/shared/domain/helpers/adaptive_action.dart';
import 'package:thara_coffee/shared/domain/helpers/snack_bar.dart';
import 'package:thara_coffee/shared/extensions/on_string.dart';
import 'package:thara_coffee/shared/local_storage/local_storage_service.dart';
import 'package:thara_coffee/shared/router/http%20utils/http_service.dart';
import 'package:thara_coffee/shared/router/http%20utils/model/http_fail_data.dart';
import 'package:thara_coffee/shared/router/http%20utils/model/http_response_model.dart';

enum RequestType { post, get, delete, put, patch }

enum HandleTypes { snackbar, dialogue }

enum UserTokenState {
  active,
  expired,
}

StreamController<UserTokenState> _controller =
    StreamController<UserTokenState>.broadcast();

Stream<UserTokenState> get tokenState async* {
  yield UserTokenState.active;
  yield* _controller.stream;
}

class HttpHelper {
  static Future<ResponseData> getDataFromServer(
    String url, {
    RequestType requestType = RequestType.post,
    Map<dynamic, dynamic>? data,
    bool encode = true,
    bool authenticationRequired = true,
    bool onlyGetSuccessData = true,
  }) async {
    try {
      if (printApiResponse) {
        log('url : $url');
        log('body : ${jsonEncode(data)}');
      }

      final call = HttpService();
      http.Response response;
      switch (requestType) {
        case RequestType.post:
          response = await call.post(
            url,
            authenticationRequired: authenticationRequired,
            data: data,
            encodeBody: encode,
          );
        case RequestType.get:
          response = await call.get(
            url,
            authenticationRequired: authenticationRequired,
            data: data,
          );
        case RequestType.put:
          response = await call.put(
            url,
            authenticationRequired: authenticationRequired,
            data: data,
            encodeBody: encode,
          );
        case RequestType.delete:
          response = await call.delete(
            url,
            authenticationRequired: authenticationRequired,
            data: data,
            encodeBody: encode,
          );
        case RequestType.patch:
          response = await call.patch(
            url,
            authenticationRequired: authenticationRequired,
            data: data,
            encodeBody: encode,
          );
        default:
          response = await call.post(
            url,
            authenticationRequired: authenticationRequired,
            data: data,
            encodeBody: encode,
          );
      }
      return convertToResponseData(response);
    } on SocketException {
      return ResponseData(
        responseCode: 102,
        message: AppStrings.sorryNetworkError,
        responseBody: '',
      );
    } catch (e) {
      return ResponseData(
        responseCode: 101,
        message: AppStrings.ourEndError,
        responseBody: '',
      );
    }
  }

  //get data from server for upload files
  static Future<ResponseData> getUploadedDataFromServer(
    String url, {
    List<String> filePaths = const [],
    Map<String, String>? data,
    bool encode = true,
    bool authenticationRequired = true,
    String fileFieldName = 'image[]',
    List<http.MultipartFile>? multiPartFiles,
  }) async {
    try {
      if (printApiResponse) {
        log('url : $url');
        log('body : ${jsonEncode(data)}');
      }

      final call = HttpService();
      final response = await call.uploadFile(
        url,
        authenticationRequired: authenticationRequired,
        fileFieldName: fileFieldName,
        data: data,
        multiPartFiles: multiPartFiles,
        filePaths: filePaths,
      );
      return convertToResponseData(response);
    } on SocketException {
      return ResponseData(
        responseCode: 102,
        message: AppStrings.sorryNetworkError,
        responseBody: '',
      );
    } catch (e) {
      return ResponseData(
        responseCode: 101,
        message: AppStrings.sorryNetworkError,
        responseBody: '',
      );
    }
  }

  static ResponseData convertToResponseData(http.Response response) {
    if (printApiResponse) {
      log('status_code : ${response.statusCode}');
      log('response_body : ${response.body}');
    }
    final decodedData = HttpService().convertJsonToMap(response.body);
    if (response.statusCode == 401) {
      // if (_controller.isClosed) {
      //   _controller = StreamController<UserTokenState>.broadcast();
      // }

      // _controller.add(UserTokenState.expired);
      _handleUnauthorized();
    }
    if (response.statusCode != 200 || response.statusCode != 201) {
      final data = HttpFailData.fromJson(decodedData);
      return ResponseData(
        responseCode: response.statusCode,
        message: data.message.notNullNorEmpty
            ? data.message ?? ''
            : getErrorMessage(decodedData),
        responseBody: decodedData,
        success: response.statusCode == 200 || response.statusCode == 201,
      );
    }
    return ResponseData(
      responseCode: response.statusCode,
      message: decodedData.containsKey('message')
          ? decodedData['message']
          : AppStrings.requestCompletedSuccessfully,
      responseBody: decodedData,
      success:
          //  decodedData["status"] ?? false
          response.statusCode == 200 || response.statusCode == 201,
    );
  }

  static String getErrorMessage(Map<String, dynamic> data) {
    final error = data['error']?.toString();
    final message = data['message']?.toString();
    final errorMessage = data['errorMessage']?.toString();
    final errors = data['errors']?.toString();

    if (error.notNullNorEmpty) {
      return error ?? '';
    } else if (message.notNullNorEmpty) {
      return message ?? '';
    } else if (errorMessage.notNullNorEmpty) {
      return errorMessage ?? '';
    } else if (errors.notNullNorEmpty) {
      return getErrors(data['errors']);
    } else {
      return AppStrings.ourEndError;
    }
  }

  static Future<void> handleMessage(
    String? message,
    BuildContext context, {
    bool local = true,
    bool useParentContext = false,
    VoidCallback? onTap,
    bool dismissible = true,
    bool restrict = false,
    String title = 'Error',
    String? buttonText,
    HandleTypes type = HandleTypes.dialogue,
    IconData? icon,
    Color? color,
    Color backgroundColor = Colors.black,
    bool isWarning = false,
    bool isInfinite = false,
    double bottomPadding = 50,
    SnackBarType snackBarType = SnackBarType.validation,
  }) async {
    var displayMessage = message ?? AppStrings.ourEndError;
    var displayTitle = title;
    if (!context.mounted) return;
    if ((message?.toLowerCase().contains('ssl') ?? false) ||
        (message?.toLowerCase().contains('curl') ?? false)) {
      displayMessage = AppStrings.slowInternetConnectionDescription;
      displayTitle = AppStrings.slowInternetConnection;
    }
    unawaited(HapticFeedback.mediumImpact());
    if (type == HandleTypes.snackbar) {
      showSnackBar(
        displayMessage,
        context,
        backgroundColor: backgroundColor,
        bottomPadding: bottomPadding,
        snackBarType: snackBarType,
        isWarning: isWarning,
        isInfinite: isInfinite,
        color: color,
        icon: icon,
      );
    } else {
      unawaited(
        showAdaptiveDialog<bool>(
          barrierDismissible: !useParentContext && dismissible,
          context: context,
          useRootNavigator: !local,
          builder: (ctx) => PopScope(
            canPop: !useParentContext && dismissible,
            child: AlertDialog.adaptive(
              title: Text(
                displayTitle,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.secondary,
                ),
                textAlign: TextAlign.center,
              ),
              content: Text(
                displayMessage,
              ),
              actions: [
                if (restrict)
                  const SizedBox()
                else
                  AdaptiveAction(
                    onPressed: () {
                      if (useParentContext) {
                        Navigator.pop(context);
                      }
                      Navigator.pop(ctx);
                      onTap?.call();
                    },
                    child: Text(
                      buttonText ?? ButtonString.ok,
                      style: TextStyle(
                        fontSize: KFontSize.f14,
                        color: Colors.black,
                        fontWeight: Platform.isAndroid
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    }
  }

  static Future<bool?> showCommonDialogue(
    String message,
    BuildContext context, {
    bool local = true,
    bool useParentContext = false,
    VoidCallback? onTapOk,
    VoidCallback? onTapCancel,
    bool dismissible = true,
    String title = '',
    String? okButtonText,
    String? cancelButtonText,
    bool showOkButtonRightSide = true,
    TextStyle? okButtonTextStyle,
    bool cancelButton = true,
    TextStyle? cancelButtonTextStyle,
  }) async {
    return showAdaptiveDialog<bool>(
      barrierDismissible: !useParentContext && dismissible,
      context: context,
      useRootNavigator: !local,
      builder: (ctx) => PopScope(
        canPop: !useParentContext && dismissible,
        child: AlertDialog.adaptive(
          title: Text(
            title,
            style: textTheme(context).titleMedium,
          ),
          content: Text(
            message.trim(),
          ),
          actions: [
            if (!showOkButtonRightSide)
              AdaptiveAction(
                onPressed: () {
                  if (useParentContext) {
                    Navigator.pop(context, true);
                  }
                  Navigator.pop(ctx, true);
                  onTapOk?.call();
                },
                child: Text(
                  okButtonText ?? ButtonString.ok,
                  style: okButtonTextStyle ??
                      textTheme(context).bodyLarge?.copyWith(
                            fontSize: KFontSize.f14,
                            fontWeight: Platform.isAndroid
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                ),
              ),
            if (cancelButton)
              AdaptiveAction(
                onPressed: () {
                  if (useParentContext) {
                    Navigator.pop(context, false);
                  }
                  Navigator.pop(ctx, false);
                  onTapCancel?.call();
                },
                child: Text(
                  cancelButtonText ?? ButtonString.cancel,
                  style: cancelButtonTextStyle ??
                      TextStyle(
                        fontSize: KFontSize.f14,
                        color: Colors.black,
                        fontWeight: Platform.isAndroid
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                ),
              ),
            if (showOkButtonRightSide)
              AdaptiveAction(
                onPressed: () {
                  if (useParentContext) {
                    Navigator.pop(context, true);
                  }
                  Navigator.pop(ctx, true);
                  onTapOk?.call();
                },
                child: Text(
                  okButtonText ?? ButtonString.ok,
                  style: okButtonTextStyle ??
                      textTheme(context).bodyLarge?.copyWith(
                            fontSize: KFontSize.f14,
                            fontWeight: Platform.isAndroid
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  static void _handleUnauthorized() async {
    try {
      // Clear local storage
      serviceLocator<LocalStorageService>().clearLocal();
      // Clear any other storage if needed
      // await secureStorage.deleteAll();

      // Navigate to login screen
      navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (route) => false,
      );
    } catch (e) {
      log('Error handling unauthorized: $e');
    }
  }
}

String getErrors(dynamic decodedMap) {
  String errorMessage = '';
  try {
    if (decodedMap is Map<String, dynamic>) {
      for (var errorList in decodedMap.values) {
        for (var error in errorList) {
          errorMessage += error + '\n';
        }
      }
      return errorMessage;
    } else {
      errorMessage =
          decodedMap?.toString().replaceFirst('{', '').replaceFirst('}', '') ??
              "";
    }
  } catch (e) {
    errorMessage = AppStrings.ourEndError;
  }
  return errorMessage;
}
