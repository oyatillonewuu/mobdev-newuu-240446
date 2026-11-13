import 'package:cart_four_ways/services/checkout_api.dart';
import 'package:flutter/material.dart';

import '../models/cart.dart';

class CartBody extends StatelessWidget {
  CartBody({
    super.key,
    required this.cartState,
    required this.onAdd,
    required this.onChangeQty,
    required this.onRemove,
    required this.onApplyCoupon,
    required this.onCheckoutSubmitted,
    required this.onCheckoutFinished,
    required this.onClearCart,
  });

  final CartState cartState;
  final void Function(Product) onAdd;
  final void Function(String, int) onChangeQty;
  final void Function(String productId) onRemove;
  final void Function(String coupon) onApplyCoupon;
  final void Function() onCheckoutSubmitted;
  final void Function(
    String? orderId,
    String? checkoutError,
    CheckoutStatus checkoutStatus,
  )
  onCheckoutFinished;
  final void Function() onClearCart;

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 8,
          children: [
            for (final p in catalog) ProductWidget(product: p, onAdd: onAdd),
          ],
        ),
      ),
      Expanded(
        child: cartState.lines.isEmpty
            ? const Center(child: Text('Cart is empty'))
            : ListView(
                children: [
                  for (final l in cartState.lines)
                    ListTile(
                      key: ValueKey(l.product.id),
                      title: Text(l.product.name),
                      subtitle: Text('× ${l.qty}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => onChangeQty(l.product.id, 1),
                          ),
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () => onChangeQty(l.product.id, -1),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
      ),
      CouponInputHandlerWidget(onApplyCoupon: onApplyCoupon),
      ListTile(
        title: const Text('Item count'),
        trailing: Text(
          cartState.itemCount.toString(),
          style: TextStyle(fontSize: 16.0),
        ),
      ),
      ListTile(
        title: const Text('Applied coupon'),
        trailing: Text(cartState.coupon ?? "(N/A)"),
      ),
      if (cartState.couponError != null)
        Text(
          "Coupon error: ${cartState.couponError}",
          style: TextStyle(color: Colors.red),
        ),
      ListTile(
        title: const Text('Subtotal'),
        trailing: Text(cartState.subtotal.toStringAsFixed(2)),
      ),
      ListTile(
        title: const Text('Discount'),
        trailing: Text(cartState.discount.toStringAsFixed(2)),
      ),
      ListTile(
        title: const Text('Total'),
        trailing: Text(cartState.total.toStringAsFixed(2)),
      ),
      ElevatedButton(
        onPressed:
            (cartState.total == 0 ||
                cartState.checkoutStatus == CheckoutStatus.submitted)
            ? null
            : () async {
                onCheckoutSubmitted();
                try {
                  final result = await CheckoutApi.submit(cartState.total);
                  if (!context.mounted) return;
                  onCheckoutFinished(result, null, CheckoutStatus.success);
                  final snackbarResult = ScaffoldMessenger.of(context)
                      .showSnackBar(
                        SnackBar(
                          content: Text(
                            "Order '$result' sucessfully checked out.",
                          ),
                        ),
                      );
                  snackbarResult.closed.then((_) => onClearCart());
                } on CheckoutException catch (e) {
                  onCheckoutFinished(
                    null,
                    e.toString(),
                    CheckoutStatus.failure,
                  );
                  ScaffoldMessenger.of(context).showMaterialBanner(
                    MaterialBanner(
                      content: Text(
                        "Failed to checkout. Error: ${e.toString()}",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () =>
                              ScaffoldMessenger.of(context)
                                  .hideCurrentMaterialBanner(),
                          child: Text('Dismiss'),
                        ),
                      ],
                    ),
                  );
                }
              },
        child: const Text("Checkout"),
      ),
      SizedBox(height: 20),
      if (cartState.checkoutStatus == CheckoutStatus.submitted)
        CircularProgressIndicator(color: Colors.green),
      SizedBox(height: 20),
    ],
  );
}

// Better than bare ActionChip for testing (to pump by more specific type).
class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key, required this.product, required this.onAdd});

  final Product product;
  final Function(Product) onAdd;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text('${product.name} · ${product.price.toStringAsFixed(0)}'),
      onPressed: () => onAdd(product),
    );
  }
}

// Granular dedicated classes make it esier to pump widgets for testing.
class CouponInputHandlerWidget extends StatelessWidget {
  CouponInputHandlerWidget({super.key, required this.onApplyCoupon});

  final void Function(String coupon) onApplyCoupon;

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 20,
      children: [
        SizedBox(width: 200, child: CouponInputWidget(controller: _controller)),
        CouponApplyButton(
          controller: _controller,
          onApplyCoupon: onApplyCoupon,
        ),
      ],
    );
  }
}

class CouponInputWidget extends StatelessWidget {
  const CouponInputWidget({super.key, required this._controller});

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Enter coupon code here",
      ),
      controller: _controller,
    );
  }
}

class CouponApplyButton extends StatelessWidget {
  const CouponApplyButton({
    super.key,
    required this._controller,
    required this.onApplyCoupon,
  });

  final void Function(String coupon) onApplyCoupon;
  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text("Apply"),
      onPressed: () {
        final coupon = _controller.text;
        _controller.clear();
        onApplyCoupon(coupon);
      },
    );
  }
}
