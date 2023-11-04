import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: TextView(),
    );
  }
}

// 위젯트리로 하여금 프로바이더의 변화를 알수있도록 extend ConsumerWidget
class TextView extends ConsumerWidget {
  TextView({Key? key}) : super(key: key);
  final counterProvider = StateNotifierProvider((ref) => Counter());

  // WidgetRef
  // 위젯이 프로바이더와 상호작용할 수 있도록 위젯을 허용하는 객체
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 무엇을 지켜볼지 선언
    final count = ref.watch(counterProvider);

    // listen을 통해 상태를 받을 수 있음
    ref.listen(counterProvider, (previous, next) {
      print("현재 상태: $previous, $next");
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod 예제'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "count: ${count.toString()}",
              style: const TextStyle(
                fontSize: 50,
              ),
            ),
            TextButton(
              // ref.watch를 통해 provider에 접근,
              // .notifier로 상태 변화 없이 provider와 소통
              onPressed: () => ref.watch(counterProvider.notifier).increment(),
              child: const Text('증가하기',
                  style: TextStyle(
                    fontSize: 30,
                  )),
            )
          ],
        ),
      ),
    );
  }
}

// StateNotifier
// 일부 로직을 같이 사용하고 값을 읽고 수정할수있는 상태를 변경하기 위해 사용
class Counter extends StateNotifier<int> {
  Counter() : super(0);

  void increment() => state++;
}
