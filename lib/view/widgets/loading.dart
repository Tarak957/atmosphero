import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget loading() {
  return SizedBox(
    height: 200,
    width: 200,
    child: Lottie.asset('assets/lotties/loader.json'),
  );
}
