import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:proteccion_civil/src/provider/ui_provider.dart';

class NavigatorBarCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);

    final currrentindex = uiProvider.selectedMenuOpt;

    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Color(0xFFFB6409),
        primaryColor: Color(0xFF2423AB),
      ),
      child: BottomNavigationBar(
        onTap: (int i) => uiProvider.selectedMenuOpt = i,
        currentIndex: currrentindex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Inicio'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.announcement_outlined,
              size: 40,
            ),
            label: 'Reportar',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.record_voice_over,
                size: 40,
              ),
              label: 'Consejos'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.info_outline_rounded,
                size: 40,
              ),
              label: 'Sobre Nosotros')
        ],
        elevation: 2,
        showUnselectedLabels: true,
        selectedItemColor: Colors.indigoAccent[900],
        unselectedItemColor: Color(0xFF2423AB),
      ),
    );
  }
}
