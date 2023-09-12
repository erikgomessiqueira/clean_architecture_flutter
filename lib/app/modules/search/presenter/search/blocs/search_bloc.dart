import 'package:clean_architecture_flutter/app/modules/search/domain/usecase/search_user_by_text_usecase.dart';
import 'package:clean_architecture_flutter/app/modules/search/presenter/search/states/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/transformers.dart';

class SearchBloc extends Bloc<String, StateBloc> {
  final SearchByText usecase;
  SearchBloc(this.usecase) : super(const StartState()) {
    on<String>(
      (searchText, emit) async {
        if (searchText.isEmpty) {
          emit(const StartState());
          return;
        }
        emit(const LoadingState());
        final result = await usecase(searchText);
        result.fold(
          (l) => emit(FailureState(l)),
          (r) => emit(SuccessState(r)),
        );
      },
      transformer: transformer(),
    );
  }

  EventTransformer<String> transformer<LoginEvent>() {
    return (events, mapper) {
      return events
          .debounceTime(const Duration(milliseconds: 500))
          .flatMap(mapper);
    };
  }
}
