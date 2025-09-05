part of 'cubit.dart';

class TodoState extends Equatable {
  const TodoState({
    this.taskList = const [],
    this.completedTasksList = const [],
  });

  final List<Task> taskList;
  final List<Task> completedTasksList;

  @override
  // TODO: implement props
  List<Object?> get props => [taskList, completedTasksList];


}
