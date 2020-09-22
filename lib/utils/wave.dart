import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import './global.dart' as Global;

class CustomWaveWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WaveWidget(
        duration: 1,
        config: CustomConfig(
          gradients: [
            [Colors.green, Color(0xEEF44336)],
            [Global.darkGreyColor, Color(0xFF59636e)],
            [Global.darkGreenColor, Color(0x66FF9800)],
            [Global.brightGreenColor, Color(0x55FFEB3B)]
          ],
          durations: [35000, 19440, 10800, 6000],
          heightPercentages: [0.20, 0.23, 0.25, 0.30],
          blur: MaskFilter.blur(BlurStyle.solid, 2),
          gradientBegin: Alignment.bottomLeft,
          gradientEnd: Alignment.topRight,
        ),
        waveAmplitude: 1.0,
        backgroundColor: Colors.white,
        size: Size(double.maxFinite, 50.0));
  }
}