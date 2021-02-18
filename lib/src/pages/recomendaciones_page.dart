import 'package:flutter/material.dart';
import 'package:proteccion_civil/src/provider/recomendaciones_provider.dart';
import 'package:proteccion_civil/src/widgets/cards_comunicados.dart';

class RecomendacionPage extends StatefulWidget {
  @override
  _RecomenacionPageState createState() => _RecomenacionPageState();
}

class _RecomenacionPageState extends State<RecomendacionPage> {
  final recomendacionesProvider = new RecomendacionProvider();

  @override
  void initState() {
    recomendacionesProvider.cargarRecomendaciones();
    super.initState();
  }

  @override
  void dispose() {
    recomendacionesProvider.dispoStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: _cardsBuilder()),
    );
  }

  Widget _cardsBuilder() {
    return StreamBuilder(
      stream: recomendacionesProvider.recomendacionesStream,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
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
