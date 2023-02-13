import 'package:flutter/material.dart';
import 'package:flutter_aplicando_persistencia_de_dados/src/modules/shared/widgets/task_widget.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({Key? key, required Widget child})
      : super(key: key, child: child);

  final List<Task> taskList = [
    const Task('Aprender Flutter', 'assets/images/dash.png', 3),
    const Task('Andar de Bike', 'assets/images/bike.webp', 2),
    const Task('Meditar', 'assets/images/meditar.jpeg', 5),
    const Task('Ler', 'assets/images/livro.jpg', 4),
    const Task('Jogar', 'assets/images/jogar.jpg', 1)
  ];

  void newTask(String name, String photo, int difficulty) {
    taskList.add(Task(name, photo, difficulty));
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
