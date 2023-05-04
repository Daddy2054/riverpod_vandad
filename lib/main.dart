import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

// final currentDate = Provider<DateTime>(
//   (ref) => DateTime.now(),
// );

extension OptionalInfixAddition<T extends num> on T? {
  T? operator +(T? other) {
    final shadow = this;
    if (shadow != null) {
      return shadow + (other ?? 0) as T;
    } else {
      return null;
    }
  }
}

void testIt() {
  final int? int1 = 1;
  final int? int2 = 1;
  final result = int1 + int2;
  print(result);
}

class Counter extends StateNotifier<int?> {
  Counter() : super(null);
  void increment() => state = state == null ? 1 : state + 1;
 // int? get value => state;
}

final counterProvider = StateNotifierProvider<Counter, int?>(
  (ref) => Counter(),
);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    testIt();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Consumer(
              builder: (context, ref, child) {
                final count = ref.watch(counterProvider);
                final text =
                    count == null ? 'Press the button' : count.toString();
                return Text(text);
              },
              child: Text('Hooks Riverpod')),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
              onPressed: ref.read(counterProvider.notifier).increment,
              child: Text(
                'Increment counter',
              ),
            )
          ],
          // child: Text(
          //   date.toIso8601String(),
          //   style: Theme.of(context).textTheme.headlineMedium,
          // ),
        ));
  }
}
