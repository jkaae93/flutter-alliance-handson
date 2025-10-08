import 'package:counter/counter/counter.dart';

abstract class CounterRepository {
  Counter getCounter();
  Counter increment();
}

