// import 'package:flutter/material.dart';
//
// class RiverpodCartPage extends StatelessWidget {
//   const RiverpodCartPage({super.key});
//
//   @override
//   Widget build(BuildContext context) =>
//       Scaffold(appBar: AppBar(title: const Text("Riverpod")));
// }
import 'package:cart_four_ways/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/cart_body.dart';
import 'cart_notifier.dart';

class RiverpodCartPage extends ConsumerWidget {
  const RiverpodCartPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.listen<CartState>(cartProvider, (prev, current) {
    //   debugPrint("${(prev != null) ? prev.hashCode : 0} - ${current.hashCode}");
    // });
    final cartState = ref.watch(cartProvider);
    // 3. subscribe: rebuild on change
    final cart = ref.read(cartProvider.notifier);
    final canUndo = ref.watch(canUndoProvider);

    ref.listen(cartProvider.select((c) => c.checkoutStatus), (
      prevStatus,
      currStatus,
    ) {
      final messenger = ScaffoldMessenger.of(context);

      /// We need fresh to avoid stale state which could happen if we used
      /// [cartState] above (possible if `ref.listen` fires first before rebuild happens
      /// on status change).
      final cartState = ref.read(cartProvider);

      if (currStatus == CheckoutStatus.success) {
        final snackbarResult = messenger.showSnackBar(
          SnackBar(
            content: Text(
              "Order '${cartState.orderId}' sucessfully checked out.",
            ),
          ),
        );
        snackbarResult.closed.then((_) => cart.onClearCartIncludingHistory());
      } else if (currStatus == CheckoutStatus.failure) {
        messenger.showMaterialBanner(
          MaterialBanner(
            content: Text(
              "Failed to checkout. Error: ${cartState.checkoutError.toString()}",
            ),
            actions: [
              TextButton(
                onPressed: () =>
                    ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
                child: Text('Dismiss'),
              ),
            ],
          ),
        );
      }
    });
    // 4. handle to call methods, no subscription
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart · Riverpod'),
        actions: [
          TextButton(
            onPressed: (canUndo) ? cart.undo : null,
            child: const Text("Undo"),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: CartBody(
              cartState: cartState,
              onAdd: cart.add,
              onRemove: cart.remove,
              onChangeQty: cart.changeQty,
              onApplyCoupon: cart.onCouponApplied,
              onCheckout: cart.onCheckout,
            ),
          ),
          const SummaryCardTotal(),
        ],
      ),
    );
  }
}

class SummaryCardTotal extends ConsumerWidget {
  const SummaryCardTotal({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final total = ref.watch(cartProvider.select<double>((c) => c.total));
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Summary Total",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22.0),
        ),
        Text(total.toStringAsFixed(2)),
      ],
    );
  }
}
