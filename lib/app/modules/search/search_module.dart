import 'package:clean_architecture_flutter/app/modules/search/domain/repositories/search_repository.dart';
import 'package:clean_architecture_flutter/app/modules/search/domain/usecase/search_user_by_text_usecase.dart';
import 'package:clean_architecture_flutter/app/modules/search/external/datasource/github_datasource.dart';
import 'package:clean_architecture_flutter/app/modules/search/infra/datasources/search_datasource.dart';
import 'package:clean_architecture_flutter/app/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:clean_architecture_flutter/app/modules/search/presenter/search/blocs/search_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'presenter/search/search_page.dart';
 
class SearchModule extends Module {
  @override
  void binds(Injector i) {
    i.add<SearchByText>(SearchByTextImpl.new);
    i.add<SearchRepository>(SearchRepositoryImpl.new);
    i.add<SearchDatasource>(GitHubDatasource.new);
    i.addInstance<Dio>(Dio());
    i.addLazySingleton(SearchBloc.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child:(context) => const SearchPage());
  }
}