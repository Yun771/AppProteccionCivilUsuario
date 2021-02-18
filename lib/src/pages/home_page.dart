import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// * Son las imprtaciones de las otras pantallas
import 'package:proteccion_civil/src/widgets/app_bar.dart';
import 'package:proteccion_civil/src/widgets/Home_body.dart';
import 'package:proteccion_civil/src/provider/ui_provider.dart';
import 'package:proteccion_civil/src/widgets/Navigator_bar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ui_provider = Provider.of<UIProvider>(context);
    return Scaffold(      
      appBar: AppBarCustom(),
      body: HomePageBody(),
      bottomNavigationBar: NavigatorBarCustom(),
    );
  }
}
