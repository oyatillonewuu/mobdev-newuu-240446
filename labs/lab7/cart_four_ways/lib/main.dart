import 'package:cart_four_ways/bloc/cart_page_bloc.dart';
import 'package:cart_four_ways/cubit/cart_page_cubit.dart';
import 'package:cart_four_ways/riverpod/cart_page_riverpod.dart';
import 'package:cart_four_ways/setstate/cart_page_setstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: const HomePage()));
}

class HomePage extends StatelessWidget {
  final hey = "hey";
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("4 managers")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              ManagerOpenerButton(
                managerName: "SetState",
                buildPageCallback: () => const SetStateCartPage(),
              ),
              ManagerOpenerButton(
                managerName: "Riverpod",
                buildPageCallback: () => const RiverpodCartPage(),
              ),
              ManagerOpenerButton(
                managerName: "Bloc",
                buildPageCallback: () => const BlocCartPage(),
              ),
              ManagerOpenerButton(
                managerName: "Cubit",
                buildPageCallback: () => const CubitCartPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ManagerOpenerButton extends StatelessWidget {
  const ManagerOpenerButton({
    super.key,
    required this.managerName,
    required this.buildPageCallback,
  });

  final String managerName;
  final Widget Function() buildPageCallback;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => buildPageCallback()),
        ),
      },
      child: Text(managerName),
    );
  }
}
