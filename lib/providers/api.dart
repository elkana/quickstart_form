import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart' as dio_lib;
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/commons.dart';

class Api extends GetConnect {
  static Api instance = Get.find();
  static const timeoutSeconds = 10;

  static var apiKey = 'Token ${dotenv.env['TOKEN']}';
  static var serverUrl = 'https://api.platerecognizer.com';

  @override
  bool get allowAutoSignedCert => true;

  @override
  void onInit() {
    super.onInit();
    httpClient.addAuthenticator<dynamic>((request) async {
      request.headers.addAll({'Authorization': apiKey});
      return request;
    });
  }

  /// use Dio to upload/download pictures
  dio_lib.Dio _initDio() {
    var dio = dio_lib.Dio()
      ..options.connectTimeout = 5000 //5s
      ..options.receiveTimeout = 3000
      ..options.headers['Authorization'] = apiKey;

    if (dio.httpClientAdapter is DefaultHttpClientAdapter) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
        client.badCertificateCallback = (X509Certificate cert, String host, int port) {
          /* see https://pub.dev/packages/dio  format of certificate must be PEM or PKCS12.
        if (cert.pem == PEM) {
          // Verify the certificate
          return true;
        }
        return false;
        */
          return true;
        };
        return null;
      };
    } else {
      // (dio.httpClientAdapter as BrowserHttpClientAdapter).onHttpClientCreate =
      //     (client) {
      //   client.badCertificateCallback =
      //       (X509Certificate cert, String host, int port) {
      //     /* see https://pub.dev/packages/dio  format of certificate must be PEM or PKCS12.
      //   if (cert.pem == PEM) {
      //     // Verify the certificate
      //     return true;
      //   }
      //   return false;
      //   */
      //     return true;
      //   };
      // };
    }
    return dio;
  }

  // Future<Response> postUri(String uri, dynamic body,
  //     {Map<String, dynamic>? query}) async {
  //   var resp = await super
  //       .post('$serverUrl$uri', body, query: query)
  //       .timeout(const Duration(seconds: timeoutSeconds))
  //       .onError((error, stackTrace) {
  //     if (error is TimeoutException) {
  //       ScreenUtil.showToast('Timeout ! Check your connection', error: true);
  //       throw TimeoutException('Check your connection');
  //     } else {
  //       throw error!;
  //     }
  //   });
  //   log('postUri.resp => $resp for $serverUrl$uri');
  //   return resp;
  // }

  // Future<Response> getUri(String uri, {Map<String, dynamic>? query}) async {
  //   log('Api.getUri => $serverUrl$uri');
  //   var resp = await super
  //       .get('$serverUrl$uri', query: query)
  //       .timeout(const Duration(seconds: timeoutSeconds))
  //       .onError((error, stackTrace) {
  //     if (error is TimeoutException) {
  //       ScreenUtil.showToast('Timeout ! Check your connection', error: true);
  //       throw TimeoutException('Check your connection');
  //     } else {
  //       ScreenUtil.showToast('GetUri failed ${error.toString()}', error: true);
  //       throw error!;
  //     }
  //   });

  //   return resp;
  // }

  /// //////////////// DIO ////////////////////////
  ///
  // dynamic downloadPhoto(String uri, String fileName,
  //     {bool useCache = false}) async {
  //   var dir = await getTemporaryDirectory();
  //   if (!kIsWeb && (useCache || await NetUtil.isNotConnected())) {
  //     File file = File('${dir.path}/$fileName');
  //     bool _exist = file.existsSync();
  //     return file;
  //   }

  //   var dio = _initDio();
  //   log('downloadPhoto.Api => $serverUrl$uri');
  //   Uri? _uri = Uri.tryParse('$serverUrl$uri');
  //   var resp = await dio.getUri<List<int>>(_uri!,
  //       options: dioLib.Options(responseType: dioLib.ResponseType.bytes));
  //   if (kIsWeb) {
  //     //
  //   } else {
  //     File file = File('${dir.path}/$fileName');
  //     var raf = file.openSync(mode: FileMode.write);
  //     raf.writeFromSync(resp.data!);
  //     await raf.close();
  //     return file;
  //   }
  // }

// refer to https://github.com/shahshubh/CampusCar/blob/master/lib/screens/user/home/home_screen.dart
  Future<String> upload(String filePath, String fileName) async {
    var formData = dio_lib.FormData();

    formData.files.addAll([
      MapEntry(
          'upload',
          kIsWeb
              ? dio_lib.MultipartFile.fromBytes(await (XFile(filePath).readAsBytes()),
                  filename: fileName) // ternyata fileName itu wajib krn filePath di web suka ga jelas extensionnya apa
              : dio_lib.MultipartFile.fromFileSync(
                  filePath)) // beda case utk mobile, filePathnya sudah termasuk extensionnya
    ]);
    formData.fields.add(const MapEntry('regions', 'id'));

    Uri? uri = Uri.tryParse('$serverUrl/v1/plate-reader/');

    String? progress;
    String? percentage;
    var res = await _initDio().postUri<String>(
      uri!,
      options: dio_lib.Options(
        method: 'POST',
        responseType: dio_lib.ResponseType.json,
      ),
      data: formData,
      onSendProgress: (sent, total) {
        percentage = (sent / total * 100).toStringAsFixed(2);
        progress = "$percentage % uploaded ($sent / $total Bytes)";
        log(progress ?? '');
      },
    ).then((response) {
      log('uploading response $response'); //foto_ldv_depan_rmh_0016074932_0006017179-001.jpg
      return response;
    }).catchError((error) {
      // "{"upload":["The submitted data was not a file. Check the encoding type on the form."]}"
      throw Exception(error?.response ?? error.error);
    });

    return res.toString();
  }
}
