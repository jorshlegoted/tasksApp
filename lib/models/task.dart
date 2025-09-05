class Task {
  Task({
    required this.title,
    this.isCompleted = false,
    this.isSelected = false,
    this.isQuickly = false,
  });
  final String title;
  final bool isCompleted;
  final bool isSelected;
  final bool isQuickly;

  Task copyWith({
    String? title,
    bool? isCompleted,
    bool? isSelected,
    bool? isQuickly,
  }) {
    return Task(
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      isSelected: isSelected ?? this.isSelected,
      isQuickly: isQuickly ?? this.isQuickly,
    );
  }
}
