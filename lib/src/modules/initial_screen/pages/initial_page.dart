import 'package:flutter/material.dart';
import 'package:flutter_aplicando_persistencia_de_dados/src/modules/form/pages/form_page.dart';
import 'package:flutter_aplicando_persistencia_de_dados/src/modules/initial_screen/widgets/loading_widget.dart';
import 'package:flutter_aplicando_persistencia_de_dados/src/modules/shared/models/task_dao.dart';
import 'package:flutter_aplicando_persistencia_de_dados/src/modules/shared/widgets/task_widget.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  late Future<List<Task>> _tasks;

  @override
  void initState() {
    super.initState();
    final _taskDao = TaskDao();
    _tasks = _taskDao.findAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text('Tarefas'),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {});
            },
            child: const Icon(Icons.refresh),
          )
        ],
      ),
      body: FutureBuilder(
        future: _tasks,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Erro. Por favor, aguarde o próximo evento.'),
              );
            }

            if (snapshot.hasData) {
              final List<Task> items = snapshot.data;

              if (items.isNotEmpty) {
                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    final task = items[index];
                    return task;
                  },
                );
              }

              return const Center(
                child: Text('Não há nenhuma tarefa cadastrada.'),
              );
            }
          }
          return const LoadingWidget();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) => FormPage(taskContext: context),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
