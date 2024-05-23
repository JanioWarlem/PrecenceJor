import 'package:geolocator/geolocator.dart';

class GetLocationUser{
  double lat = 0;
  double long = 0;
  String erro = '';

  Future <GetLocationUser> getLocationUserAtual() async{
    await getPosicao();
    return this;
  }

  getPosicao() async{
    try{
      Position posicao = await _posicaoAtual();
      lat = posicao.latitude;
      long = posicao.longitude;
    }catch(e){
      erro = e.toString();
    }
  }

  Future<Position> _posicaoAtual() async {
    LocationPermission permissao;
    bool isAtivado = await Geolocator.isLocationServiceEnabled();

    if(! isAtivado){
      return Future.error("Por favor, ative a localização");
    }

    permissao = await Geolocator.checkPermission();
    if(permissao == LocationPermission.denied){
      permissao = await Geolocator.requestPermission();
      if(permissao == LocationPermission.denied){
        return Future.error("Por favor, autorizeo acesso a localização");
      }
    }

    if (permissao == LocationPermission.deniedForever){
      return Future.error("Por favor, autorizeo acesso a localização");
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
  
}