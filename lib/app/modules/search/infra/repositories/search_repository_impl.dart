import 'package:clean_architecture_flutter/app/modules/search/domain/entities/result_user_search.dart';
import 'package:clean_architecture_flutter/app/modules/search/domain/errors/errors.dart';
import 'package:clean_architecture_flutter/app/modules/search/domain/repositories/search_repository.dart';
import 'package:clean_architecture_flutter/app/modules/search/infra/datasources/search_datasource.dart';
import 'package:dartz/dartz.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDatasource datasource;
  SearchRepositoryImpl(this.datasource);

  @override
  Future<Either<FailureSearch, List<ResultUserSearch>?>> search(String searchText)
  async {
    try{
      final result = await datasource.getSearch(searchText);
      return Right(result);
    } on DatasourceError catch(error){
      return Left(error);
    } catch(error){
      return Left(DatasourceError());
    }
  }

  
  
}