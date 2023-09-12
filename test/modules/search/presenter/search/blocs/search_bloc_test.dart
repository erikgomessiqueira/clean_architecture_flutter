import 'package:bloc_test/bloc_test.dart';
import 'package:clean_architecture_flutter/app/modules/search/domain/entities/result_user_search.dart';
import 'package:clean_architecture_flutter/app/modules/search/domain/errors/errors.dart';
import 'package:clean_architecture_flutter/app/modules/search/domain/usecase/search_user_by_text_usecase.dart';
import 'package:clean_architecture_flutter/app/modules/search/presenter/search/blocs/search_bloc.dart';
import 'package:clean_architecture_flutter/app/modules/search/presenter/search/states/states.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_bloc_test.mocks.dart';

@GenerateMocks([SearchByText])
main() {
  final usecase = MockSearchByText();
  final bloc = SearchBloc(usecase);

    blocTest(
      'deve retornar um [LoadingState, SuccessState]',
      build: () {
        when(usecase.call(any))
            .thenAnswer((_) async => const Right(<ResultSearch>[]));
        return bloc;
      },
      act: (bloc) => bloc.add('Teste'),
      skip: 0,
      wait: Duration(microseconds: 500),
      expect: () => [
        isA<LoadingState>(),
        isA<SuccessState>(),
      ],
    );

  blocTest(
    'deve retornar um [LoadingState, FailureState]',
    build: () {
      when(usecase.call(any))
          .thenAnswer((_) async => Left(DatasourceError()));
      return bloc;
    },
    act: (bloc) => bloc.add('Teste'),
    skip: 0,
    wait: const Duration(microseconds: 500),
    expect: () => [
      isA<LoadingState>(),
      isA<FailureState>(),
    ],
  );

}
