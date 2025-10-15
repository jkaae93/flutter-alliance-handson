import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/history_bloc.dart';
import '../bloc/history_event.dart';
import '../bloc/history_state.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HistoryLoaded) {
            if (state.history.isEmpty) {
              return const Center(
                child: Text(
                  '아직 히스토리가 없습니다.\n카운터를 증가시켜보세요!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              );
            }
            return ListView.builder(
              itemCount: state.history.length,
              itemBuilder: (context, index) {
                final historyItem = state.history[index];
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
          } else if (state is HistoryError) {
            return Center(
              child: Text(
                '오류: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const Center(child: Text('초기화 중...'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<HistoryBloc>().add(HistoryRefreshed()),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}