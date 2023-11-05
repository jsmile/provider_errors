import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provier_error1_exports.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int myCounter = 0;

  @override
  void initState() {
    super.initState();

    // initState() 시점에는 build 중이므로 상태변화를 야기하면 오류 발생
    // setState() or markNeedsBuild() called during build 오류 방지를 위해
    // After the current frame is completed, execute callback
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<Counter>().increment();
      myCounter = context.read<Counter>().counter + 10;
    });
    // Future.delayed(
    //   const Duration(seconds: 0),
    //   () {
    //     context.read<Counter>().increment();
    //     myCounter = context.read<Counter>().counter + 10;
    //   },
    // );
    // Future.microtask(() {
    //   context.read<Counter>().increment();
    //   myCounter = context.read<Counter>().counter + 10;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
      ),
      body: Center(
        child: Text(
          'counter: ${context.watch<Counter>().counter}\nmyCounter: $myCounter',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 40.0),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.read<Counter>().increment();
        },
      ),
    );
  }
}
