import 'dart:convert';

import 'package:clean_architecture_flutter/app/modules/search/domain/entities/result_user_search.dart';
import 'package:clean_architecture_flutter/app/modules/search/domain/errors/errors.dart';
import 'package:clean_architecture_flutter/app/modules/search/domain/usecase/search_user_by_text_usecase.dart';
import 'package:clean_architecture_flutter/app/modules/search/search_module.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_module_test.mocks.dart';
import 'utils/github_response_util.dart';

@GenerateMocks([Dio])
main() {
  final mockDio = MockDio();
  Modular.init(SearchModule());
  Modular.replaceInstance<Dio>(mockDio);

  test('deve retornar o usecase sem erro', (){
    final usecase = Modular.get<SearchByText>();
    expect(usecase, isA<SearchByTextImpl>());
  });

  test('deve retornar uma lista de ResultSearch', () async {
    when(mockDio.get(any)).thenAnswer((_) async {
      return Response(
        data: jsonDecode(gitHubResponseUtil),
        statusCode: 200,
        requestOptions: RequestOptions(),
      );
    });

    final usecase = Modular.get<SearchByText>();
    final result = await usecase('Teste');
    expect(result, isA<List<ResultSearch>>());
  });

  test('deve retornar um erro se o código não for 200', () async {
    when(mockDio.get(any)).thenAnswer((_) async {
      return Response(
        data: {},
        statusCode: 400,
        requestOptions: RequestOptions(),
      );
    });

    final usecase = Modular.get<SearchByText>();
    final result = await usecase('Teste');
    expect(result.fold(id, id), isA<DatasourceError>());
  });
}