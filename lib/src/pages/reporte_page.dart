import 'dart:ui';

import 'package:flutter/material.dart';

class ReportePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      // _fondoApp(),
      SingleChildScrollView(
        child: Column(
          children: <Widget>[_titulos(), _botonesRedondeados(context)],
        ),
      )
    ]);
  }

  Widget _fondoApp() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset(0.0, 0.6),
              end: FractionalOffset(0.0, 1.5),
              colors: [
            Color.fromRGBO(255, 255, 255, 1.0),
            Color.fromRGBO(124, 124, 124, 1.0)
          ])),
    );
  }

  Widget _titulos() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Reportar',
            style: TextStyle(
                color: Colors.black,
                fontSize: 30.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _botonesRedondeados(BuildContext context) {
    return Table(
      children: <TableRow>[
        TableRow(children: [
          _crearbotonRedondeado(
              Colors.redAccent, Icons.fireplace, 'Incendio', context),
          _crearbotonRedondeado(
              Colors.purple, Icons.directions_bus, 'Fuga de Gas', context)
        ]),
        TableRow(children: [
          _crearbotonRedondeado(
              Colors.pinkAccent, Icons.shop, 'Socavon', context),
          _crearbotonRedondeado(Colors.orange, Icons.insert_chart_outlined,
              'Quema de Basura', context)
        ]),
        TableRow(children: [
          _crearbotonRedondeado(
              Colors.lime, Icons.bug_report_outlined, 'Abejas', context),
          _crearbotonRedondeado(
              Colors.green, Icons.gesture_rounded, 'Fauna Nociva', context)
        ]),
      ],
    );
  }

  Widget _crearbotonRedondeado(
      Color color, IconData icono, String texto, BuildContext context) {
        
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('reporteForm', arguments: texto);
      },
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            height: 180.0,
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: Color.fromRGBO(120, 120, 120, 0.3),
                borderRadius: BorderRadius.circular(20.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: color,
                  radius: 35.0,
                  child: Icon(
                    icono,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
                Text(
                  texto,
                  style: TextStyle(color: color),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
