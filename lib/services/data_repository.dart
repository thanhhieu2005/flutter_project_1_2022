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

  static Future<Response> getProvinceApi() async {
    Dio _dio = Dio();
    const provinceUrl = AppConfigs.provinceApi;

    Response response = await _dio.get(provinceUrl);

    return response;
  }

  static Future<Response> getDistricApi(int codeProvince) async {
    Dio _dio = Dio();
    const distictUrl = AppConfigs.districtApi;

    Response response = await _dio.get(distictUrl + codeProvince.toString());

    return response;
  }

  static Future<Response> getWardsApi(int codeDistrict) async {
    Dio _dio = Dio();
    const wardsUrl = AppConfigs.wardsApi;

    Response response = await _dio.get(wardsUrl + codeDistrict.toString());

    return response;
  }
}
