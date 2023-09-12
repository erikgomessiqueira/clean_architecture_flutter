import 'package:clean_architecture_flutter/app/modules/search/infra/models/result_search_model.dart';

abstract class SearchDatasource {
  Future<List<ResultUserSearchModel>> search(String searchText);
}