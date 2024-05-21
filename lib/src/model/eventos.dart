import 'package:cloud_firestore/cloud_firestore.dart';

class Eventos {
  final String title;
  final String description;
  final DateTime date;
  final String location;

  Eventos({
    required this.title,
    required this.description,
    required this.date,
    required this.location,
  });

  // Transformar um JSON em um objeto
  factory Eventos.fromJson(Map<String, dynamic> json) {
    return Eventos(
      title: json['title'] as String,
      description: json['description'] as String,
      date: (json['date'] as Timestamp).toDate(),
      location: json['location'] as String,
    );
  }

  // Transformar um objeto em JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'location': location,
    };
  }
}
