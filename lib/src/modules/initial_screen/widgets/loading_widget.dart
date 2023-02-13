import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('Por favor, aguarde.'),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: CircularProgressIndicator(),
          )
        ],
      ),
    );
  }
}
