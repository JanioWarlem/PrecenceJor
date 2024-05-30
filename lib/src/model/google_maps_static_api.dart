class GoogleMapStatic{
  
  static String buildMapUrl(String lat_long) {
    
    //final apiKey = dotenv.env['API_KEY_WEB'];
    final center = lat_long; // Exemplo: San Francisco
    final zoom = 16;
    final size = '600x300';
    final mapType = 'roadmap';
    final markers = 'color:red|label:U|${lat_long}';


    //
    //Tentar tirar a api diretamente do código
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$center&zoom=$zoom&size=$size&maptype=$mapType&markers=$markers&key=AIzaSyDM0deyopTZfOOsmS1KqITEpcXjbensI_Q';
  }


}