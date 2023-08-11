import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit/cubits/todo_list/todo_list_cubit.dart';

class CreateTodo extends StatefulWidget {
  const CreateTodo({super.key});

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  final TextEditingController newEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: newEditingController,
      decoration: const InputDecoration(labelText: 'What to do?'),
      onSubmitted: (String? todoDesc) {
        if (todoDesc != null && todoDesc.isNotEmpty) {
          context.read<TodoListCubit>().addTodo(todoDesc);
          // 입력내용 지우기
          newEditingController.clear();
        }
      },
    );
  }

  @override
  void dispose() {
    newEditingController.dispose();
    super.dispose();
  }
}
