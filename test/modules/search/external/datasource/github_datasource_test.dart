import 'dart:convert';

import 'package:clean_architecture_flutter/app/modules/search/domain/errors/errors.dart';
import 'package:clean_architecture_flutter/app/modules/search/external/datasource/github_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../utils/github_response_util.dart';
import 'github_datasource_test.mocks.dart';

@GenerateMocks([Dio])
main() {
  final dio = MockDio();
  final datasource = GitHubDatasource(dio);
  test('Deve retornar uma lista de ResultUserSearchModel', () async {
    when(dio.get(any)).thenAnswer((_) async {
      return Response(
        data: jsonDecode(gitHubResponseUtil),
        statusCode: 200,
        requestOptions: RequestOptions(),
      );
    });

    final future = datasource.search('Teste');
    
    expect(future, completes);
  });

  test('Deve retornar um erro se o código não for 200', () async {
    when(dio.get(any)).thenAnswer((_) async {
      return Response(
        data: jsonDecode(gitHubResponseUtil),
        statusCode: 400,
        requestOptions: RequestOptions(),
      );
    });

    final future = datasource.search('Teste');

    expect(future, throwsA(isA<DatasourceError>()));
  });

  test('Deve retornar um erro se ocorrer um erro no Dio', () async {
    when(dio.get(any)).thenThrow(Exception());

    final future = datasource.search('Teste');

    expect(future, throwsA(isA<Exception>()));
  });
}
