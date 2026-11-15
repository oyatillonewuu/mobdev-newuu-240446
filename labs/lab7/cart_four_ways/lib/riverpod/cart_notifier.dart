import 'package:cart_four_ways/services/checkout_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/cart.dart';

class CartNotifier extends Notifier<CartState> {
  var _history = <CartState>[];

  List<CartState> get history => _history;

  @override
  CartState build() => CartState(lines: []);
  void _saveCurrentStateToHistory() {
    if (state.checkoutStatus == CheckoutStatus.idle) {
      _history.add(state);
    }
  }

  void add(Product p) {
    _saveCurrentStateToHistory();
    state = state.copyWith(lines: state.lines.withProduct(p));
  }

  void remove(String id) {
    _saveCurrentStateToHistory();
    state = state.copyWith(lines: state.lines.without(id));
  }

  void onClearCartIncludingHistory() {
    _history = <CartState>[];
    state = CartState(lines: []);
  }

  void changeQty(String id, int delta) {
    _saveCurrentStateToHistory();
    state = state.copyWith(lines: state.lines.changeQty(id, delta));
  }

  void onCouponApplied(String coupon) {
    _saveCurrentStateToHistory();
    state = state.copyWith(coupon: coupon);
  }

  Future<void> onCheckout() async {
    state = state.copyWith(checkoutStatus: CheckoutStatus.submitted);
    try {
      final result = await ref.read(checkoutApiProvider).submit(state.total);
      state = state.copyWith(
        orderId: result,
        checkoutStatus: CheckoutStatus.success,
      );
    } on CheckoutException catch (e) {
      state = state.copyWith(
        checkoutError: e.toString(),
        checkoutStatus: CheckoutStatus.failure,
      );
    }
  }

  void undo() {
    if (_history.isNotEmpty) {
      state = _history.removeLast();
    }
  }
}

final cartProvider = NotifierProvider.autoDispose<CartNotifier, CartState>(
  CartNotifier.new,
);

final checkoutApiProvider = Provider<CheckoutApi>((ref) => CheckoutApi());
final canUndoProvider = Provider.autoDispose<bool>((ref) {
  // Learned form Claude.ai Sonnet 5.5
  ref.watch(cartProvider); // for triggers
  final n = ref.read(cartProvider.notifier);
  return n.history.isNotEmpty;
});
