import 'package:cloud_firestore/cloud_firestore.dart';

class Eventos {
  final String title;
  final String description;
  final DateTime date;
  final String location;
  Map<String, dynamic> inscritos; // Campo para inscrições

  Eventos({
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    this.inscritos = const {}, // Inicializa como um mapa vazio
  });

  // Transformar um JSON em um objeto
  factory Eventos.fromJson(Map<String, dynamic> json) {
    return Eventos(
      title: json['title'] as String,
      description: json['description'] as String,
      date: (json['date'] as Timestamp).toDate(),
      location: json['location'] as String,
      inscritos: json['inscritos'] as Map<String, dynamic>? ?? {}, // Desserializar inscrições ou inicializar como vazio
    );
  }

  // Transformar um objeto em JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'location': location,
      'inscritos': inscritos, // Serializar inscrições
    };
  }
}
