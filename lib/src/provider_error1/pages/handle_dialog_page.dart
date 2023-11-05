import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provier_error1_exports.dart';

/// 화면에서 특정 state( data 의 value ) 가 되었을 때
/// 화면 표시와 Dialog 를 함께 띄울 때 발행하는 현상

class HandleDialogPage extends StatefulWidget {
  const HandleDialogPage({super.key});

  @override
  State<HandleDialogPage> createState() => _HandleDialogPageState();
}

class _HandleDialogPageState extends State<HandleDialogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Handle Dialog'),
      ),
      body: Center(
        child: Text(
          'counter: ${context.watch<Counter>().counter}',
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
