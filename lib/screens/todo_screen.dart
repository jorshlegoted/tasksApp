import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/task.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _nameState();
}

class _nameState extends State<TodoScreen> {
  final List<Task> _tasks = [];
  final List<Task> _completedTasks = [];
  final TextEditingController _taskController = TextEditingController();
  bool quickly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Задачи'),
        backgroundColor: Color.fromARGB(171, 204, 131, 23),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Всего задач: ${_tasks.length}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (_, index) {
                final task = _tasks[index];

                return Dismissible(
                  key: ValueKey(task.title),
                  onDismissed: (direction) => setState(() {
                    _tasks.removeAt(index);
                  }),
                  background: ColoredBox(
                    color: Colors.red.withValues(alpha: 0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [Icon(Icons.delete, color: Colors.black)],
                    ),
                  ),
                  child: ListTile(
                    tileColor: task.isQuickly == true ? Colors.red : task.isSelected ? Colors.grey : null,
                    onTap: () => setState(() {
                      _tasks[index] = Task(
                        title: task.title,
                        isSelected: !task.isSelected,
                        isQuickly: task.isQuickly,
                      );
                    }),
                    title: Text(task.title),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () => setState(() {
                            _tasks.removeAt(index);
                            _completedTasks.add(task);
                          }),
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
            'Выполнено: ${_completedTasks.length}',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _completedTasks.length,
              itemBuilder: (context, index) {
                final task = _completedTasks[index];

                return Dismissible(
                  key: ValueKey(task.title),
                  onDismissed: (direction) => setState(() {
                    _completedTasks.removeAt(index);
                  }),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await showDialog(
          context: context,
          builder: (_) {
            return StatefulBuilder(
              builder: (context, setStateDialog) {
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
                      onTap: () {
                      setStateDialog(() {
                        quickly = !quickly;
                      });
                      },
                      child: Icon(
                        !quickly
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
                        setState(() {
                          if(!quickly) {
                            _tasks.add(Task(title: _taskController.text, isQuickly: true));
                          } else {
                          _tasks.add(Task(title: _taskController.text));
                          }
                        });
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
