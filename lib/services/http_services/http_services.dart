import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HttpServices {
  //GET API CALL

  static Future<dynamic> getMethod(String url,
      {required Map<String, String> header}) async {
    try {
      http.Response response = await http.get(Uri.parse(url), headers: header);
      return response;
    } catch (e) {
      debugPrint("get_method_error : $e");
      rethrow;
    }
  }

  //POST API CALL
  static Future<dynamic> postMethod(
    String url, {
    dynamic data,
    Map<String, String>? header,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: header,
        body: data,
      );
      return response;
    } catch (e) {
      debugPrint("post_method_error : $e");
      rethrow;
    }
  }
  //DELETE API CALL
 static Future<dynamic> deleteMethod(
      String url, {
        dynamic data,
        Map<String, String>? header,
      }) async {
    try {
      http.Response response = await http.delete(
        Uri.parse(url),
        headers: header,
        body: data,
      );
      return response;
    } catch (e) {
      debugPrint("Error at delete method ====>>>$e");
      rethrow;
    }
  }

  //PUT API CALL
  static Future<dynamic> putMethod(
    String url, {
    dynamic data,
    Map<String, String>? header,
  }) async {
    try {
      http.Response response = await http.put(
        Uri.parse(url),
        headers: header,
        body: data,
      );
      return response;
    } catch (e) {
      debugPrint("put_method_error : $e");
      rethrow;
    }
  }

static Future<dynamic> postMultiPartResponse(
      {required String url,
      Map<String, String>? bodyData,
      // dynamic bodyData,
      List<MultipartFile>? listFile,
      Map<String, String>? header}) async {
    final request = http.MultipartRequest("POST", Uri.parse(url));

    try {
      request.files.addAll(listFile!);
      request.headers.addAll(header!);
      request.fields.addAll(bodyData!);

      var responseStream = await request.send();
      final response = await http.Response.fromStream(responseStream);

      if (response.statusCode == 200) {
        return response;
      }
      return null;
    } catch (e) {
      debugPrint("multipart_method_error : $e");
      rethrow;
    }
  }
}
