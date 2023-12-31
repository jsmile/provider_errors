import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provier_error1_exports.dart';

/// 화면에서 특정 state( data 의 value ) 가 되었을 때
/// 화면에 value 를 표시하는 동시에 다른 화면으로 이동하는 경우 발생하는 현상

class NavigatePage extends StatefulWidget {
  const NavigatePage({super.key});

  @override
  State<NavigatePage> createState() => _NavigatePageState();
}

class _NavigatePageState extends State<NavigatePage> {
  @override
  Widget build(BuildContext context) {
    // if (context.read<Counter>().counter == 3) {
    //   // build 작업 중에 또다른 widget 를 생성하면 오류 발생
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => const OtherPage()),
    //   );
    // }

    if (context.read<Counter>().counter == 3) {
      // build 작업이 끝나고 실행할 수 있도록 addPostFrameCallback 사용
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OtherPage()),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigate Page'),
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

class OtherPage extends StatelessWidget {
  const OtherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Other Page'),
      ),
      body: const Center(
        child: Text(
          'Otehr',
          style: TextStyle(fontSize: 40.0),
        ),
      ),
    );
  }
}
