import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hao_chatgpt/src/network/entity/dio_error_entity.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';

extension StringExt on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotBlank => this != null && this!.trim().isNotEmpty;
}

extension DioErrorExt on DioError {
  DioErrorEntity get toEioErrorEntity {
    Map<String, dynamic> error = {};
    switch (type) {
      case DioErrorType.connectTimeout:
        error = {'error': this.error?.toString() ?? 'Connect timeout'};
        break;
      case DioErrorType.sendTimeout:
        error = {'error': this.error?.toString() ?? 'Send timeout'};
        break;
      case DioErrorType.receiveTimeout:
        error = {'error': this.error?.toString() ?? 'Receive timeout'};
        break;
      case DioErrorType.cancel:
        error = {'error': this.error?.toString() ?? 'Canceled request'};
        break;
      case DioErrorType.other:
        error = {'error': this.error?.toString() ?? 'Some other Error'};
        break;
      case DioErrorType.response:
        error = {
          'error': this.error?.toString() ??
              'When the server response, but with a incorrect status, such as 404, 503...'
        };
        Map<String, dynamic>? dataError = response?.data['error'];
        if (dataError != null) {
          error.addAll(dataError);
        }
        break;
    }
    return DioErrorEntity.fromJson(error);
  }
}

extension ExceptionExt on Exception {
  DioErrorEntity get toEioErrorEntity {
    var msg = toString();
    if (msg.startsWith('Exception: ')) {
      msg = msg.replaceFirst('Exception: ', '');
    }
    Map<String, dynamic> error = {'message': msg};
    return DioErrorEntity.fromJson(error);
  }
}

extension DoubleExt on double {
  String toStringAsFixedNoRound(int fractionDigits, {bool isTight = false}) {
    String str = toString();
    String parsedStr = "0";
    if (str.length <= 2 + fractionDigits) {
      parsedStr = toStringAsFixed(fractionDigits);
    } else {
      parsedStr =
          double.parse(str.substring(0, 4)).toStringAsFixed(fractionDigits);
    }
    if (fractionDigits > 1 && parsedStr.endsWith('0')) {
      return parsedStr.substring(0, parsedStr.length - 1);
    } else {
      return parsedStr;
    }
  }
}

class MyCupertinoTextSelectionControls extends CupertinoTextSelectionControls {
  @override
  bool canSelectAll(TextSelectionDelegate delegate) {
    // to show "Select all" option
    return delegate.selectAllEnabled &&
        delegate.textEditingValue.text.isNotEmpty;
  }
}

final TextSelectionControls myCupertinoTextSelectionControls =
    MyCupertinoTextSelectionControls();

String getMaskedApiKey(String keyValue) {
  return keyValue.length > 11
      ? '${keyValue.substring(0, 7)}******${keyValue.substring(keyValue.length - 4, keyValue.length)}'
      : keyValue;
}

Future<void> openWebView(
    {required BuildContext context,
    required String url,
    bool isExternal = false,
    String? title}) async {
  if (!isExternal && (Platform.isAndroid || Platform.isIOS)) {
    context.push('/webview?title=${title ?? ''}&url=$url');
  } else {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      debugPrint("can not open: $url");
    }
  }
}

void setSystemNavigationBarColor(ThemeMode themeMode) {
  if (Platform.isAndroid) {
    Brightness brightness = WidgetsBinding.instance.window.platformBrightness;
    if (themeMode == ThemeMode.dark) {
      brightness = Brightness.dark;
    } else if (themeMode == ThemeMode.light) {
      brightness = Brightness.light;
    }
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor:
          brightness == Brightness.dark ? Colors.black : Colors.white,
    ));
  }
}
