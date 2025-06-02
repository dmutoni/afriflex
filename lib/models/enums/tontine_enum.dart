enum ETontineStatus {
  active('ACTIVE'),
  completed('COMPLETED'),
  cancelled('CANCELLED');

  final String name;

  const ETontineStatus(this.name);
}

enum ETontineFrequency {
  weekly('WEEKLY'),
  biweekly('BIWEEKLY'),
  monthly('MONTHLY'),
  quarterly('QUARTERLY'),
  yearly('YEARLY');

  final String name;

  const ETontineFrequency(this.name);

  @override
  String toString() => name;
}