import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:proteccion_civil/src/models/reporte_model.dart';

class ReporteProvider {
  final _url = 'https://dbpcpr-default-rtdb.firebaseio.com/';

  Future<bool> enviarReporte(ReporteModel reporte) async {
    final url = '$_url/Reportes.json';
    final resp = await http.post(url, body: reporteModelToJson(reporte));

    final decodata = json.decode(resp.body);

    print(decodata);
    return true;
  }
}
