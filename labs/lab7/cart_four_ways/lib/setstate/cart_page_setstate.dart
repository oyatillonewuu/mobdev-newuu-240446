import 'package:flutter/material.dart';

import '../models/cart.dart';
import '../widgets/cart_body.dart';

class SetStateCartPage extends StatefulWidget {
  const SetStateCartPage({super.key});
  @override
  State<SetStateCartPage> createState() => _SetStateCartPageState();
}

class _SetStateCartPageState extends State<SetStateCartPage> {
  List<CartLine> _lines = const [];
  // 1. state is a field on the State object
  void _add(Product p) => setState(() => _lines = _lines.withProduct(p));
  void _onChangeQty(String productId, int delta) =>
      setState(() => _lines = _lines.changeQty(productId, delta));
  void _remove(String id) => setState(() => _lines = _lines.without(id));
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Cart · setState')),
    body: CartBody(
      lines: _lines,
      onAdd: _add,
      onChangeQty: _onChangeQty,
      onRemove: _remove,
    ),
  );
  // 2.
  // 3.
}
