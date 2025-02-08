import 'package:flutter/material.dart';


const colors = <Color>[
  Colors.blueAccent,
  Colors.redAccent,
  Colors.purpleAccent,
  Colors.lightBlueAccent,
  Colors.amberAccent
];


class AppTheme {

  final int selectedColorIndex;

  const AppTheme({
    int colorIndex = 0
  }):
    assert( colorIndex < colors.length, 'index de AppTheme incorrecto' ),
    selectedColorIndex = colorIndex;


  ThemeData getTheme(){
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: colors[selectedColorIndex],
    );
  }

}