import 'package:flutter/material.dart';
import 'package:flutter_aplicando_persistencia_de_dados/data/task_inherited.dart';
import 'package:flutter_aplicando_persistencia_de_dados/screens/form_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(leading: Container(), title: const Text('Tarefas')),
        body: ListView(
            padding: const EdgeInsets.only(top: 8, bottom: 70),
            children: TaskInherited.of(context).taskList),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (contextNew) =>
                          FormScreen(taskContext: context)));
            },
            child: const Icon(Icons.add)));
  }
}
