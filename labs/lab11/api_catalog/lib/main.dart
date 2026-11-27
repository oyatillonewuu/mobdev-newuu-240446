import 'package:api_catalog/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Observer extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    // ignore: avoid_print
    print(change);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    // ignore: avoid_print
    print("${bloc.runtimeType} closed");
  }
}

void main() async {
  Bloc.observer = Observer();
  runApp(const MaterialApp(home: HomeScreen()));
}
