import 'package:flutter/material.dart';

import '../models/cart.dart';
import '../widgets/cart_body.dart';

class SetStateCartPage extends StatefulWidget {
  const SetStateCartPage({super.key});
  @override
  State<SetStateCartPage> createState() => _SetStateCartPageState();
}

class _SetStateCartPageState extends State<SetStateCartPage> {
  CartState _cartState = CartState(lines: []);
  final List<CartState> _history = [];

  void _saveCurrentStateToHistory() {
    if (_cartState.checkoutStatus == CheckoutStatus.idle) {
      _history.add(_cartState);
    }
  }

  void _onUndo() {
    if (_cartState.checkoutStatus == CheckoutStatus.idle &&
        _history.isNotEmpty) {
      setState(() {
        final prevState = _history.removeLast();
        _cartState = prevState;
      });
    }
  }

  void _add(Product p) {
    _saveCurrentStateToHistory();
    setState(
      () => _cartState = _cartState.copyWith(
        lines: _cartState.lines.withProduct(p),
      ),
    );
  }

  void _remove(String id) {
    _saveCurrentStateToHistory();
    setState(
      () =>
          _cartState = _cartState.copyWith(lines: _cartState.lines.without(id)),
    );
  }

  void _onClearCart() => setState(() => CartState(lines: []));

  void _onChangeQty(String productId, int delta) {
    _saveCurrentStateToHistory();
    setState(
      () => _cartState = _cartState.copyWith(
        lines: _cartState.lines.changeQty(productId, delta),
      ),
    );
  }

  void _onCouponApplied(String coupon) {
    _saveCurrentStateToHistory();
    setState(() => _cartState = _cartState.copyWith(coupon: coupon));
  }

  void _onCheckoutSubmitted() => setState(
    () => _cartState = _cartState.copyWith(
      checkoutStatus: CheckoutStatus.submitted,
    ),
  );

  void _onCheckoutFinished(
    String? orderId,
    String? checkoutError,
    CheckoutStatus checkoutStatus,
  ) => setState(
    () => _cartState = _cartState.copyWith(
      orderId: orderId,
      checkoutError: checkoutError,
      checkoutStatus: checkoutStatus,
    ),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Cart · setState'),
      actions: [
        TextButton(
          onPressed:
              (_cartState.checkoutStatus != CheckoutStatus.idle ||
                  _history.isEmpty)
              ? null
              : _onUndo,
          child: const Text("Undo"),
        ),
      ],
    ),
    body: CartBody(
      cartState: _cartState,
      onAdd: _add,
      onChangeQty: _onChangeQty,
      onRemove: _remove,
      onApplyCoupon: _onCouponApplied,
      onCheckoutSubmitted: _onCheckoutSubmitted,
      onCheckoutFinished: _onCheckoutFinished,
      onClearCart: _onClearCart,
    ),
  );
  // 2.
  // 3.
}
