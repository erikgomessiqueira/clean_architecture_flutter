import 'package:clean_architecture_flutter/app/modules/search/domain/entities/result_user_search.dart';
import 'package:clean_architecture_flutter/app/modules/search/domain/errors/errors.dart';
import 'package:equatable/equatable.dart';

abstract class StateBloc extends Equatable {
  const StateBloc();
  @override
  List<Object?> get props => [];
}

class SuccessState extends StateBloc {
  final List<ResultSearch> list;
  const SuccessState(this.list);
}
class FailureState extends StateBloc {
  final FailureSearch error;
  const FailureState(this.error);
}
class LoadingState extends StateBloc {
  const LoadingState();

}
class StartState extends StateBloc {
  const StartState();
}