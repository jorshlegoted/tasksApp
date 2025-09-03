class Task {
  Task({required this.title, this.isCompleted = false, this.isSelected = false, this.isQuickly = false});
  final String title;
  final bool isCompleted;
  final bool isSelected;
  final bool isQuickly;
}