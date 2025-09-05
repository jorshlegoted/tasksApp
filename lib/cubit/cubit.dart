import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_2/models/task.dart';
part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(const TodoState(taskList: [], completedTasksList: []));

  void addTask(Task task) {
    final updatedTasks = List<Task>.from(state.taskList)..add(task);
    emit(
      TodoState(
        taskList: updatedTasks,
        completedTasksList: state.completedTasksList,
      ),
    );
  }

  void removeTask(Task task) {
    final updatedTasks = List<Task>.from(state.taskList)..remove(task);
    emit(
      TodoState(
        taskList: updatedTasks,
        completedTasksList: state.completedTasksList,
      ),
    );
  }

  void markAsQuickly(Task task) {
    final updatedTasks = state.taskList.map((taskItem) {
      if (taskItem == task) {
        return Task(
          title: taskItem.title,
          isSelected: taskItem.isSelected,
          isQuickly: !taskItem.isQuickly,
        );
      }
    }).toList();

    emit(
      TodoState(
        taskList: updatedTasks.map((task) => task ?? task!).toList(),
        completedTasksList: state.completedTasksList,
      )
    );
  }

  void completeTask(Task task) {
    final updatedTasks = List<Task>.from(state.taskList)..remove(task);
    final updatedCompletedTasks = List<Task>.from(state.completedTasksList)
    ..add(task);

  emit(
    TodoState(
      taskList: updatedTasks,
      completedTasksList: updatedCompletedTasks,
    )
  );

  }
}
