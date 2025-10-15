import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/counter_provider.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CounterProvider>(
        builder: (context, counterProvider, child) {
          if (counterProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (counterProvider.counter != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '카운터',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${counterProvider.counter!.value}',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
            );
          } else if (counterProvider.errorMessage != null) {
            return Center(
              child: Text(
                '오류: ${counterProvider.errorMessage}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const Center(child: Text('초기화 중...'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<CounterProvider>().increment(),
        child: const Icon(Icons.add),
      ),
    );
  }
}