import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_cubit/cubits/todo_filter/todo_filter_cubit.dart';
import 'package:todo_cubit/cubits/todo_list/todo_list_cubit.dart';
import 'package:todo_cubit/cubits/todo_search/todo_search_cubit.dart';

import '../../models/todo_model.dart';

part 'filtered_todos_state.dart';

class FilteredTodosCubit extends Cubit<FilteredTodosState> {
  final TodoListCubit todoListCubit;
  final TodoFilterCubit todoFilterCubit;
  final TodoSearchCubit todoSearchCubit;

  late final StreamSubscription todoListSubscription;
  late final StreamSubscription todoFilterSubscription;
  late final StreamSubscription todoSearchSubscription;

  FilteredTodosCubit({
    required this.todoListCubit,
    required this.todoFilterCubit,
    required this.todoSearchCubit,
  }) : super(FilteredTodosState.initial()) {
    todoListSubscription = todoListCubit.stream.listen(
      (TodoListState todoListState) {},
    );
    todoFilterSubscription = todoFilterCubit.stream.listen(
      (event) {},
    );
    todoSearchSubscription = todoSearchCubit.stream.listen(
      (event) {},
    );
  }

  void setFilteredTodos() {
    List<Todo> filteredTodos;

    // 먼저 현재의 Filter 상태를 반영한 Todo List 를 구하고,
    switch (todoFilterCubit.state.filter) {
      case Filter.active:
        filteredTodos = todoListCubit.state.todos
            .where((Todo todo) => todo.completed == Filter.active)
            .toList();
        break;

      case Filter.completed:
        filteredTodos = todoListCubit.state.todos
            .where((Todo todo) => todo.completed == Filter.completed)
            .toList();
        break;

      case Filter.all:
      default:
        filteredTodos = todoListCubit.state.todos;
        break;
    }

    // 현재의 Filter 상태에서 검색어를 반영한 Todo List 를 구한 뒤,
    if (todoSearchCubit.state.searchTerm.isNotEmpty) {
      filteredTodos = filteredTodos
          .where((Todo todo) => todo.desc
              .toLowerCase()
              .contains(todoSearchCubit.state.searchTerm.toLowerCase()))
          .toList();
    }

    // Filtered Todos State 를 업데이트 한다.
    emit(state.copyWith(filteredTodos: filteredTodos));
  }
}
