import 'dart:isolate';

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Image.asset('assets/ball.gif'),
          ElevatedButton(
              onPressed: () async {
                await complexTask1();
              },
              child: const Text('btn1')),
          ElevatedButton(
              onPressed: () async {
                final receivePort = ReceivePort();
                await Isolate.spawn(completeTask2, receivePort.sendPort);
                // use to create isolate not to get response

                // for response we use listen
                receivePort.listen(
                  (message) => print(message),
                );
              },
              child: const Text('btn2')),
          ElevatedButton(onPressed: () {}, child: const Text('btn3'))
        ],
      ),
    );
  }
}

Future<double> complexTask1() async {
  var res = 0.0;
  for (int i = 0; i <= 1000000000; i++) {
    res = res + i;
  }
  print(res);
  return res;
}

completeTask2(SendPort sendPort) {
  var res = 0.0;
  for (int i = 0; i <= 1000000000; i++) {
    res = res + i;
  }
  print(res);
  sendPort.send(res);
}
