import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'package:proteccion_civil/src/utils/utils.dart';

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
          _crearbotonRedondeado(Colors.redAccent, Icons.local_fire_department,
              'Incendio', context),
          _crearbotonRedondeado(Colors.red, Icons.report_gmailerrorred_sharp,
              'Fuga de Gas', context)
        ]),
        TableRow(children: [
          _crearbotonRedondeado(
              Colors.pinkAccent, Icons.block_sharp, 'Socavon', context),
          _crearbotonRedondeado(
              Colors.orange, Icons.fireplace, 'Quema de Basura', context)
        ]),
        TableRow(children: [
          _crearbotonRedondeado(Colors.amberAccent[700],
              Icons.bug_report_outlined, 'Abejas', context),
          _crearbotonRedondeado(
              Colors.green, Icons.gesture_rounded, 'Fauna Nociva', context)
        ]),
        TableRow(children: [
          _crearbotonRedondeado(Colors.greenAccent,
              Icons.settings_remote_rounded, 'Otro', context),
          _crearbotonRedondeado(
              Colors.green, Icons.phone, 'Llamar Directamente', context)
        ])
      ],
    );
  }

  Widget _crearbotonRedondeado(
      Color color, IconData icono, String texto, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (texto == 'Llamar Directamente') {
          _callPCNumber();
        } else {
          Navigator.of(context).pushNamed('reporteForm', arguments: texto);
        }
      },
      child: ClipRect(
        child: Container(
          height: 180.0,
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Colors.black, width: 0.5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 35.0,
                child: Icon(
                  icono,
                  color: color,
                  size: 30.0,
                ),
              ),
              Text(
                texto,
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}

_callPCNumber() async {
  const number = '7828263403'; //set the number here
  await FlutterPhoneDirectCaller.callNumber(number);
}
