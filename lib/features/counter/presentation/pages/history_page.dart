import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/history_bloc.dart';
import '../bloc/history_event.dart';
import '../bloc/history_state.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<HistoryBloc>().add(const LoadHistoryEvent());
  }

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
                child: Text('아직 히스토리가 없습니다'),
              );
            }
            
            final reversedHistory = state.history.reversed.toList();
            
            return ListView.builder(
              itemCount: reversedHistory.length,
              itemBuilder: (context, index) {
                final historyItem = reversedHistory[index];
                final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
                
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('${historyItem.count}'),
                  ),
                  title: Text('카운터: ${historyItem.count}'),
                  subtitle: Text(
                    dateFormat.format(historyItem.timestamp),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                );
              },
            );
          } else if (state is HistoryError) {
            return Center(
              child: Text('오류 발생: ${state.message}'),
            );
          }
          return const Center(child: Text('히스토리를 불러오는 중...'));
        },
      ),
    );
  }
}
