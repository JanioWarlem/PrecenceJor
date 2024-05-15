import 'package:flutter/material.dart';
//
// MENSAGEM DE ERRO
//
void erro(context, String msg) {
  OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 200.0,
            height: 200.0,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Center(
              child: Column(
                children: [
                  Icon(Icons.warning, color: Color.fromARGB(255, 255, 0, 0), size: 100,),
                  Text(
                    msg,
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    overlayState.insert(overlayEntry);

    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
}

//
// MENSAGEM DE SUCESSO
//
void sucesso(BuildContext context, String msg) {
  OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 200.0,
            height: 200.0,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Center(
              child: Column(
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 100,),
                  Text(
                    msg,
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    overlayState.insert(overlayEntry);

    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
}

