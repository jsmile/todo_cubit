import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/todo_model.dart';

part 'todo_filter_state.dart';

class TodoFilterCubitCubit extends Cubit<TodoFilterState> {
  TodoFilterCubitCubit() : super(TodoFilterState.initial());

  void chageFilter(Filter newFilter) {
    emit(state.copyWith(filter: newFilter));
  }
}