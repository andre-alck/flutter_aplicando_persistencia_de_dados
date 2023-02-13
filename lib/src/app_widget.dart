import 'package:flutter/material.dart';
import 'package:flutter_aplicando_persistencia_de_dados/src/modules/initial_screen/pages/initial_page.dart';
import 'package:flutter_aplicando_persistencia_de_dados/src/modules/shared/widgets/task_inherited.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TaskInherited(child: const InitialPage()),
    );
  }
}
