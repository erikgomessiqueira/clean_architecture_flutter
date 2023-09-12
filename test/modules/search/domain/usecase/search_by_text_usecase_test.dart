import 'package:clean_architecture_flutter/app/modules/search/domain/entities/result_user_search.dart';
import 'package:clean_architecture_flutter/app/modules/search/domain/errors/errors.dart';
import 'package:clean_architecture_flutter/app/modules/search/domain/repositories/search_repository.dart';
import 'package:clean_architecture_flutter/app/modules/search/domain/usecase/search_user_by_text_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_by_text_usecase_test.mocks.dart';

@GenerateMocks([SearchRepository])
main() {
  final repository = MockSearchRepository();
  final usecase = SearchByTextImpl(repository);

  test('deve retornar uma lista de ResultUserSearch', () async {
    when(repository.getUsers(any))
        .thenAnswer((_) async => const Right(<ResultSearch>[]));

    final result = await usecase("Teste");
    expect(result, isA<List<ResultSearch>>());
  });

  test(
    'deve retornar uma InvalidTextError caso o texto seja invalido',
    () async {
      when(repository.getUsers(any))
          .thenAnswer((_) async => const Right(<ResultSearch>[]));
      final result = await usecase('');
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<InvalidTextError>());
    },
  );
}
