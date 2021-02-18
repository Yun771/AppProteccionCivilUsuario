import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:proteccion_civil/src/models/reporte_model.dart';
import 'package:proteccion_civil/src/provider/reporte_provider.dart';
import 'package:proteccion_civil/src/utils/utils.dart';
import 'package:proteccion_civil/src/widgets/app_bar.dart';

class FormReporte extends StatefulWidget {
  @override
  _FormReporteState createState() => _FormReporteState();
}

class _FormReporteState extends State<FormReporte> {
  TextEditingController _textEditControllerDireccion = TextEditingController();
  TextEditingController _textEditControllerTipoReporte =
      TextEditingController();
  String _direccion;
  Position _posicionObtenida = Position();
  Completer<GoogleMapController> _mapController = Completer();
  ScrollController _scrollController = new ScrollController();
  ReporteModel reporte = new ReporteModel();

  Set<Marker> markers = new Set<Marker>();

  var _position =
      CameraPosition(target: LatLng(20.531419, -97.453338), zoom: 13);
  final reportePovider = new ReporteProvider();
  final formKey = GlobalKey<FormState>();
  final scaffKeyRe = GlobalKey<ScaffoldState>();

  bool _disableTextField = false;

  @override
  Widget build(BuildContext context) {
    String _tipoReporte = ModalRoute.of(context).settings.arguments;
    reporte.tipoReporte = _tipoReporte;

    _textEditControllerTipoReporte.text = _tipoReporte;

    if (_tipoReporte == 'Otro') {
      _disableTextField = true;
      _textEditControllerTipoReporte.text = '';
    }

    return Scaffold(
        key: scaffKeyRe,
        appBar: AppBarCustom(),
        body: _cuerpoForm(_tipoReporte));
  }

  Widget _cuerpoForm(String titulo) {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(titulo,
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 15.0),
                _crearInputName(),
                Divider(),
                _crearInputTipoReporte(),
                Divider(),
                _crearInputTelefono(),
                Divider(),
                _crearInputDireccion(),
                SizedBox(height: 10.0),
                _mapaGoogle(context),
                SizedBox(height: 10.0),
                _crearBoton()
                // _mapaGoogle(context),
              ],
            )),
      ),
    );
  }

  Widget _crearInputName() {
    return TextFormField(
        onSaved: (value) => reporte.nombreReportante = value,
        autofocus: true,
        textCapitalization: TextCapitalization.words,
        validator: (value) {
          if (value.length < 3) {
            return 'Ingrese su nombre';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Nombre del reportante',
            hintText: 'Nombre del reportante',
            helperText: 'Nombre Completo',
            icon: Icon(Icons.account_circle_rounded)));
  }

  Widget _crearInputTipoReporte() {
    return TextFormField(
        enabled: _disableTextField,
        controller: _textEditControllerTipoReporte,
        onSaved: (value) => reporte.tipoReporte = value,
        autofocus: true,
        textCapitalization: TextCapitalization.words,
        validator: (value) {
          if (value.length < 3) {
            return 'Ingrese el tipo de reporte';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Tipo de Reporte',
            hintText: 'Tipo de Reporte',
            helperText: 'Tipo de Reporte',
            icon: Icon(Icons.article_rounded)));
  }

  Widget _crearInputTelefono() {
    return TextFormField(
        onSaved: (valor) => reporte.telefono = int.parse(valor),
        keyboardType: TextInputType.phone,
        textCapitalization: TextCapitalization.words,
        validator: (value) {
          String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
          RegExp regExp = new RegExp(patttern);
          if (value.length == 0) {
            return 'Inserte un número de teléfono';
          } else if (!regExp.hasMatch(value)) {
            return 'Inserte un número de teléfono valido';
          }
          {
            return null;
          }
        },
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Teléfono',
            hintText: 'Número de telefono',
            helperText: 'Número de Telefono',
            icon: Icon(Icons.phone_android)));
  }

  Widget _crearInputDireccion() {
    return ListTile(
      trailing: FlatButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        color: Color(0xFFFB6409),
        minWidth: 5.0,
        onPressed: () {
          _myPosition();
        },
        child: Icon(
          Icons.location_on,
          size: 20.0,
          color: Colors.white,
        ),
      ),
      title: TextFormField(
        readOnly: true,
        validator: (value) {
          if (value.isEmpty) {
            return 'Presionel botón para obtener su dirección';
          } else {
            return null;
          }
        },
        onSaved: (valor) => reporte.direccion = valor,
        controller: _textEditControllerDireccion,
        keyboardType: TextInputType.streetAddress,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          labelText: 'Direccion',
          hintText: 'Dirección',
          helperText: 'Dirección del evento',
          icon: Icon(Icons.room_outlined),
        ),
      ),
    );
  }

  Widget _mapaGoogle(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      height: 300,
      width: double.infinity,
      child: GoogleMap(
        scrollGesturesEnabled: false,
        zoomControlsEnabled: false,
        markers: markers,
        onLongPress: (argument) {
          print(argument);
        },
        myLocationEnabled: false,
        initialCameraPosition: _position,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _mapController.complete(controller);
        },
      ),
    );
  }

  _myPosition() async {
    _posicionObtenida = await determinePosition();

    final GoogleMapController controller = await _mapController.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        zoom: 15.0,
        target:
            LatLng(_posicionObtenida.latitude, _posicionObtenida.longitude))));

    markers.add(new Marker(
        markerId: MarkerId(UniqueKey().toString()),
        position:
            LatLng(_posicionObtenida.latitude, _posicionObtenida.longitude)));

    _direccion = _posicionObtenida.latitude.toString() +
        ',' +
        _posicionObtenida.longitude.toString();

    setState(() {});

    if (_direccion != null) {
      _textEditControllerDireccion.text = _direccion;
    }
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
        label: Text('Enviar'),
        color: Color(0xFFFB6409),
        textColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        icon: Icon(Icons.send),
        onPressed: _submit);
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();

    reporte.fecha = getDate();

    bool enviado = await reportePovider.enviarReporte(reporte);

    FocusScope.of(context).requestFocus(FocusNode());

    if (enviado == true) {
      Navigator.popAndPushNamed(context, '/');
    } else {
      mostrarSnackBar('No se pudo enviar el reporte');
    }
  }

  void mostrarSnackBar(String mensaje) {
    final snacbark = SnackBar(
      content: Text(
        mensaje,
        textAlign: TextAlign.center,
      ),
      duration: Duration(milliseconds: 1500),
    );

    scaffKeyRe.currentState.showSnackBar(snacbark);
  }

  // _mostrarAlert(BuildContext context, String msj) {
  //   showDialog(
  //       context: context,
  //       barrierDismissible: true,
  //       builder: (context) {
  //         return AlertDialog(
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(20.0)),
  //           title: Text('Mensaje'),
  //           content: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: <Widget>[
  //               Text(msj),
  //             ],
  //           ),
  //           actionsOverflowButtonSpacing: 20,
  //           actions: <Widget>[
  //             FlatButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: Text('Cancelar')),
  //             FlatButton(
  //                 onPressed: () {
  //                   _submit();
  //                 },
  //                 child: Text('Ok'))
  //           ],
  //         );
  //       });
  // }
}
