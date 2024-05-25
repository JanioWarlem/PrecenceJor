import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:convert'; // Para trabalhar com JSON, se necessário


class GoogleMapStatic{
  

  Future<String> fetchImageUrl() async {
  final response = await http.get(Uri.parse("https://maps.googleapis.com/maps/api/staticmap?center=63.259591,-144.667969&zoom=6&size=400x400&markers=color:blue%7Clabel:S%7C62.107733,-145.541936&markers=size:tiny%7Ccolor:green%7CDelta+Junction,AK&markers=size:mid%7Ccolor:0xFFFF00%7Clabel:C%7CTok,AK%22&key=AIzaSyA-PkG7t5BdD86gLKxcSFpKrJet_GkSw8s"));

  if (response.statusCode == 200) {
    // Supondo que a API retorna um JSON com a URL da imagem
    final data = jsonDecode(response.body);
    return data['imageUrl']; // Mude 'imageUrl' para o campo correto da sua API
  } else {
    throw Exception('Failed to load image');
  }
}





}