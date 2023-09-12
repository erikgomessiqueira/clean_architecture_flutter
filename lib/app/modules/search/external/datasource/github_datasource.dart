import 'package:clean_architecture_flutter/app/modules/search/domain/errors/errors.dart';
import 'package:clean_architecture_flutter/app/modules/search/infra/datasources/search_datasource.dart';
import 'package:clean_architecture_flutter/app/modules/search/infra/models/result_search_model.dart';
import 'package:dio/dio.dart';

class GitHubDatasource implements SearchDatasource {
  final Dio dio;

  GitHubDatasource(this.dio);

  @override
  Future<List<ResultUserSearchModel>> search(String searchText) async {
    final response = await dio.get(
      'https://api.github.com/search/users?q=${searchText.replaceAll(' ', '+')}',
    );

    if (response.statusCode == 200) {
      final list = (response.data['items'] as List).map((e) {
        return ResultUserSearchModel.fromMap(e);
      }).toList();
      return list;
    } else {
      throw DatasourceError();
    }
  }
}
