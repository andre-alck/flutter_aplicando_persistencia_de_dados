import 'package:flutter/material.dart';
import 'package:flutter_aplicando_persistencia_de_dados/src/modules/shared/widgets/task_widget.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({Key? key, required Widget child})
      : super(key: key, child: child);

  final List<Task> taskList = [
    Task('Aprender Flutter', 'assets/images/dash.png', 3, 9),
    Task('Andar de Bike', 'assets/images/bike.webp', 2, 4),
    Task('Meditar', 'assets/images/meditar.jpeg', 5, 25),
    Task('Ler', 'assets/images/livro.jpg', 4, 16),
    Task('Jogar', 'assets/images/jogar.jpg', 1, 1)
  ];

  void newTask(
    String name,
    String photo,
    int difficulty,
    int level,
  ) {
    taskList.add(Task(name, photo, difficulty, level));
  }

  static TaskInherited of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');

    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
