import 'package:clean_architecture_flutter/app/modules/search/domain/entities/result_user_search.dart';
import 'package:clean_architecture_flutter/app/modules/search/domain/errors/errors.dart';
import 'package:clean_architecture_flutter/app/modules/search/domain/repositories/search_repository.dart';
import 'package:dartz/dartz.dart';

abstract class ISearchUserByText {
  Future<Either<FailureSearch, List<ResultUserSearch>?>> call(
      String searchText);
}

class SearchUserByTextImpl implements ISearchUserByText {
  final SearchRepository repository;

  SearchUserByTextImpl(this.repository);

  @override
  Future<Either<FailureSearch, List<ResultUserSearch>?>> call(
      String searchText) {
    if (searchText.isEmpty) return Future.value(Left(InvalidTextError()));

    return repository.search(searchText);
  }
}
