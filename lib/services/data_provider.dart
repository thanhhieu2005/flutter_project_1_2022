import 'package:flutter_project_1/models/address/district_model.dart';
import 'package:flutter_project_1/models/address/wards_model.dart';
import 'package:flutter_project_1/models/example_model.dart';
import 'package:flutter_project_1/models/address/province_model.dart';
import 'package:flutter_project_1/models/users/user.dart';
import 'package:flutter_project_1/services/destination_post_repository.dart';

import 'data_repository.dart';

class DataProvider {
  static Future<ExampleModel> getSomething() async {
    final response = await DataRepository.getSomething();

    final result = ExampleModel.fromMap(response.data);

    return result;
  }

  static Future<List<Province>> getProvinceApi() async {
    final response = await DataRepository.getProvinceApi();

    var result = (response.data['results'] as List)
        .map((e) => Province.fromMap(e))
        .toList();

    return result;
  }

  static Future<List<District>> getDistrictApi(int codeProvince) async {
    final response = await DataRepository.getDistricApi(codeProvince);

    var result = (response.data['results'] as List)
        .map((e) => District.fromMap(e))
        .toList();

    return result;
  }

  static Future<List<Wards>> getWardsApi(int codeDistrict) async {
    final response = await DataRepository.getWardsApi(codeDistrict);

    var result = (response.data['results'] as List)
        .map((e) => Wards.fromMap(e))
        .toList();

    return result;
  }
}
