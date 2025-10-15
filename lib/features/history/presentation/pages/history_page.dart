import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/history_provider.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HistoryProvider>(
        builder: (context, historyProvider, child) {
          if (historyProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (historyProvider.history.isNotEmpty) {
            return ListView.builder(
              itemCount: historyProvider.history.length,
              itemBuilder: (context, index) {
                final historyItem = historyProvider.history[index];
                final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss')
                    .format(historyItem.timestamp);
                
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text('${historyItem.counterValue}'),
                    ),
                    title: Text('카운터 값: ${historyItem.counterValue}'),
                    subtitle: Text('시간: $formattedDate'),
                    trailing: const Icon(Icons.history),
                  ),
                );
              },
            );
          } else if (historyProvider.errorMessage != null) {
            return Center(
              child: Text(
                '오류: ${historyProvider.errorMessage}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            return const Center(
              child: Text(
                '아직 히스토리가 없습니다.\n카운터를 증가시켜보세요!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<HistoryProvider>().refresh(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}