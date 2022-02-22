import 'package:dio/dio.dart';
import 'package:flutter_project_1/configs/app_config.dart';
import 'package:flutter_project_1/constants/endpoints.dart';

/// Example Repository
class DataRepository {
  static const baseUrl = AppConfigs.kServerUri;
  static Future<Response> getSomething() async {
    Dio _dio = Dio();
    Response response =
        await _dio.get("$baseUrl${AppEndpoint.exampleEndpoint}");
    return response;
  }
}
