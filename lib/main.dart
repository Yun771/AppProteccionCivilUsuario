import 'package:flutter/material.dart';

import 'package:proteccion_civil/src/pages/comunicado__detalle_page.dart';
import 'package:proteccion_civil/src/pages/home_page.dart';
import 'package:proteccion_civil/src/pages/reporte_form.dart';
import 'package:provider/provider.dart';
import 'package:proteccion_civil/src/provider/ui_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => new UIProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Protección Civil',
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => HomePage(),
          'reporteForm': (BuildContext context) => FormReporte(),
          'comunicadoDetalle': (BuildContext context) => ComunicadoDetallePage()
          // 'reporte': (BuildContext context) => Reporte(),
          // 'consejo': (BuildContext context) => Consejo(),
          // 'info': (BuildContext context) => Info()
        },
        theme: ThemeData(primaryColor: Color(0xFFFB6409)),
      ),
    );
  }
}
