import 'package:flutter/material.dart';

import 'package:proteccion_civil/src/provider/comunicados_provider.dart';
import 'package:proteccion_civil/src/widgets/cards_comunicados.dart';

class InicioPage extends StatefulWidget {
  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  final comunicadosProvider = new ComunicadosProvider();

  @override
  Widget build(BuildContext context) {
    comunicadosProvider.cargarComunicados();
    return Scaffold(
      body: Container(child: _cardsBuilder()),
    );
  }

  Widget _cardsBuilder() {
    return StreamBuilder(
      stream: comunicadosProvider.comunicadosStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final comunidados = snapshot.data;
          return CardsPersonalizada(cardsdata: comunidados);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
