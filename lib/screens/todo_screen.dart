import 'package:flutter/material.dart';
import 'package:flutter_application_2/cubit/cubit.dart';
import 'package:flutter_application_2/models/task.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _nameState();
}

class _nameState extends State<TodoScreen> {
  final TextEditingController _taskController = TextEditingController();
  bool quickly = false;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TodoCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Задачи'),
        backgroundColor: Color.fromARGB(171, 204, 131, 23),
      ),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (BuildContext context, TodoState state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Всего задач: ${state.taskList.length}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.taskList.length,
                  itemBuilder: (_, index) {
                    final task = state.taskList[index];

                    return Dismissible(
                      key: ValueKey(task.title),
                      onDismissed: (direction) => cubit.removeTask(task),
                      background: ColoredBox(
                        color: Colors.red.withValues(alpha: 0.1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [Icon(Icons.delete, color: Colors.black)],
                        ),
                      ),
                      child: ListTile(
                        tileColor: task.isQuickly == true
                            ? Colors.red
                            : task.isSelected
                            ? Colors.grey
                            : null,
                        onTap: () => cubit.markAsQuickly(task),
                        title: Text(task.title),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () => cubit.completeTask(task),
                              child: Icon(
                                task.isCompleted
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Text(
                'Выполнено: ${state.completedTasksList.length}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.completedTasksList.length,
                  itemBuilder: (context, index) {
                    final task = state.completedTasksList[index];

                    return Dismissible(
                      key: ValueKey(task.title),
                      onDismissed: (direction) => cubit.removeTask(task),
                      background: ColoredBox(
                        color: Colors.red.withValues(alpha: 0.1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [Icon(Icons.delete, color: Colors.black)],
                        ),
                      ),
                      child: ListTile(
                        title: Text(task.title),
                        trailing: Icon(Icons.check_box),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await showDialog(
          context: context,
          builder: (_) {
            return BlocBuilder<TodoCubit, TodoState>(
              builder: (context, state) {
                return AlertDialog(
                  title: Text('Добавить задачу'),
                  content: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Введите название задачи',
                    ),
                  ),
                  actions: [
                    GestureDetector(
                      onTap: () => context.read<TodoCubit>().markAsQuickly(
                        Task(
                          title: _taskController.text,
                          isQuickly: true,
                        )
                      ),
                      child: Icon(
                        !state.taskList.any((task) =>
                        task.title == _taskController.text && 
                        task.isQuickly)
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Отмена'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        context.read<TodoCubit>().addTask(
                          Task(title: _taskController.text,
                          isQuickly: state.taskList.any(
                            (task) =>
                            task.title == _taskController.text && task.isQuickly,
                          ))
                        );
                        _taskController.clear();
                      },
                      child: Text('Добавить'),
                    ),
                  ],
                );
              },
            );
          },
        ),
        backgroundColor: Color.fromARGB(192, 216, 151, 151),
        child: Icon(Icons.add),
      ),
    );
  }
}
