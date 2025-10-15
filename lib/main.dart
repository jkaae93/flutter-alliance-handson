import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Counter feature imports
import 'features/counter/data/datasources/counter_local_datasource.dart';
import 'features/counter/data/repositories/counter_repository_impl.dart';
import 'features/counter/domain/usecases/get_counter.dart';
import 'features/counter/domain/usecases/increment_counter.dart';
import 'features/counter/presentation/providers/counter_provider.dart';
import 'features/counter/presentation/pages/counter_page.dart';

// History feature imports
import 'features/history/data/datasources/history_local_datasource.dart';
import 'features/history/data/repositories/history_repository_impl.dart';
import 'features/history/domain/usecases/get_history.dart';
import 'features/history/domain/usecases/add_history_entry.dart';
import 'features/history/presentation/providers/history_provider.dart';
import 'features/history/presentation/pages/history_page.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 의존성 주입 설정
    const secureStorage = FlutterSecureStorage();

    // Counter dependencies
    final counterDataSource = CounterLocalDataSourceImpl();
    final counterRepository = CounterRepositoryImpl(counterDataSource);
    final getCounter = GetCounter(counterRepository);
    final incrementCounter = IncrementCounter(counterRepository);

    // History dependencies
    final historyDataSource = HistoryLocalDataSourceImpl(secureStorage);
    final historyRepository = HistoryRepositoryImpl(historyDataSource);
    final getHistory = GetHistory(historyRepository);
    final addHistoryEntry = AddHistoryEntry(historyRepository);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CounterProvider(
            getCounter: getCounter,
            incrementCounter: incrementCounter,
            addHistoryEntry: addHistoryEntry,
          )..loadCounter(),
        ),
        ChangeNotifierProvider(
          create: (_) => HistoryProvider(
            getHistory: getHistory,
          )..loadHistory(),
        ),
      ],
      child: MaterialApp(
        title: 'Counter Clean Architecture',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const CounterPage(),
    const HistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentIndex == 0 ? '카운터' : '히스토리'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          // 히스토리 탭으로 이동할 때 새로고침
          if (index == 1) {
            context.read<HistoryProvider>().refresh();
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: '카운터',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: '히스토리',
          ),
        ],
      ),
    );
  }
}
