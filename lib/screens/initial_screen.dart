import 'package:flutter/material.dart';
import 'package:flutter_aplicando_persistencia_de_dados/components/task.dart';
import 'package:flutter_aplicando_persistencia_de_dados/data/task_dao.dart';
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
        body: FutureBuilder(
            future: TaskDao().findAll(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Center(
                      child:
                          Text('Erro. Por favor, aguarde o próximo evento.'));
                }

                if (snapshot.hasData) {
                  final List<Task> items = snapshot.data;

                  if (items.isNotEmpty) {
                    return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          final task = items[index];
                          return task;
                        });
                  }
                }
              }
              return const LoadingWidget();
            }),
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

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
        Text('Por favor, aguarde.'),
        Padding(
            padding: EdgeInsets.only(top: 20),
            child: CircularProgressIndicator())
      ]),
    );
  }
}
