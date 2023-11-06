import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provier_error1_exports.dart';

class HandleDialogPage extends StatefulWidget {
  const HandleDialogPage({super.key});

  @override
  State<HandleDialogPage> createState() => _HandleDialogPageState();
}

class _HandleDialogPageState extends State<HandleDialogPage> {
  /// 1. 화면에서 특정 state( data 의 value ) 가 되었을 때
  /// initState() 에서 화면 표시와 Dialog 를 함께 띄울 때 오류발생
  @override
  void initState() {
    super.initState();

    // initState() 시점에는 build 중이므로 상태변화를 야기시 발생하는 오류 방지
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text('Be careful !!!'),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // build 중이므로 상태변화를 야기시 발생하는 오류 방지
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // if (context.watch<Counter>().counter == 3) {  // widget tree 밖에서 사용 error
      if (context.read<Counter>().counter == 3) {
        // if (Provider.of<Counter>(context, listen: false).counter == 3) {
        // 단지
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text('Be careful !!!'),
            );
          },
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Handle Dialog'),
      ),
      body: Center(
        child: Text(
          /// 2. build() 안이나 Provider( update: ) 안에서 context.read<T>() 사용금지
          /// 대신, context.watch<T>() 사용 권장.  또는 context.select<T, R>(R Function(T value) selector)
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
