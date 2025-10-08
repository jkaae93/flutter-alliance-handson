import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:counter/counter/counter_local_datasource.dart';
import 'package:counter/counter/counter_repository_impl.dart';
import 'package:counter/counter/increment_counter.dart';
import 'package:counter/counter/counter_notifier.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = CounterRepositoryImpl(CounterLocalDataSourceImpl());
    return ChangeNotifierProvider(
      create: (_) => CounterNotifier(IncrementCounter(repository)),
      child: MaterialApp(
        title: 'Counter Clean Architecture',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final counterValue = context.watch<CounterNotifier>().counter.value;
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: Text('$counterValue', style: Theme.of(context).textTheme.headlineMedium),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<CounterNotifier>().increment(),
        child: const Icon(Icons.add),
      ),
    );
  }
}