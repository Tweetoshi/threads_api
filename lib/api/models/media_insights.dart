class MediaInsight {
  final String name;
  final String period;
  final int value;
  final String title;
  final String description;
  final String id;

  MediaInsight({
    required this.name,
    required this.period,
    required this.value,
    required this.title,
    required this.description,
    required this.id,
  });

  factory MediaInsight.fromJson(Map<String, dynamic> json) {
    return MediaInsight(
      name: json['name'],
      period: json['period'],
      value: json['values'][0]['value'],  // Assuming values is always non-empty
      title: json['title'],
      description: json['description'],
      id: json['id'],
    );
  }
}
