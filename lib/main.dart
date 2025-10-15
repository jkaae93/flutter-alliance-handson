import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'features/counter/data/datasources/counter_history_local_datasource.dart';
import 'features/counter/data/datasources/counter_local_datasource.dart';
import 'features/counter/data/repositories/counter_history_repository_impl.dart';
import 'features/counter/data/repositories/counter_repository_impl.dart';
import 'features/counter/domain/usecases/add_counter_history.dart';
import 'features/counter/domain/usecases/get_counter.dart';
import 'features/counter/domain/usecases/get_counter_history.dart';
import 'features/counter/domain/usecases/increment_counter.dart';
import 'features/counter/presentation/bloc/counter_bloc.dart';
import 'features/counter/presentation/bloc/counter_event.dart';
import 'features/counter/presentation/bloc/history_bloc.dart';
import 'features/counter/presentation/pages/counter_page.dart';
import 'features/counter/presentation/pages/history_page.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    final counterDataSource = CounterLocalDataSourceImpl();
    final counterRepository = CounterRepositoryImpl(counterDataSource);
    
    const secureStorage = FlutterSecureStorage();
    final historyDataSource = CounterHistoryLocalDataSourceImpl(secureStorage);
    final historyRepository = CounterHistoryRepositoryImpl(historyDataSource);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CounterBloc(
            incrementCounter: IncrementCounter(counterRepository),
            getCounter: GetCounter(counterRepository),
          )..add(const GetCounterEvent()),
        ),
        BlocProvider(
          create: (_) => HistoryBloc(
            getCounterHistory: GetCounterHistory(historyRepository),
            addCounterHistory: AddCounterHistory(historyRepository),
          ),
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

  final List<Widget> _pages = const [
    CounterPage(),
    HistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentIndex == 0 ? 'Counter' : 'History'),
        centerTitle: true,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.countertops),
            label: 'Counter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
    );
  }
}
