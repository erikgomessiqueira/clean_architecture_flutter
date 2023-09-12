import 'package:clean_architecture_flutter/app/modules/search/domain/entities/result_user_search.dart';
import 'package:clean_architecture_flutter/app/modules/search/domain/errors/errors.dart';
import 'package:clean_architecture_flutter/app/modules/search/infra/datasources/search_datasource.dart';
import 'package:clean_architecture_flutter/app/modules/search/infra/models/result_search_model.dart';
import 'package:clean_architecture_flutter/app/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_repository_test.mocks.dart';

@GenerateMocks([SearchDatasource])
main() {
  final datasource = MockSearchDatasource();
  final repository = SearchRepositoryImpl(datasource);

  test('deve retornar uma lista de ResultUserSearchModel', () async {
    when(datasource.search(any))
        .thenAnswer((_) async => <ResultUserSearchModel>[]);

    final result = await repository.getUsers("Teste");
    expect(result, isA<List<ResultSearch>>());
  });

  test('deve retornar um DatasourceError se falhar', () async {
    when(datasource.search(any))
        .thenThrow((_) async => Exception());

    final result = await repository.getUsers("Teste");
    expect(result.fold(id, id), isA<DatasourceError>());
  });
}
