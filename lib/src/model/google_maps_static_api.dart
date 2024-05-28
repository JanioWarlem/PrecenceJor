import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:presence_jor/src/controller/local_user_controller.dart';
import 'package:http/http.dart' as http;




class GoogleMapStatic{
  
  String buildMapUrl(String lat_long) {
    final apiKey = dotenv.env['API_KEY_WEB'];
    final center = lat_long; // Exemplo: San Francisco
    final zoom = 16;
    final size = '600x300';
    final mapType = 'roadmap';
    final markers = 'color:red|label:U|${lat_long}';

    return 'https://maps.googleapis.com/maps/api/staticmap?center=$center&zoom=$zoom&size=$size&maptype=$mapType&markers=$markers&key=$apiKey';
  }

  Future<String> imageUrl() async {
    GetLocationUser _localization =  await GetLocationUser().getLocationUserAtual();

    final url = buildMapUrl('${_localization.lat},${_localization.long}');
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return url;
    } else {
      throw Exception('Failed to load image');
    }
  }

}