import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit/cubits/cubits.dart';

import 'pages/todos_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoFilterCubit>(
          create: (context) => TodoFilterCubit(),
        ),
        BlocProvider<TodoSearchCubit>(
          create: (context) => TodoSearchCubit(),
        ),
        BlocProvider<TodoListCubit>(
          create: (context) => TodoListCubit(),
        ),
        BlocProvider<ActiveTodoCountCubit>(
          create: (context) => ActiveTodoCountCubit(
            todoListCubit: BlocProvider.of<TodoListCubit>(context),
          ),
        ),
        BlocProvider<FilteredTodosCubit>(
          create: (context) => FilteredTodosCubit(
            todoFilterCubit: BlocProvider.of<TodoFilterCubit>(context),
            todoSearchCubit: BlocProvider.of<TodoSearchCubit>(context),
            todoListCubit: BlocProvider.of<TodoListCubit>(context),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'TODO',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const TodosPage(),
      ),
    );
  }
}
