import 'package:flutter/material.dart';
import '../models/cycle.dart';

class CycleProvider with ChangeNotifier {
  List<Cycle> _cycles = [];

  List<Cycle> get cycles => _cycles;

  void addCycle(Cycle cycle) {
    _cycles.add(cycle);
    notifyListeners();
  }

  void removeCycle(Cycle cycle) {
    _cycles.remove(cycle);
    notifyListeners();
  }
}