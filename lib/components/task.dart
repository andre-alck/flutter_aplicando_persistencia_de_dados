import 'package:flutter/material.dart';
import 'package:flutter_aplicando_persistencia_de_dados/components/difficulty.dart';

class Task extends StatefulWidget {
  final String name;
  final String imageUrl;
  final int difficulty;
  int level;

  Task(this.name, this.imageUrl, this.difficulty, [this.level = 0, Key? key])
      : super(key: key);

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool assetOrNetwork() {
    if (widget.imageUrl.contains('http')) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(children: [
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4), color: Colors.blue),
              height: 140),
          Column(children: [
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white),
                height: 100,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.black26),
                          width: 72,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: assetOrNetwork()
                                ? Image.asset(widget.imageUrl,
                                    fit: BoxFit.cover)
                                : Image.network(widget.imageUrl,
                                    fit: BoxFit.cover),
                          )),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: 200,
                                child: Text(
                                  widget.name,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      overflow: TextOverflow.ellipsis),
                                )),
                            Difficulty(dificultyLevel: widget.difficulty),
                          ]),
                      SizedBox(
                          height: 52,
                          width: 52,
                          child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  widget.level++;
                                });
                              },
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: const [
                                    Icon(Icons.arrow_drop_up),
                                    Text('UP', style: TextStyle(fontSize: 12))
                                  ])))
                    ])),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                          color: Colors.white,
                          value: (widget.difficulty > 0)
                              ? (widget.level / widget.difficulty) / 10
                              : 1))),
              Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text('Nivel: ${widget.level}',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 16)))
            ])
          ])
        ]));
  }
}
