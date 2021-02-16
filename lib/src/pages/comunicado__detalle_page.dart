import 'package:flutter/material.dart';
import 'package:proteccion_civil/src/models/cards_model.dart';

import 'package:proteccion_civil/src/widgets/app_bar.dart';

class ComunicadoDetallePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    CardModel _comunicado = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBarCustom(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(_comunicado.titulo,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 5.0,
              ),
              Text(_comunicado.fecha,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0)),
              SizedBox(
                height: 20.0,
              ),
              Text(
                _comunicado.descripcion,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 20.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}

