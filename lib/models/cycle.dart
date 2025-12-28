class Cycle {
  DateTime startDate;
  DateTime endDate;
  List<String> symptoms;

  Cycle({
    required this.startDate,
    required this.endDate,
    this.symptoms = const [],
  });
}