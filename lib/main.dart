import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'providers/cycle_provider.dart';
import 'models/cycle.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CycleProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion du Cycle Menstruel',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestion du Cycle Menstruel'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_selectedDay != null) {
                final cycle = Cycle(startDate: _selectedDay!, endDate: _selectedDay!.add(Duration(days: 5)));
                Provider.of<CycleProvider>(context, listen: false).addCycle(cycle);
              }
            },
            child: Text('Ajouter un cycle'),
          ),
          Consumer<CycleProvider>(
            builder: (context, cycleProvider, child) {
              return Expanded(
                child: ListView.builder(
                  itemCount: cycleProvider.cycles.length,
                  itemBuilder: (context, index) {
                    final cycle = cycleProvider.cycles[index];
                    return ListTile(
                      title: Text('Cycle du ${cycle.startDate.toLocal()} au ${cycle.endDate.toLocal()}'),
                      subtitle: Text('Symptômes: ${cycle.symptoms.join(", ")}'),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}